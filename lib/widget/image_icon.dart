import 'package:flutter/material.dart';

class ImagesIcons extends StatelessWidget {
  ImagesIcons(this.image, {Key? key, this.active = true, this.color})
      : super(key: key);
  final String image;
  bool active;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 25,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          color: active ? null : color,
        ));
  }
}