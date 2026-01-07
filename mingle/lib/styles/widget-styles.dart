import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:mingle/styles/colors.dart';

Transition pageTransitionStyle = Transition.leftToRightWithFade;

ButtonStyle primaryButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all<Color>(secondary),
  shape: WidgetStateProperty.all<OutlinedBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  ),
);

InputDecoration textFieldDeco = InputDecoration(
  focusColor: accent,
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: accent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: accent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  filled: true,
  fillColor: Color(0xFFF6F6F6),
  // hintStyle: TextStyle(color: textFieldHolder),
  border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(6.0)))
);


TextStyle sellFieldHeader = TextStyle(fontWeight: FontWeight.w600, fontSize: 18);