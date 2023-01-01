import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

import '../component.dart';
import '../service/notificationservice.dart';
import '../storge/pref_controller.dart';

class PrayerTi with ChangeNotifier {
  void getOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    notifyListeners();
  }

/*


  late Qibla qibla ;
  // Qibla direction degree (Compass/Clockwise)
  late double qib;


  late PrayerTimes prayerTimes;
  var current;
  var next;
  var countdown;

  late Coordinates myCoordinates;

  initPrayAndNotification(){

  //   qibla = Qibla(Coordinates(position!.longitude, position!.latitude));
     qibla = Qibla(Coordinates(31.5, 34.46667));
   //  myCoordinates = Coordinates(position!.longitude, position!.latitude);
     myCoordinates = Coordinates(31.5, 34.46667);


    // Replace with your own location lat, lng.
    // final params = CalculationMethod.egyptian.getParameters();

    params.madhab = Madhab.shafi;
    prayerTimes = PrayerTimes.today(myCoordinates, params);
    // prayerTimes = getSettings(myCoordinates, params);
    qib = qibla.direction;
    current = prayerTimes.currentPrayer();
    next = prayerTimes.nextPrayer();
    countdown = prayerTimes.timeForPrayer(next);
 //   log(prayerTimes.fajr.timeZoneName);

    print('initialized');


    notifyListeners();

  }
*/

  cancelNotification() {
    // showToast(msg: 'تم إيقاف الإشعارات');
    NotificationService().cancelAllNotifications();
    notifyListeners();
  }

  DateTime date = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  String myDay = '';

  getDay() {
    if (DateFormat('EEEE').format(date) == 'Monday') {
      myDay = 'الإثنين';
      notifyListeners();
    }
    if (DateFormat('EEEE').format(date) == 'Tuesday') {
      myDay = 'الثلاثاء';
      notifyListeners();
    }
    if (DateFormat('EEEE').format(date) == 'Wednesday') {
      myDay = 'الأربعاء';
      notifyListeners();
    }
    if (DateFormat('EEEE').format(date) == 'Thursday') {
      myDay = 'الخميس';
      notifyListeners();
    }
    if (DateFormat('EEEE').format(date) == 'Friday') {
      myDay = 'الجمعة';
      notifyListeners();
    }
    if (DateFormat('EEEE').format(date) == 'Saturday') {
      myDay = 'السبت';
      notifyListeners();
    }
    if (DateFormat('EEEE').format(date) == 'Sunday') {
      myDay = 'الأحد';
      notifyListeners();
    }
  }

  activateNotification() {


    NotificationService().initNotification().then((value) {

      getZikrStart();

      Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: false,
      );
      print('تشغيل الإشعارات');

      notifyListeners();

    });
  }

  disActivateNotification() {
    NotificationService().cancelAllNotifications();
    flutterLocalNotificationsPlugin.cancelAll();

    notifyListeners();
  }

  bool isDark = true;

  Color? WHITE_COLOR;
  Color? Black_COLOR;

/*
  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      WHITE_COLOR = isDark ?  Colors.black : Colors.white;
      Black_COLOR = isDark ?  Colors.white : Colors.black;
      print('kkk');
      notifyListeners();
    }
    else {
      isDark = !isDark;
      notifyListeners();

      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        WHITE_COLOR = isDark ?  Colors.black : Colors.white;
        Black_COLOR = isDark ?  Colors.white : Colors.black;
        print(value);
        notifyListeners();
      });
    }
  }
 */



  bool notificationActive = false;

  void notStatus({bool? fromShared}) {
    if (fromShared != null ) {
      notificationActive = fromShared;
      notificationActive ?  activateNotification() : disActivateNotification();
      print('kkk');
      notifyListeners();
    }
    else {
      notificationActive = !notificationActive;
      CacheHelper.putData(key: 'notificationActive', value: notificationActive);
      notificationActive ?  activateNotification() : disActivateNotification();
      print(CacheHelper.getData(key: 'notificationActive'));
      notifyListeners();

    }
  }


  late double lat ;
  late double long;

  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude;
      long = value.longitude;
      //initPray(lat,long);
      notifyListeners();
    });
  }




}
