import 'package:flutter/material.dart';

abstract class ButtonStyles{
  static const circleButton = ButtonStyle(
    shape: MaterialStatePropertyAll(CircleBorder()),
    padding: MaterialStatePropertyAll(EdgeInsets.zero),

  );
}