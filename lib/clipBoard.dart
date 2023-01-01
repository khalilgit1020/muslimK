import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/provider/theme_provider.dart';
import 'package:provider/provider.dart';


getClipboard(context,title,text){

  Clipboard.setData(ClipboardData(text: title))
      .then((value) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content:  Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.amiri(
          color: Colors.teal,
            fontSize: 18,
          // color: kPrimary
        ),
      ),
      duration:const Duration(seconds: 1),
      backgroundColor:Provider.of<ThemeProvider>(context,listen: false).kBlack,
    ));

  });

}