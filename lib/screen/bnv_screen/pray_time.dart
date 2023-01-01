import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../component.dart';
import '../../provider/pray_time.dart';
import '../../provider/theme_provider.dart';

class PrayTime extends StatelessWidget {
  decidePray(pray) {
    if (pray == 'fajr') {
      return 'الفجر';
    } else if (pray == 'sunrise') {
      return 'شروق الشمس';
    } else if (pray == 'dhuhr') {
      return 'الظهر';
    } else if (pray == 'asr') {
      return 'العصر';
    } else if (pray == 'maghrib') {
      return 'المغرب';
    } else if (pray == 'isha') {
      return 'العشاء';
    } else {
      return 'انتهت صلوات اليوم';
    }
  }

  @override
  Widget build(BuildContext context) {
    var formatter = Provider.of<PrayerTi>(context).formatter;
    var date = Provider.of<PrayerTi>(context).date;
    var theDay = Provider.of<PrayerTi>(context).myDay;

    double screenWidth = MediaQuery.of(context).size.width;
    var controller = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor:controller.kWhite ,
        appBar: AppBar(
          title: Text(
            'أوقات الصلاة حسب موقعك الجغرافي',
            style: GoogleFonts.amiri(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: controller.kBlack,
            ),
          ),
          backgroundColor: controller.kWhite,
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildContainerPray(screenWidth, theDay,controller),
                      buildContainerPray(
                          screenWidth, formatter.format(date).toString(),controller),
                    ],
                  ),
                   Divider(
                    thickness: 1,
                    color: controller.kBlack,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildContainerPray(screenWidth, 'الصلاة القادمة',controller),
                  buildContainerPray(
                      screenWidth, decidePray(next.toString().split('.')[1]),controller),
                ],
              ),
            ),
             Divider(
              color: controller.kBlack,
              thickness: 1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildContainerPray(screenWidth, 'موعد الصلاة القادمة',controller),
                  buildContainerPray(
                      screenWidth,
                      countdown == null
                          ? '_____'
                          : DateFormat.jm().format(countdown).toString(),controller),
                ],
              ),
            ),
            Divider(
              color: controller.kBlack,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                decoration:  BoxDecoration(
                  color: controller.kWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(
                        15,
                      )),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildContainerText('صلاة الفجر',controller),
                          buildContainerTime(screenWidth, prayerTimes.fajr,controller),
                        ],
                      ),
                    ),
                    //   buildContainer(prayerTimes.fajr,'صلاة الفجر'),
                     Divider(
                      thickness: 1,
                      color: controller.kBlack,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildContainerText('شروق الشمس',controller),
                          buildContainerTime(screenWidth, prayerTimes.sunrise,controller),
                        ],
                      ),
                    ),
                    //  buildContainer(prayerTimes.sunrise,'شروق الشمس'),
                    const Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildContainerText('صلاة الظهر',controller),
                          buildContainerTime(screenWidth, prayerTimes.dhuhr,controller),
                        ],
                      ),
                    ),
                    // buildContainer(prayerTimes.dhuhr,'صلاة الظهر'),
                    const Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildContainerText('صلاة العصر',controller),
                          buildContainerTime(screenWidth, prayerTimes.asr,controller),
                        ],
                      ),
                    ),
                    // buildContainer(prayerTimes.asr,'صلاة العصر'),
                    const Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildContainerText('صلاة المغرب',controller),
                          buildContainerTime(screenWidth, prayerTimes.maghrib,controller),
                        ],
                      ),
                    ),
                    // buildContainer(prayerTimes.maghrib,'صلاة المغرب'),
                    const Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildContainerText('صلاة العشاء',controller),
                          buildContainerTime(screenWidth, prayerTimes.isha,controller),
                        ],
                      ),
                    ),
                    //   buildContainer(prayerTimes.isha,'صلاة العشاء'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainerPray(screenWidth, title,controller) {
     return Container(
      // color: co,
      width: screenWidth / 2.4,
      child: Center(
        child: Container(
          // padding: const EdgeInsets.only(right: 20),
          alignment: Alignment.center,
          child: FittedBox(
            child: Text(
              title,
              style: GoogleFonts.amiri(
                  fontSize: 24,
                  color: controller.kBlack,
                  fontWeight: FontWeight.bold),
              // textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }

  FittedBox buildContainerTime(screenWidth, time,controller) {
    return FittedBox(
      child: FittedBox(
        child: Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Container(
              width: screenWidth / 3.5,
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat.jm().format(time).toString(),
                style: GoogleFonts.amiri(
                  color: controller.kBlack,
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

  Container buildContainerText(pray,controller) {
    return Container(
      alignment: Alignment.centerRight,
      child: FittedBox(
        child: Text(
          pray,
          style: GoogleFonts.amiri(
            color: controller.kBlack,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
