import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as Chat;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/functions.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';
import 'package:smartup/presentation/widgets/empty_item.dart';
import 'package:smartup/presentation/widgets/svg_icon.dart';
import 'package:smartup/route/routes.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  FirebaseAuthService authService = Get.find();
  bool _error = false;
  bool _initialized = false;
  User? _user;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grup Diskusi"), backgroundColor: colorScheme(context).primaryContainer,),
      body: authService.getCurrentSignedInUserEmail() != null
          ? StreamBuilder<List<Chat.Room>>(
          stream: FirebaseChatCore.instance.rooms(),
          initialData: const [],
          builder: (context, snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.done || ConnectionState.active:
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    margin: const EdgeInsets.all(Dimens.d16),
                    child: const Center(
                      child: EmptyItem(title: "Kamu belum gabung di grup diskusi manapun", subtitle: "Ayo gabung ke grup diskusi sekarang!", image: ImageAssets.imgDiscussion,),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(Dimens.d16),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final room = snapshot.data![index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: Dimens.d8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.discussionChat, arguments: room);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              _buildAvatar(room),
                              Text(room.name ?? '', style: TextStyles.body2Text,),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator(),);
              default:
                return const SizedBox();
            }

          })
          : const EmptyItem(title: "Akun kamu tidak ditemukan", subtitle: "Login terlebih dahulu untuk menggunakan fitur ini!", image: ImageAssets.imgRegister,),
      floatingActionButton: FloatingActionButton(shape: const CircleBorder(), onPressed: () => Get.toNamed(Routes.discussionGroup), child: SvgIconAsset(assetName: ImageAssets.icGroupMessage, color: colorScheme(context).onSurface,),),
    );
  }

  void initializeFlutterFire() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _user = user;
        });
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  Widget _buildAvatar(Chat.Room room) {
    var color = Colors.transparent;

    if (room.type == Chat.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
              (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found.
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        foregroundColor: color,
        backgroundImage: hasImage ? CachedNetworkImageProvider(room.imageUrl!) : null,
        child: !hasImage
            ? Text(
          name.isEmpty ? '' : name[0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        )
            : null,
      ),
    );
  }
}

