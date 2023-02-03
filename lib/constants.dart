import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors - main
Color kPrimaryColor = Colors.blueAccent;
Color kSecondaryColor = Colors.white;
Color kPrimaryTextColor = Color(0xfff37474F);

// Box Decoraation - main Border
Decoration kBorder = BoxDecoration(
    // color: Colors.white,
    border: Border.all(
      color: Colors.blueAccent,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(20));

// TextStyles - main
TextStyle kh1TextStyle =
    GoogleFonts.poppins(fontSize: 36.0, fontWeight: FontWeight.bold);
TextStyle kWelcomeStyle = GoogleFonts.poppins(
    fontSize: 40.0, fontWeight: FontWeight.bold, color: kSecondaryColor);
// TextStyles - main
TextStyle kNameTextStyle =
    GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.bold);
TextStyle kAccountTextStyle =
    GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w500);
TextStyle ktitleTextStyle =
    GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600);
TextStyle kButtonTextStyle =
    GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600);

//TextStyles -- Profile Page
TextStyle kprofileDescriptionText = GoogleFonts.poppins(
    color: kPrimaryTextColor, fontSize: 18.0, fontWeight: FontWeight.bold);
