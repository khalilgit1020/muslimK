import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/component.dart';
import 'package:kh_project/provider/theme_provider.dart';
import 'package:kh_project/widget/image_icon.dart';
import 'package:provider/provider.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.onPress,
    required this.images,
  }) : super(key: key);
 final void Function()onPress;
 final String title;
 final String images;
  @override
  Widget build(BuildContext context) {

    var controller = Provider.of<ThemeProvider>(context,listen: false);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ElevatedButton.icon(
        onPressed: onPress,
        icon: ImagesIcons(images),
        style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10),
          backgroundColor: controller.kWhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: Colors.grey)),
          minimumSize: const Size(175, 75)
        ),
        label: Text(
          title,
          style: GoogleFonts.amiri(fontSize: 19,color: controller.kBlack),
        ),
      ),
    );
  }
}