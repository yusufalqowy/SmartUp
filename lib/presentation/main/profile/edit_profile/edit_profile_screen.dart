import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/core/values/enums.dart';
import 'package:smartup/presentation/widgets/bottom_sheet_gender.dart';
import 'package:smartup/presentation/widgets/gap.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  var selectGender = Gender.none;
  var genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Akun"),
        backgroundColor: colorScheme(context).primaryContainer,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.d16),
          child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person),
                        ),
                        Positioned(
                          top: 70,
                          child: IconButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      themeData(context).primaryColorDark),
                                  shape: const MaterialStatePropertyAll(
                                      CircleBorder())),
                              icon: const Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                  const Gap(
                    h: Dimens.d20,
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
                      onChanged: (text) => genderController.text = text.toString(),
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
                      decoration: InputDecoration(
                        fillColor: colorScheme(context)
                            .surfaceVariant
                            .withOpacity(0.4),
                        filled: true,
                        prefixIcon: const Icon(Icons.show_chart),
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
                            errorText: "Field tidak boleh kosong!"),
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
                  const Gap(
                    h: Dimens.d32,
                  ),
                  SizedBox(
                      width: double.maxFinite,
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text("Perbarui Data",),
                      ))
                ],
              ))),
    );
  }
}
