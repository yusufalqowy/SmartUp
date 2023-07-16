import 'dart:async';
import 'dart:ui';

import 'package:smartup/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

VoidCallback? openLink({required String? link}) {
  if(!link.isNullOrEmpty){
    var url = Uri.parse(link!);
    if(url.isAbsolute){
      return (){
        launchUrl(url, mode: LaunchMode.externalApplication);
      };
    }else{
      return null;
    }
  }else{
    return null;
  }
}

FutureOr<bool> openLinkAsync({required String link}){
  var url = Uri.parse(link);
  if(url.isAbsolute){
    return launchUrl(url, mode: LaunchMode.externalApplication);
  }else{
    return Future.value(false);
  }
}