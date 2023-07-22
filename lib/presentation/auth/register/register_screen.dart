import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/dialog.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/enums.dart';
import 'package:smartup/core/values/images.dart';
import 'package:smartup/core/values/keys.dart';
import 'package:smartup/core/values/texts.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/core/services/firebase_auth_service.dart';
import 'package:smartup/data/user/model/register_user_request.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_alert.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_degree.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_gender.dart';
import 'package:smartup/presentation/widgets/gap.dart';
import 'package:smartup/route/routes.dart';

import 'register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  var selectGender = Gender.none;
  var genderController = TextEditingController();
  var selectedDegree = Degree.NONE;
  var degreeController = TextEditingController();
  var firebaseAuth = Get.find<FirebaseAuthService>();
  User? userEmail = Get.arguments;
  GetStorage storage = Get.find();

  void handleResponse(RegisterController controller, BuildContext context) {
    var userResponse = controller.register.value;
    switch (userResponse.status) {
      case NetworkStatus.loading:
        LoadingDialog.showLoading();
        break;
      case NetworkStatus.success:
        LoadingDialog.dismissLoading();
        userResponse.data?.encodeToJson();
        storage.write(Keys.userData, userResponse.data?.encodeToJson());
        Future.delayed(600.milliseconds,()=>Get.offAllNamed(Routes.main));
        break;
      case NetworkStatus.error:
        LoadingDialog.dismissLoading();
        Get.bottomSheet(
            BottomSheetAlert(
              title: "Error",
              message: userResponse.message ?? "Unknown Error",
              image: SvgPicture.asset(
                ImageAssets.imgSorry,
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
        break;
      default:
        LoadingDialog.dismissLoading();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      Future.delayed(Duration.zero, ()=>handleResponse(controller, context));
      return Scaffold(
        appBar: AppBar(
          title: const Text(Texts.textDaftarAkun),
          backgroundColor: colorScheme(context).primaryContainer,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimens.d16),
            child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(Texts.textYukIsiData, style: TextStyles
                        .highlightText,),
                    const Gap(
                      h: Dimens.d16,
                    ),
                    const Text(
                      Texts.textNamaLengkap,
                      style: TextStyles.title,
                    ),
                    const Gap(
                      h: Dimens.d8,
                    ),
                    FormBuilderTextField(
                      name: Texts.textNamaLengkap,
                      initialValue: userEmail?.displayName,
                      decoration: InputDecoration(
                        fillColor:
                        colorScheme(context).surfaceVariant.withOpacity(0.4),
                        filled: true,
                        prefixIcon: const Icon(Icons.person),
                        hintText: Texts.textHintNamaLengkap,
                        hintStyle: TextStyles.body2Text,
                        focusedBorder: null,
                        contentPadding: const EdgeInsets.all(Dimens.d8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.d8),
                        ),
                      ),
                      textCapitalization: TextCapitalization.words,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.required(
                          errorText: Texts.textErrorRequired),
                    ),
                    const Gap(),
                    const Text(
                      Texts.textEmail,
                      style: TextStyles.title,
                    ),
                    const Gap(
                      h: Dimens.d8,
                    ),
                    FormBuilderTextField(
                        name: Texts.textEmail,
                        initialValue: userEmail?.email,
                        readOnly: userEmail?.email != null,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: colorScheme(context)
                              .surfaceVariant
                              .withOpacity(0.4),
                          filled: true,
                          prefixIcon: const Icon(Icons.mail),
                          hintText: Texts.textHintEmail,
                          hintStyle: TextStyles.body2Text,
                          labelStyle: TextStyles.body2Text,
                          focusedBorder: null,
                          contentPadding: const EdgeInsets.all(Dimens.d8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.d8),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: Texts.textErrorRequired),
                          FormBuilderValidators.email(
                              errorText: Texts.textErrorEmail),
                        ])),
                    const Gap(),
                    const Text(
                      Texts.textJenisKelamin,
                      style: TextStyles.title,
                    ),
                    const Gap(
                      h: Dimens.d8,
                    ),
                    FormBuilderTextField(
                      name: Texts.textJenisKelamin,
                      controller: genderController,
                      readOnly: true,
                      onTap: () async {
                        Gender? gender = await Get.bottomSheet(
                          BottomSheetSelectGender(
                            initGender: selectGender,
                          ),
                          backgroundColor: colorScheme(context).surface,
                        );
                        if (gender != null) {
                          selectGender = gender;
                          genderController.text = gender.value;
                        }
                      },
                      decoration: InputDecoration(
                        fillColor:
                        colorScheme(context).surfaceVariant.withOpacity(0.4),
                        filled: true,
                        prefixIcon: const Icon(Icons.people_alt),
                        hintText: Texts.textHintJenisKelamin,
                        hintStyle: TextStyles.body2Text,
                        labelStyle: TextStyles.body2Text,
                        focusedBorder: null,
                        contentPadding: const EdgeInsets.all(Dimens.d8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.d8),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.required(
                          errorText: Texts.textErrorRequired),
                    ),
                    const Gap(),
                    const Text(
                      Texts.textJenjang,
                      style: TextStyles.title,
                    ),
                    const Gap(
                      h: Dimens.d8,
                    ),
                    FormBuilderTextField(
                        name: Texts.textJenjang,
                        onTap: () async {
                          Degree? degree = await Get.bottomSheet(
                              BottomSheetSelectDegree(
                                initDegree: selectedDegree,),
                              backgroundColor: colorScheme(context).surface);
                          if (degree != null) {
                            selectedDegree = degree;
                            degreeController.text = degree.name;
                          }
                        },
                        controller: degreeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          fillColor: colorScheme(context)
                              .surfaceVariant
                              .withOpacity(0.4),
                          filled: true,
                          prefixIcon: const Icon(Icons.grade),
                          hintText: Texts.textHintJenjang,
                          hintStyle: TextStyles.body2Text,
                          labelStyle: TextStyles.body2Text,
                          focusedBorder: null,
                          contentPadding: const EdgeInsets.all(Dimens.d8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.d8),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: Texts.textErrorRequired),
                        ])),
                    const Gap(),
                    const Text(
                      Texts.textSekolah,
                      style: TextStyles.title,
                    ),
                    const Gap(
                      h: Dimens.d8,
                    ),
                    FormBuilderTextField(
                        name: Texts.textSekolah,
                        decoration: InputDecoration(
                          fillColor: colorScheme(context)
                              .surfaceVariant
                              .withOpacity(0.4),
                          filled: true,
                          prefixIcon: const Icon(Icons.school),
                          hintText: Texts.textHintSekolah,
                          hintStyle: TextStyles.body2Text,
                          labelStyle: TextStyles.body2Text,
                          focusedBorder: null,
                          contentPadding: const EdgeInsets.all(Dimens.d8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.d8),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: Texts.textErrorRequired)
                        ])),
                    const Gap(),
                    const Text(
                      Texts.textKelas,
                      style: TextStyles.title,
                    ),
                    const Gap(
                      h: Dimens.d8,
                    ),
                    FormBuilderTextField(
                        name: Texts.textKelas,
                        decoration: InputDecoration(
                          fillColor: colorScheme(context)
                              .surfaceVariant
                              .withOpacity(0.4),
                          filled: true,
                          prefixIcon: const Icon(Icons.class_),
                          hintText: Texts.textHintkelas,
                          hintStyle: TextStyles.body2Text,
                          labelStyle: TextStyles.body2Text,
                          focusedBorder: null,
                          contentPadding: const EdgeInsets.all(Dimens.d8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.d8),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.required(
                            errorText: Texts.textErrorRequired)),
                    const Gap(
                      h: Dimens.d32,
                    ),
                    SizedBox(
                        width: double.maxFinite,
                        child: FilledButton(
                          onPressed: () {
                            if (_formKey.currentState?.saveAndValidate() == true) {
                              var requestBody = UserBody(
                                fullName: _formKey.currentState!.value[Texts.textNamaLengkap],
                                email: _formKey.currentState!.value[Texts.textEmail],
                                schoolName: _formKey.currentState!.value[Texts.textSekolah],
                                schoolGrade: _formKey.currentState!.value[Texts.textKelas],
                                schoolLevel: _formKey.currentState!.value[Texts.textJenjang],
                                gender: _formKey.currentState!.value[Texts.textJenisKelamin],
                                photoUrl: userEmail?.photoURL
                              );
                              controller.registerAccount(requestBody);
                            }
                          },
                          child: const Text(
                            Texts.textBtnDaftar,
                          ),
                        ))
                  ],
                ))),
      );
    });
  }
}
