
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../component.dart';
import '../../provider/theme_provider.dart';
import '../../widget/loading_error_indicator.dart';
import '../../widget/loading_indicator.dart';
import '../../widget/qiplah_compass.dart';

class Qiblah extends StatefulWidget {
  const Qiblah({super.key});

  @override
  _QiblahState createState() => _QiblahState();
}

class _QiblahState extends State<Qiblah> {
  final _locationStreamController =
  StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: controller.kWhite,
          // appBar: AppBar(
          //   title: Text(
          //     'قبلة الصلاة',
          //     style: TextStyle(
          //       fontSize: 27,
          //    //   fontWeight: FontWeight.bold
          //     ),
          //   ),
          //   centerTitle: true,
          //   backgroundColor: co,
          //   elevation: 0,
          // ),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(50.0),
            child: StreamBuilder(
              stream: stream,
              builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  LoadingIndicator();
                }
                if (snapshot.data!.enabled == true) {
                  switch (snapshot.data!.status) {
                    case LocationPermission.always:
                    case LocationPermission.whileInUse:
                      return QiblahCompassWidget();

                    case LocationPermission.denied:
                      return LocationErrorWidget(
                        error: 'تم رفض إذن خدمة الموقع',
                        callback: _checkLocationStatus,
                      );
                    case LocationPermission.deniedForever:
                      return LocationErrorWidget(
                        error: 'رفض خدمة الموقع إلى الأبد!',
                        callback: _checkLocationStatus,
                      );
                  // case GeolocationStatus.unknown:
                  //   return LocationErrorWidget(
                  //     error: "Unknown Location service error",
                  //     callback: _checkLocationStatus,
                  //   );
                    default:
                      return Container();
                  }
                } else {
                  return LocationErrorWidget(
                    error: ' الرجاء تفعيل الموقع الجغرافي حتى تتمكن من تحديد القبلة',
                    callback: _checkLocationStatus,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}

