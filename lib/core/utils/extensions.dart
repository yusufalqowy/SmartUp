import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

extension StringExt on String{
  String capitalizeEachWord() {
    var result = this[0].toUpperCase();
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " ") {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
      }
    }
    return result;
  }

  String capitalizeFirst() {
    var result = this[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " " && cap == true) {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
        cap = false;
      }
    }
    return result;
  }


}

extension StringNullExt on String?{
  bool get isNullOrEmpty{
    if(this == null){
      return true;
    }else{
      if(this!.isEmpty){
        return true;
      }else{
        return false;
      }
    }
  }

  bool get isAcceptAnswer{
    if(this == null){
      return false;
    }else{
      if(this!.isEmpty){
        return false;
      }else{
        if(this == "A" || this == "B" || this == "C" || this == "D" || this == "E"){
          return true;
        }else{
          return false;
        }
      }
    }
  }
}

extension ListNullExt on List?{
  bool get isNullOrEmpty{
    if(this == null){
      return true;
    }else{
      if(this!.isEmpty){
        return true;
      }else{
        return false;
      }
    }
  }
}

extension FirebaseChatExt on FirebaseChatCore{
  Future<types.User> currentUser() async {
    final fu = firebaseUser;
    if (fu == null) return Future.error('User does not exist');

    var userJson = await fetchUser(
      getFirebaseFirestore(),
      fu.uid,
      config.usersCollectionName,
    );
    return types.User.fromJson(userJson);
  }

  Stream<List<types.Room>> groupRooms({bool orderByUpdatedAt = false, required String adminId}) {
    final fu = types.User(id: adminId);
    final collection = orderByUpdatedAt
        ? getFirebaseFirestore()
        .collection(config.roomsCollectionName)
        .where('userIds', arrayContains: adminId)
        .orderBy('updatedAt', descending: true)
        : getFirebaseFirestore()
        .collection(config.roomsCollectionName)
        .where('userIds', arrayContains: adminId);

    return collection.snapshots().asyncMap(
          (query) => processRoomsQuery(
        adminId,
        getFirebaseFirestore(),
        query,
        config.usersCollectionName,
      ),
    );
  }

  Future<List<types.Room>> processRoomsQuery(
      String adminId,
      FirebaseFirestore instance,
      QuerySnapshot<Map<String, dynamic>> query,
      String usersCollectionName,
      ) async {
    final futures = query.docs.map(
          (doc) => processRoomDocument(
        doc,
        adminId,
        instance,
        usersCollectionName,
      ),
    );

    return await Future.wait(futures);
  }

  /// Returns a [types.Room] created from Firebase document.
  Future<types.Room> processRoomDocument(
      DocumentSnapshot<Map<String, dynamic>> doc,
      String adminId,
      FirebaseFirestore instance,
      String usersCollectionName,
      ) async {
    final data = doc.data()!;

    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
    data['id'] = doc.id;
    data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

    var imageUrl = data['imageUrl'] as String?;
    var name = data['name'] as String?;
    final type = data['type'] as String;
    final userIds = data['userIds'] as List<dynamic>;
    final userRoles = data['userRoles'] as Map<String, dynamic>?;

    final users = await Future.wait(
      userIds.map(
            (userId) => fetchUser(
          instance,
          userId as String,
          usersCollectionName,
          role: userRoles?[userId] as String?,
        ),
      ),
    );

    if (type == types.RoomType.direct.toShortString()) {
      try {
        final otherUser = users.firstWhere(
              (u) => u['id'] != adminId,
        );

        imageUrl = otherUser['imageUrl'] as String?;
        name = '${otherUser['firstName'] ?? ''} ${otherUser['lastName'] ?? ''}'
            .trim();
      } catch (e) {
        // Do nothing if other user is not found, because he should be found.
        // Consider falling back to some default values.
      }
    }

    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['users'] = users;

    if (data['lastMessages'] != null) {
      final lastMessages = data['lastMessages'].map((lm) {
        final author = users.firstWhere(
              (u) => u['id'] == lm['authorId'],
          orElse: () => {'id': lm['authorId'] as String},
        );

        lm['author'] = author;
        lm['createdAt'] = lm['createdAt']?.millisecondsSinceEpoch;
        lm['id'] = lm['id'] ?? '';
        lm['updatedAt'] = lm['updatedAt']?.millisecondsSinceEpoch;

        return lm;
      }).toList();

      data['lastMessages'] = lastMessages;
    }

    return types.Room.fromJson(data);
  }
}
