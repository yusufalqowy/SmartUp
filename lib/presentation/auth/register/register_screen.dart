import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/enums.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_degree.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_gender.dart';
import 'package:smartup/presentation/widgets/gap.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Akun"),
        backgroundColor: colorScheme(context).primaryContainer,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.d16),
          child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Yuk isi data diri", style: TextStyles.highlightText,),
                  const Gap(
                    h: Dimens.d16,
                  ),
                  const Text(
                    "Nama Lengkap",
                    style: TextStyles.title,
                  ),
                  const Gap(
                    h: Dimens.d8,
                  ),
                  FormBuilderTextField(
                    name: "Nama Lengkap",
                    decoration: InputDecoration(
                      fillColor:
                          colorScheme(context).surfaceVariant.withOpacity(0.4),
                      filled: true,
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Masukan nama lengkap",
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
                        errorText: "Field tidak boleh kosong!"),
                  ),
                  const Gap(),
                  const Text(
                    "Email",
                    style: TextStyles.title,
                  ),
                  const Gap(
                    h: Dimens.d8,
                  ),
                  FormBuilderTextField(
                      name: "Email",
                      onChanged: (text) =>
                          genderController.text = text.toString(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: colorScheme(context)
                            .surfaceVariant
                            .withOpacity(0.4),
                        filled: true,
                        prefixIcon: const Icon(Icons.mail),
                        hintText: "Masukan email",
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
                            errorText: "Field tidak boleh kosong!"),
                        FormBuilderValidators.email(
                            errorText: "Email tidak valid!"),
                      ])),
                  const Gap(),
                  const Text(
                    "Jenis Kelamin",
                    style: TextStyles.title,
                  ),
                  const Gap(
                    h: Dimens.d8,
                  ),
                  FormBuilderTextField(
                    name: "Jenis Kelamin",
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
                      hintText: "Pilih jenis kelamin",
                      hintStyle: TextStyles.body2Text,
                      labelStyle: TextStyles.body2Text,
                      focusedBorder: null,
                      contentPadding: const EdgeInsets.all(Dimens.d8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimens.d8),
                      ),
                    ),
                    validator: FormBuilderValidators.required(
                        errorText: "Silahkan pilih jenis kelamin!"),
                  ),
                  const Gap(),
                  const Text(
                    "Jenjang",
                    style: TextStyles.title,
                  ),
                  const Gap(
                    h: Dimens.d8,
                  ),
                  FormBuilderTextField(
                      name: "Jenjang",
                      onTap: () async {
                        Degree? degree = await Get.bottomSheet(BottomSheetSelectDegree(initDegree: selectedDegree,), backgroundColor: colorScheme(context).surface);
                        if(degree != null){
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
                        hintText: "Pilih jenjang sekolah",
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
                            errorText: "Silahkan pilih jenjang pendidikan!"),
                      ])),
                  const Gap(),
                  const Text(
                    "Sekolah",
                    style: TextStyles.title,
                  ),
                  const Gap(
                    h: Dimens.d8,
                  ),
                  FormBuilderTextField(
                      name: "Sekolah",
                      decoration: InputDecoration(
                        fillColor: colorScheme(context)
                            .surfaceVariant
                            .withOpacity(0.4),
                        filled: true,
                        prefixIcon: const Icon(Icons.school),
                        hintText: "Masukan nama sekolah",
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
                            errorText: "Field tidak boleh kosong!")
                      ])),
                  const Gap(),
                  const Text(
                    "Kelas",
                    style: TextStyles.title,
                  ),
                  const Gap(
                    h: Dimens.d8,
                  ),
                  FormBuilderTextField(
                      name: "Kelas",
                      decoration: InputDecoration(
                        fillColor: colorScheme(context)
                            .surfaceVariant
                            .withOpacity(0.4),
                        filled: true,
                        prefixIcon: const Icon(Icons.class_),
                        hintText: "Masukan nama kelas",
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
                          errorText: "Field tidak boleh kosong!")),
                  const Gap(
                    h: Dimens.d32,
                  ),
                  SizedBox(
                      width: double.maxFinite,
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text(
                          "Daftar",
                        ),
                      ))
                ],
              ))),
    );
  }
}
