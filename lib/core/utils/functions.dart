import 'dart:async';
import 'dart:ui';

import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:smartup/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

VoidCallback? openLink({required String? link}) {
  if (!link.isNullOrEmpty) {
    var url = Uri.parse(link!);
    if (url.isAbsolute) {
      return () {
        launchUrl(url, mode: LaunchMode.externalApplication);
      };
    } else {
      return null;
    }
  } else {
    return null;
  }
}

FutureOr<bool> openLinkAsync({required String link}) {
  var url = Uri.parse(link);
  if (url.isAbsolute) {
    return launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    return Future.value(false);
  }
}

Color getUserAvatarNameColor(User user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}
