import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartup/core/styles/text_style.dart';
import 'package:smartup/core/utils/app_size.dart';

import '../../core/styles/colors.dart';
import '../../core/values/dimens.dart';
import 'gap.dart';

enum ImagePickerType {
  camera,
  gallery,
  all;
}

class BottomSheetImagePicker extends StatefulWidget {
  final ImagePickerType imagePickerType;
  final bool isCropImage;
  final int imageQuality;
  final List<CropAspectRatioPreset> cropAspectRatio;
  final Function(String? onResult) onImageResult;

  const BottomSheetImagePicker(
      {super.key,
      required this.onImageResult,
      this.imagePickerType = ImagePickerType.all,
      this.isCropImage = false,
      this.imageQuality = 30,
      this.cropAspectRatio = const [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]});

  @override
  State<BottomSheetImagePicker> createState() => _BottomSheetImagePickerState();
}

class _BottomSheetImagePickerState extends State<BottomSheetImagePicker> {
  _BottomSheetImagePickerState();

  ImagePickerType _imagePickerType = ImagePickerType.all;
  final ImagePicker _picker = ImagePicker();

  Future<void> cropImage(String? path) async {
    var cropImage = await ImageCropper().cropImage(
        sourcePath: path ?? "",
        aspectRatioPresets: widget.cropAspectRatio,
        compressFormat: ImageCompressFormat.png,
        compressQuality: widget.imageQuality
    );
    widget.onImageResult.call(cropImage?.path);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _imagePickerType = widget.imagePickerType;
    });
  }

  Widget renderCameraType() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: colorScheme(context).surfaceVariant,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.d16)),
      child: InkWell(
        onTap: () async {
          Get.back();
          var file = await _picker.pickImage(source: ImageSource.camera, imageQuality: widget.imageQuality, maxHeight: 1080);
          if (widget.isCropImage) {
            await cropImage(file?.path);
          } else {
            widget.onImageResult.call(file?.path);
          }
        },
        child: Container(
          width: AppSize.getWidth(margin: 64) / 2,
          padding: const EdgeInsets.symmetric(vertical: Dimens.d16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt_rounded,
                size: 48,
              ),
              Gap(
                h: Dimens.d8,
              ),
              Text(
                "Camera",
                style: TextStyles.title,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderGalleryType() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: colorScheme(context).surfaceVariant,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.d16)),
      child: InkWell(
        onTap: () async {
          Get.back();
          var file = await _picker.pickImage(source: ImageSource.gallery, imageQuality: widget.imageQuality, maxHeight: 1080);
          if (widget.isCropImage) {
            await cropImage(file?.path);
          } else {
            widget.onImageResult.call(file?.path);
          }
        },
        child: Container(
          width: AppSize.getWidth(margin: 64) / 2,
          padding: const EdgeInsets.symmetric(vertical: Dimens.d16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_rounded,
                size: 48,
              ),
              Gap(
                h: Dimens.d8,
              ),
              Text(
                "Gallery",
                style: TextStyles.title,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listPicker = [];
    if (_imagePickerType == ImagePickerType.all) {
      listPicker.add(renderCameraType());
      listPicker.add(const Gap(
        w: Dimens.d16,
      ));
      listPicker.add(renderGalleryType());
    } else if (_imagePickerType == ImagePickerType.camera) {
      listPicker.add(renderCameraType());
    } else {
      listPicker.add(renderGalleryType());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(),
        Container(
          height: Dimens.d6,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.d8),
              color: themeData(context).dividerColor),
        ),
        const Gap(),
        const Text(
          "Pilih Foto",
          style: TextStyles.highlightText,
        ),
        const Gap(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listPicker,
        ),
        const Gap()
      ],
    );
  }
}
