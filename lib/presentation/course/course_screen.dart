import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/extensions.dart';
import 'package:smartup/core/values/constants.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';
import 'package:smartup/presentation/widgets/course_item.dart';
import 'package:smartup/presentation/widgets/course_skeleton.dart';
import 'package:smartup/presentation/widgets/empty_item.dart';
import 'package:smartup/presentation/widgets/gap.dart';

import 'course_controller.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  CourseController courseController = Get.find();
  var storage = Get.find<GetStorage>();
  final FirebaseAuthService firebaseAuthService = Get.find();


  @override
  void initState() {
    courseController.getCourses(
        email: firebaseAuthService.getCurrentSignedInUserEmail() ?? "", majorName: Constants.majorName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Pelajaran"),
        backgroundColor: colorScheme(context).primaryContainer,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return courseController.getCourses(
              email: firebaseAuthService.getCurrentSignedInUserEmail() ?? "",
              majorName: Constants.majorName);
        },
        child: GetBuilder<CourseController>(builder: (controller) {
          if (controller.courseResponseState.value.status.isSuccess) {
            var courses = controller.courseResponseState.value.data;
            if (!courses.isNullOrEmpty) {
              return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(Dimens.d16),
                  primary: false,
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var courseData = courses[index];
                    return CourseItem(
                      courseData: courseData,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(
                      h: Dimens.d8,
                    );
                  },
                  itemCount: courses!.length);
            } else {
              return const EmptyItem();
            }
          } else if (controller.courseResponseState.value.status.isError) {
            return Container(
              margin: const EdgeInsets.all(Dimens.d16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Gagal memuat data",
                      style: TextStyles.body2Text,
                    ),
                    TextButton.icon(
                      onPressed: () => controller.getCourses(
                          email: firebaseAuthService.getCurrentSignedInUserEmail() ?? ""),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Refresh"),
                    )
                  ],
                ),
              ),
            );
          } else {
            return ListView.separated(
                padding: const EdgeInsets.all(Dimens.d16),
                primary: false,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const CourseSkeleton();
                },
                separatorBuilder: (context, index) {
                  return const Gap(
                    h: Dimens.d8,
                  );
                },
                itemCount: 8);
          }
        }),
      ),
    );
  }
}
