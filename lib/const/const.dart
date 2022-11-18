import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


myStyle(double fontsize,Color clr,[FontWeight? fw] ) {
  return GoogleFonts.roboto(
    fontSize: fontsize,
    color: clr,
    fontWeight: fw,
  );
}