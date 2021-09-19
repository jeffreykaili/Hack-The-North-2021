import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget shopAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
    toolbarHeight: 70,
    centerTitle: true,
    title: Text(
      "Shop",
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        letterSpacing: 1.5,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: white,
      ),
    ),
    brightness: Brightness.dark,
    backgroundColor: appBarColor,
  );
}
