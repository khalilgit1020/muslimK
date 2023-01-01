import 'dart:async';
import 'dart:math';

import 'package:adhan/adhan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

import 'model/azkar_list.dart';
import 'service/notificationservice.dart';

Color co = const Color.fromRGBO(18, 140, 126, 1);

int suarhSize = 16;


var time = DateTime.now();


getZikrStart() {
  int rndmIndex = 0;

  rndmIndex = Random().nextInt(Azkar.randomZikr.length - 1);
  NotificationService()
      .showNotification(rndmIndex, "أذكار", Azkar.randomZikr[rndmIndex][0], 1);
}

getRandomZikr() {

  if (kDebugMode) {
    print('random notification');
  }

  showNotification();

  int rndmIndex = 0;

  Timer.periodic(const Duration(minutes: 10), (_) {
    if (kDebugMode) {
      print('random timer notification');
    }

    rndmIndex = Random().nextInt(Azkar.randomZikr.length - 1);
    NotificationService()
        .showNotification(rndmIndex, "فذكر", Azkar.randomZikr[rndmIndex][0], 1);
  });

  Timer.periodic(const Duration(seconds: 20), (_) {
    if (TimeOfDay.now().hour == prayerTimes.fajr.hour &&
        TimeOfDay.now().minute == prayerTimes.fajr.minute) {
      NotificationService().showNotification(
          40, "صلاة الفجر", 'حان موعد صلاة الفجر, جهز نفسك للصلاة', 1);
    }
    if (TimeOfDay.now().hour == prayerTimes.dhuhr.hour &&
        TimeOfDay.now().minute == prayerTimes.dhuhr.minute) {
      NotificationService().showNotification(
          41, "صلاة الظهر", 'حان موعد صلاة الظهر, جهز نفسك للصلاة', 1);
    }
    if (TimeOfDay.now().hour == prayerTimes.asr.hour &&
        TimeOfDay.now().minute == prayerTimes.asr.minute) {
      NotificationService().showNotification(
          42, "صلاة العصر", 'حان موعد صلاة العصر, جهز نفسك للصلاة', 1);
    }
    if (TimeOfDay.now().hour == prayerTimes.maghrib.hour &&
        TimeOfDay.now().minute == prayerTimes.maghrib.minute) {
      NotificationService().showNotification(
          43, "صلاة المغرب", 'حان موعد صلاة المغرب, جهز نفسك للصلاة', 1);
    }
    if (TimeOfDay.now().hour == prayerTimes.isha.hour &&
        TimeOfDay.now().minute == prayerTimes.isha.minute) {
      NotificationService().showNotification(
          44, "صلاة العشاء", 'حان موعد صلاة العشاء, جهز نفسك للصلاة', 1);
    }

    if (DateFormat('EEEE').format(time) == 'Friday' &&
        TimeOfDay.now().hour == 10 &&
        TimeOfDay.now().minute == 10) {
      NotificationService().showSingleNotificationWeekly(
        47,
        'يوم الجمعة',
        'اليوم الجمعة لا تنسوا قراءة سورة الكهف',
        Day.friday,
        12,
        30,
      );
      NotificationService().showNotification(
          47, "يوم الجمعة", 'اليوم الجمعة لا تنسوا قراءة سورة الكهف', 1);
    }

    if (TimeOfDay.now().hour == 11 && TimeOfDay.now().minute == 10) {
      NotificationService().showSingleNotificationDaily(
          48, "الورد اليومي", 'لا تنسى قراءة وردك اليومي من القران الكريم', 14, 30);
      NotificationService().showSingleNotificationDaily(
          48, "الورد اليومي", 'لا تنسى قراءة وردك اليومي من القران الكريم', 18, 30);

      NotificationService().showNotification(
          48, "الورد اليومي", 'لا تنسى قراءة وردك اليومي من القران الكريم', 1);
    }

    if (TimeOfDay.now().hour == 14 && TimeOfDay.now().minute == 10) {

      NotificationService().showSingleNotificationDaily(
        49,
        'الصلاة على النبي',
        'اللهم صلي وسلم على أفضل الخلق سيدنا محمد',
        11,
        30,
      );
      NotificationService().showSingleNotificationDaily(
        49,
        'الصلاة على النبي',
        'اللهم صلي وسلم على أفضل الخلق سيدنا محمد',
        15,
        30,
      );
      NotificationService().showSingleNotificationDaily(
        49,
        'الصلاة على النبي',
        'اللهم صلي وسلم على أفضل الخلق سيدنا محمد',
        22,
        30,
      );
      NotificationService().showNotification(49, "الصلاة على النبي",
          'اللهم صلي وسلم على أفضل الخلق سيدنا محمد', 1);
    }
  });

  //  اشعارات تذكير ب قراءة اذكار الصباح

  NotificationService().showSingleNotificationDaily(
    50,
    'أذكار الصباح',
    'لا تنسى قراءة أذكار الصباح',
    10,
    20,
  );
  NotificationService().showSingleNotificationDaily(
    50,
    'أذكار الصباح',
    'لا تنسى قراءة أذكار الصباح',
    12,
    20,
  );

  //  اشعارات تذكير ب قراءة اذكار المساء

  NotificationService().showSingleNotificationDaily(
    50,
    'أذكار المساء',
    'لا تنسى قراءة أذكار المساء',
    21,
    30,
  );
  NotificationService().showSingleNotificationDaily(
    50,
    'أذكار المساء',
    'لا تنسى قراءة أذكار المساء',
    23,
    30,
  );

  //  اشعارات تذكير ب قراءة الورد اليومي

  NotificationService().showSingleNotificationDaily(
      48, "الورد اليومي", 'لا تنسى قراءة وردك اليومي من القران الكريم', 14, 30);
  NotificationService().showSingleNotificationDaily(
      48, "الورد اليومي", 'لا تنسى قراءة وردك اليومي من القران الكريم', 18, 30);

  //  اشعارات تذكير ب الصلاة على النبي

  NotificationService().showSingleNotificationDaily(
    49,
    'الصلاة على النبي',
    'اللهم صلي وسلم على أفضل الخلق سيدنا محمد',
    11,
    30,
  );
  NotificationService().showSingleNotificationDaily(
    49,
    'الصلاة على النبي',
    'اللهم صلي وسلم على أفضل الخلق سيدنا محمد',
    15,
    30,
  );
  NotificationService().showSingleNotificationDaily(
    49,
    'الصلاة على النبي',
    'اللهم صلي وسلم على أفضل الخلق سيدنا محمد',
    22,
    30,
  );

  //  اشعارات تذكير ب قراءة سورة الكهف في يوم الجمعة

  NotificationService().showSingleNotificationWeekly(
    47,
    'يوم الجمعة',
    'اليوم الجمعة لا تنسوا قراءة سورة الكهف',
    Day.friday,
    12,
    30,
  );
}

String verse = '';
String surName = '';

getRandomAya() {
  verse = Azkar.randomAyat[Random().nextInt(Azkar.randomAyat.length)];
}

// late Qibla qibla;
// Qibla direction degree (Compass/Clockwise)
late double qib;

late PrayerTimes prayerTimes;
var current;
var next;
var countdown;

late Coordinates myCoordinates;

late Position position;
Future getPosition() async {
  LocationPermission permission =  await Geolocator.checkPermission();
  if(permission ==LocationPermission.denied){
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
  position = await Geolocator.getCurrentPosition();
  initPray();
  if (kDebugMode) {
    print('longitude = ' + position.longitude.toString() + '000000000');
    print('latitude = ' + position.latitude.toString()); //Output: 29.6593457
  }

  // double long = position.longitude;
  // double lat = position.latitude;
  // print('longitude is  : $long');
  // print('latiude is  : $lat');
  // log('longitude =   long.toString()); //Output: 80.24599079
  // print(log('latitude = ' + lat.toString());
}


/*
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
 //   notifyListeners();
  });
}
*/


initPray({lat, long}) {
  // qibla = Qibla(Coordinates(position.longitude, position.latitude));
  // qibla = Qibla(Coordinates(31.5, 34.46667));
   //myCoordinates = Coordinates(lat, long);
  myCoordinates = Coordinates(position.latitude, position.longitude);
   print(myCoordinates.longitude);

  // myCoordinates = Coordinates(51.5651111, 25.0990371);
//myCoordinates = Coordinates(31.898043, 35.204269);

  // Replace with your own location lat, lng.
  final params = CalculationMethod.egyptian.getParameters();

  params.madhab = Madhab.hanafi;
  prayerTimes = PrayerTimes.today(myCoordinates,params);
  // prayerTimes = getSettings(myCoordinates, params);
  //qib = qibla.direction;/

  current = prayerTimes.currentPrayer();
  next = prayerTimes.nextPrayer();
  countdown = prayerTimes.timeForPrayer(next);

  if (kDebugMode) {
    print('initialized');
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

callbackDispatcher() {
  // initial notifications
  const initializationSettingsAndroid = AndroidInitializationSettings('lo');
  const initializationSettingsIOS = IOSInitializationSettings();

  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  WidgetsFlutterBinding.ensureInitialized();

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  Workmanager().executeTask((task, inputData) {
    getRandomZikr();
    return Future.value(true);
  });
}


Future showNotification() async {

  int rndmIndex = Random().nextInt(Azkar.randomZikr.length - 1);

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    '$rndmIndex.0',
    'تطبيق أذكار المسلم',
    channelDescription: 'تطبيق اذكار وادعية وتلاوة وقراءة القرءان الكريم',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );
  const iOSPlatformChannelSpecifics = IOSNotificationDetails(
    threadIdentifier: 'thread_id',
  );
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    rndmIndex,
    'أذكار المسلم',
    Azkar.randomZikr[rndmIndex][0],
    platformChannelSpecifics,
  );

}
