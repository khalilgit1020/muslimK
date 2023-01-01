import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    tzz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('lo');

    const IOSInitializationSettings initializationSettingsIOS =  IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        //selectedNotificationPayload = "The best";
        // selectNotificationSubject.add(payload);
        if (kDebugMode) {
          print('notification payload: $payload');
        }
           //Navigator.push(MaterialPageRoute(builder: (_)=> TypesOfZikr()));
      } else {
        if (kDebugMode) {
          print("Notification Done");
        }
      }
      //  Get.to(TypesOfZikr());
    });

    requestIOSPermissions();
  }

  void requestIOSPermissions() {

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  showSingleNotificationWeekly(id, title, body,day, hour, minutes) {
    flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      id,
      title,
      body,
      day,
      Time(hour,minutes),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'تطبيق أذكار المسلم',
          'تنبيهات',
          channelDescription: 'تطبيق اذكار وادعية وتلاوة وقراءة القرءان الكريم',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
          enableVibration: true,
        ),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  showSingleNotificationDaily(id, title, body, hour, minutes) {
    flutterLocalNotificationsPlugin.showDailyAtTime(
      id,
      title,
      body,
      Time(hour, minutes),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'تطبيق أذكار المسلم',
          'تنبيهات',
          channelDescription: 'تطبيق اذكار وادعية وتلاوة وقراءة القرءان الكريم',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
          enableVibration: true,
        ),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<void> showNotification(
      int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'تطبيق أذكار المسلم',
          'تنبيهات',
          channelDescription: 'تطبيق اذكار وادعية وتلاوة وقراءة القرءان الكريم',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
          enableVibration: true,
        ),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );

/*

    print('تشغيل الاشعارات');
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'repeating channel id', 'repeating channel name',
        channelDescription: 'repeating description',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(0, title,
        body,RepeatInterval.hourly , platformChannelSpecifics,
        androidAllowWhileIdle: true,payload: 'Default_Sound');
*/
  }

  Future<void> cancelAllNotifications() async {
    if (kDebugMode) {
      print('ايقاف الاشعارات');
    }
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  scheduledNotification(int id, String title, String note, function) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      note,
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      function,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'تطبيق أذكار المسلم',
          'تطبيق أذكار المسلم',
          channelDescription: 'تطبيق اذكار وادعية وتلاوة وقراءة القرءان الكريم',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      // payload: '${task.title}|${task.note}|${task.startTime}|',
    );
  }

  tz.TZDateTime nextInstanceOfTenAM(hour) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

/*
    var formmatedDate = DateFormat.yMd().parse(DateTime.now().toString());
    final tz.TZDateTime fd = tz.TZDateTime.from(formmatedDate, tz.local);
*/

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

/*

      scheduledDate = tz.TZDateTime(
          tz.local, now.year, now.month, (formmatedDate.day) + 1, hour,);



*/

    return scheduledDate;
  }
}
