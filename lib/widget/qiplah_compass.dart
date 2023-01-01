import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';

import 'loading_indicator.dart';

class QiblahCompassWidget extends StatelessWidget {
  final _compassSvg = SvgPicture.asset(
    'assets/image/compass.svg',
     color: Colors.yellow.shade700,
  );
  final _needleSvg = SvgPicture.asset(
    'assets/image/needle.svg',
    fit: BoxFit.contain,
    height: 300,
    alignment: Alignment.center,
  );

  QiblahCompassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }

        final qiblahDirection = snapshot.data!;
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.rotate(
              angle: (qiblahDirection.direction * (pi / 180) * -1),
              child: _compassSvg,
            ),
            Transform.rotate(
              angle: (qiblahDirection.qiblah * (pi / 180) * -1),
              alignment: Alignment.center,
              child: _needleSvg,
            ),
            Positioned(
              bottom: 8,
              child: Text("${qiblahDirection.offset.toStringAsFixed(3)}°"),
            )
          ],
        );
      },
    );
  }
}
