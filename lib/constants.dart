import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors - main
Color kPrimaryColor = Colors.blueAccent;
Color kSecondaryColor = Colors.white;
Color kPrimaryTextColor = Color(0xfff37474F);

// Box Decoraation - main Border
Decoration kBorder = BoxDecoration(
    border: Border.all(
      color: Colors.blueAccent,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(20));

// TextStyles - main
TextStyle kh1TextStyle =
    GoogleFonts.poppins(fontSize: 36.0, fontWeight: FontWeight.bold);
// TextStyles - main
TextStyle kNameTextStyle =
    GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.bold);
TextStyle KAccountTextStyle =
    GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w500);
TextStyle ktitleTextStyle =
    GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600);

//TextStyles -- Profile Page
TextStyle kprofileDescriptionText = GoogleFonts.poppins(
    color: kPrimaryTextColor, fontSize: 18.0, fontWeight: FontWeight.bold);