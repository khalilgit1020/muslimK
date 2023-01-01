import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kh_project/db/db_controller.dart';
import 'package:kh_project/provider/All_surah.dart';
import 'package:kh_project/provider/alhamed_zeker.dart';
import 'package:kh_project/provider/azkary_provider.dart';
import 'package:kh_project/provider/pray_time.dart';
import 'package:kh_project/provider/theme_provider.dart';
import 'package:kh_project/screen/alhamed/alhamed_screen.dart';
import 'package:kh_project/screen/home_screen.dart';
import 'package:kh_project/screen/lunch_screen.dart';
import 'package:kh_project/screen/tsbeh_screen.dart';
import 'package:provider/provider.dart';

import 'component.dart';
import 'screen/name_of_allah.dart';
import 'storge/pref_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbController().initDatabase();
  await CacheHelper.init();
  await getPosition();
  MobileAds.instance.initialize();
  // bool? notificationActive = CacheHelper.getData(key: 'notificationActive');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

//  final bool? notificationActive;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AzkaryProvider>(
            create: (context) => AzkaryProvider()),
        ChangeNotifierProvider<AllSu>(create: (context) => AllSu()),
        ChangeNotifierProvider<AlhamedProvider>(
            create: (context) => AlhamedProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(
                isDarkMode:
                    CacheHelper.sharedPreferences!.getBool('isDarkMode')??true)
              ..changeTheme()),
        ChangeNotifierProvider<PrayerTi>(
          create: (context) => PrayerTi()
            ..getDay()
            ..activateNotification(),
          //..notStatus(fromShared: notificationActive),
        ),
      ],
      builder: (context, child) => const MyAppMaterial(),
    );
  }
}

class MyAppMaterial extends StatelessWidget {
  const MyAppMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).theme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar', 'AE'), // English, no country code
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: '/lunch_screen',
      // home: AllSurah(),
      routes: {
        '/lunch_screen': (context) => LunchScreen(),
        '/home_screen': (context) => HomeScreen(),
        '/alhamed_screen': (context) => AlhamedScreen(),
        '/tsbeh_screen': (context) => TsbehScreen(),
        '/names_of_allah_screen': (context) => AllahNames(),
      },
    );
  }
}
