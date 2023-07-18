import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as Chat;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/extensions.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_alert.dart';
import 'package:smartup/presentation/widgets/empty_item.dart';
import 'package:smartup/route/routes.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gabung ke Grup"),
          backgroundColor: colorScheme(context).primaryContainer,
        ),
        body: StreamBuilder<User?>(
          stream: FirebaseChatCore.instance.currentUser().asStream(),
          initialData: null,
          builder: (context, stream){
            if(stream.hasData && stream.data != null){
              var user = stream.data!;
              print(user.toJson());
              return StreamBuilder<List<Chat.Room>>(
                stream: FirebaseChatCore.instance
                    .groupRooms(adminId: "24sZFxLz2aeaQ7MSKL0LJ2JulB12"),
                initialData: const [],
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done || ConnectionState.active:
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Container(
                          margin: const EdgeInsets.all(Dimens.d16),
                          child: const Center(
                            child: EmptyItem(
                              title: "Belum ada grup diskusi",
                              image: ImageAssets.imgQuestionMark,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.all(Dimens.d16),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final room = snapshot.data![index];
                          final usersIds = room.users.map((e) => e.id).toList();
                          return Card(
                            margin: const EdgeInsets.only(bottom: Dimens.d8),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () {
                                if(usersIds.contains(user.id)){
                                  Get.bottomSheet(
                                      BottomSheetAlert(
                                        title: "Informasi",
                                        message: "Kamu sudah gabung di grup ini",
                                        image: SvgPicture.asset(
                                          ImageAssets.imgDiscussion,
                                          fit: BoxFit.fitHeight,
                                          height: 150,
                                        ),
                                        negativeButton: FilledButton.tonal(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Tutup"),
                                        ),
                                      ),
                                      backgroundColor: colorScheme(context).surface);
                                }else{
                                  Get.bottomSheet(
                                      BottomSheetAlert(
                                        title: 'Gabung ke Grup "${room.name}"?',
                                        image: SvgPicture.asset(
                                          ImageAssets.imgQuestionMark,
                                          fit: BoxFit.fitHeight,
                                          height: 150,
                                        ),
                                        positiveButton: FilledButton(
                                          onPressed: () {
                                            room.users.add(user);
                                            FirebaseChatCore.instance.updateRoom(room);
                                            Get.back();
                                            Get.offNamed(Routes.discussionChat, arguments: room);
                                          },
                                          child: const Text("Iya"),
                                        ),
                                        negativeButton: FilledButton.tonal(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Tidak"),
                                        ),
                                      ),
                                      backgroundColor: colorScheme(context).surface);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Row(
                                  children: [
                                    _buildAvatar(room),
                                    Text(
                                      room.name ?? '',
                                      style: TextStyles.body2Text,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return const SizedBox();
                  }
                },
              );
            }else{
              return const EmptyItem(title: "Akun kamu tidak ditemukan", subtitle: "Login terlebih dahulu untuk menggunakan fitur ini!", image: ImageAssets.imgRegister,);
            }

          },
        )
    );
  }

  Widget _buildAvatar(Chat.Room room) {
    var color = Colors.transparent;

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        foregroundColor: color,
        backgroundImage: hasImage
            ? CachedNetworkImageProvider(room.imageUrl!)
            : null,
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
