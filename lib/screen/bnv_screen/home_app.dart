import 'dart:math';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/screen/bnv_screen/pray_time.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../clipBoard.dart';
import 'package:intl/intl.dart';
import '../../component.dart';
import '../../model/azkar_list.dart';
import '../../provider/theme_provider.dart';
import '../../widget/custom_button.dart';
import '../zikr.dart';
import '../azkar_app.dart';
import '../azkary.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  ThemeProvider? controller;

  @override
  void initState() {
    // TODO: implement initState
    greeting();
    super.initState();

    controller = Provider.of<ThemeProvider>(context, listen: false);
  }

  final random = Random();

  @override
  Widget build(BuildContext context) {
    String elementAlhamed =
        Azkar.listHamed[random.nextInt(Azkar.listHamed.length)];
    String elementAyat =
        Azkar.randomAyat[random.nextInt(Azkar.randomAyat.length)];
    String prayRandom =
        Azkar.prayOfMohammed[random.nextInt(Azkar.prayOfMohammed.length)];
    List elementNameOfAllah =
        Azkar.namesOfAllah[random.nextInt(Azkar.namesOfAllah.length)];

    Size size = MediaQuery.of(context).size;

    double screenWidth = size.width;

    Color v = Provider.of<ThemeProvider>(context) == ThemeData.dark()
        ? controller!.kBlack
        : controller!.kWhite;
    return ListView(

      children: [
        SizedBox(
          height: size.height * 0.58,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: controller!.kPrimary,
                        image: DecorationImage(
                          image: DateTime.now().hour < 18
                              ? const AssetImage(
                                  'assets/image/mo2.jpg',
                                )
                              : const AssetImage(
                                  'assets/image/mo1.jpg',
                                ),
                          fit: BoxFit.cover,
                        )),
                    // padding: const EdgeInsets.symmetric(
                    // vertical: 80, horizontal: 20),
                    height: screenWidth / 1.4,
                  ),
                  SizedBox(
                    child: Container(
                      height: screenWidth / 2,
                      color: controller!.kWhite,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 50,
                // right: 20,
                // left: 30,
                child: Container(
                  height: size.height * 0.15,
                  width: screenWidth,
                  child: prayerTimes == null
                      ? const CircularProgressIndicator(color: Colors.teal)
                      : BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: Container(
                            // alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PrayTime().buildContainerPray(
                                    screenWidth,
                                    PrayTime().decidePray(
                                        next.toString().split('.')[1]),controller),
                                SizedBox(height: size.height * 0.01),
                                PrayTime().buildContainerPray(
                                    screenWidth,
                                    countdown == null
                                        ? '- - - - - - - - - '
                                        : DateFormat.jm()
                                            .format(countdown)
                                            .toString(),controller),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              Positioned(
                top: 200,
                right: 50,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.grey, blurRadius: 5, spreadRadius: 3)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: v,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'مرحبا بك',
                        style: GoogleFonts.amiri(
                          // color: controller!.kWhite,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'عطر فمك ب${greeting()}',
                        style: GoogleFonts.amiri(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CircleAvatar(
                        backgroundColor: controller!.kPrimary,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Zikr(title: greeting()),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            color: controller!.kWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                images: 'assets/image/sunrise.png',
                title: 'ورد الصباح',
                onPress: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Zikr(title: 'أذكار الصباح'),
                  ),
                ),
              ),
              CustomButton(
                images: 'assets/image/night.png',
                title: 'ورد المساء',
                onPress: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Zikr(title: 'أذكار المساء'),
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                images: 'assets/image/activ_zikr.png',
                title: 'أذكاري',
                onPress: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AzkaryScreen()
                  ),
                ),
              ),
              CustomButton(
                images: 'assets/image/azkar_active.png',
                title: 'الأذكار',
                onPress: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AzkarScreen(),
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                images: 'assets/image/calendar.png',
                title: 'مواقيت الصلاة',
                onPress: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrayTime(),
                    )),
              ),
              CustomButton(
                images: 'assets/image/tasbih.png',
                title: 'تسبيح',
                onPress: () => Navigator.pushNamed(context, '/tsbeh_screen'),
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(boxShadow: [
              const BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                spreadRadius: 2,
              )
            ], borderRadius: BorderRadius.circular(15), color: v),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'بلغوا عني لو أية',
                      style: GoogleFonts.amiri(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Share.share(elementAyat);
                        },
                        icon: const Icon(Icons.share))
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  elementAyat,
                  style: GoogleFonts.amiri(
                    fontSize: 25,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => setState(() {
                    elementAyat;
                  }),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: controller!.kPrimary,
                    child: Icon(
                      Icons.cached_rounded,
                      color: controller!.kWhite,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            // height: size.height *0.4,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                boxShadow: [
                  const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    spreadRadius: 2,
                  )
                ],
                borderRadius: BorderRadius.circular(15),
                color: controller!.kWhite),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/names_of_allah_screen'),
                    icon: const Icon(
                      Icons.list_sharp,
                    ),
                  ),
                ),
                Text(
                  "أسماء الله الحسنى",
                  style: GoogleFonts.amiri(
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.15,
                  child: DefaultTextStyle(
                    style: GoogleFonts.amiri(
                        fontSize: 70.0, color: controller!.kBlack),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ScaleAnimatedText(
                          elementNameOfAllah[0],
                          duration: const Duration(seconds: 2),
                        ),
                      ],
                      isRepeatingAnimation: true,
                      repeatForever: true,
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        elementNameOfAllah;
                      }),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: controller!.kPrimary,
                        child: Icon(
                          Icons.cached_rounded,
                          color: controller!.kWhite,
                          size: 30,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => dialog(context, elementNameOfAllah[0],
                          elementNameOfAllah[1]),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: controller!.kPrimary,
                        child: Icon(
                          Icons.arrow_forward,
                          color: controller!.kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: controller!.kWhite),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: IconButton(
                          onPressed: () {
                            Share.share(prayRandom);
                          },
                          icon: const Icon(Icons.share)),
                    ),
                    Text(
                      'صلوات',
                      style: GoogleFonts.amiri(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      prayRandom,
                      style: GoogleFonts.amiri(
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => setState(() {
                        prayRandom;
                      }),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: controller!.kPrimary,
                        child: Icon(
                          Icons.cached_rounded,
                          color: controller!.kWhite,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: controller!.kPrimary,
                radius: size.height * 0.05,
                child: CircleAvatar(
                  radius: size.height * 0.04,
                  backgroundColor: controller!.kWhite,
                  child: Icon(
                    Icons.currency_pound_rounded,
                    size: size.height * 0.05,
                    color: controller!.kPrimary,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 10,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: controller!.kBlack,
                  blurRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.circular(
                15,
              ),
              color: controller!.kWhite,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'أشكرك يا ربي على نعمة',
                  style: GoogleFonts.amiri(
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.05),
                Text(
                  elementAlhamed,
                  style: GoogleFonts.amiri(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/alhamed_screen'),
                  child: CircleAvatar(
                    backgroundColor: controller!.kPrimary,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: controller!.kWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        )
      ],
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'أذكار الصباح';
    } else {
      return 'أذكار المساء';
    }
  }

  dialog(context, name, mean) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.teal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        content: Text(
          mean,
          style: const TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => getClipboard(context, mean, 'تم نسخ المعنى'),
            child: const Text(
              'نسخ',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 18,
              ),
            ),
          ),
          TextButton(
            // color: Colors.teal,
            autofocus: true,
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'إغلاق',
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  FittedBox buildContainerTime(screenWidth, time) {
    return FittedBox(
      child: FittedBox(
        child: Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            Container(
              width: screenWidth / 3.5,
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat.jm().format(time).toString(),
                style: GoogleFonts.amiri(
                  color: controller!.kWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
                // textDirection: TextDirection.RTL,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainerText(pray) {
    return Container(
      alignment: Alignment.centerRight,
      child: FittedBox(
        child: Text(
          pray,
          style: GoogleFonts.amiri(
            color: controller!.kWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget verticalLine() {
    return Container(
      width: 1,
      height: 8,
      color: controller!.kBlack,
    );
  }
}
