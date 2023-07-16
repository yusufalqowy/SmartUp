import 'package:smartup/data/course/model/exercise_result.dart';
import 'package:smartup/presentation/auth/login/login_binding.dart';
import 'package:smartup/presentation/auth/login/login_screen.dart';
import 'package:smartup/presentation/auth/register/register_binding.dart';
import 'package:smartup/presentation/auth/register/register_screen.dart';
import 'package:smartup/presentation/course/course_binding.dart';
import 'package:smartup/presentation/course/course_screen.dart';
import 'package:smartup/presentation/exercise/exercise_list/exercise_binding.dart';
import 'package:smartup/presentation/exercise/exercise_list/exercise_screen.dart';
import 'package:smartup/presentation/exercise/exercise_question/exercise_question_binding.dart';
import 'package:smartup/presentation/exercise/exercise_question/exercise_question_screen.dart';
import 'package:smartup/presentation/exercise/exercise_result/exercise_result_screen.dart';
import 'package:smartup/presentation/main/discussion/discussion_binding.dart';
import 'package:smartup/presentation/main/discussion/discussion_screen.dart';
import 'package:smartup/presentation/main/home/home_binding.dart';
import 'package:smartup/presentation/main/main_binding.dart';
import 'package:smartup/presentation/main/main_screen.dart';
import 'package:smartup/presentation/main/profile/about/about_screen.dart';
import 'package:smartup/presentation/main/profile/edit_profile/edit_profile_binding.dart';
import 'package:smartup/presentation/main/profile/edit_profile/edit_profile_screen.dart';
import 'package:smartup/presentation/main/profile/profile_binding.dart';
import 'package:smartup/presentation/splash/splash_binding.dart';
import 'package:smartup/route/routes.dart';
import 'package:get/get.dart';

import '../presentation/splash/splash_screen.dart';

abstract class Pages {
  static final pages = [
    GetPage(name: Routes.splash, page: () => const SplashScreen(), binding: SplashBinding(), transition: Transition.leftToRightWithFade),
    GetPage(name: Routes.login, page: () => LoginScreen(), binding: LoginBinding(), transition: Transition.leftToRightWithFade),
    GetPage(name: Routes.register, page: () => const RegisterScreen(), binding: RegisterBinding(), transition: Transition.leftToRightWithFade),
    GetPage(name: Routes.main, page: () => const MainScreen(), bindings: [MainBinding(), HomeBinding(), DiscussionBinding(), ProfileBinding()], transition: Transition.leftToRightWithFade),
    GetPage(name: Routes.discussion, page: () => const DiscussionScreen(), binding: DiscussionBinding(), transition: Transition.leftToRightWithFade),
    GetPage(name: Routes.editProfile, page: () => const EditProfileScreen(), binding: EditProfileBinding(), transition: Transition.leftToRightWithFade),
    GetPage(name: Routes.course, page: () => const CourseScreen(), binding: CourseBinding(), transition: Transition.leftToRightWithFade),
    GetPage(name: Routes.exercise, page: () => const ExerciseScreen(), binding: ExerciseBinding(), transition: Transition.leftToRightWithFade, arguments: ExerciseArgs),
    GetPage(name: Routes.exerciseQuestion, page: () => const ExerciseQuestionScreen(), binding: ExerciseQuestionBinding(), transition: Transition.leftToRightWithFade, arguments: ExerciseQuestionArgs),
    GetPage(name: Routes.exerciseResult, page: () => const ExerciseResultScreen(), transition: Transition.leftToRightWithFade, arguments: Result),
    GetPage(name: Routes.aboutApp, page: () => const AboutScreen(), transition: Transition.leftToRightWithFade),
  ];
}
