import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speed_meter_app/utils/colors.dart';

final elevatedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: lightGradientColor,
  elevation: 4.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
);

final elevatdButtonTextstyle = GoogleFonts.lilitaOne(
  fontSize: 30,
);

final appBarTextStyle = GoogleFonts.kalam(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 30,
);

const containerBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      lightGradientColor,
      darkGradientColor,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(15),
  ),
);
