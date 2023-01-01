import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/provider/azkary_provider.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class TsbehScreen extends StatefulWidget {
  const TsbehScreen({Key? key}) : super(key: key);

  @override
  State<TsbehScreen> createState() => _TsbehScreenState();
}

class _TsbehScreenState extends State<TsbehScreen> {
  int counterOfTasbeh = 0;

  void increment() {
    setState(() {
      counterOfTasbeh += 1;
    });
  }

  bool isSound = true;

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: controller.kWhite,
      appBar: AppBar(
        title: Text(
          'السبحة الاكترونية',
          style: GoogleFonts.amiri(
               color: controller.kBlack),
        ),
        elevation: 2,
        backgroundColor: controller.kWhite,
        leading: const BackButton(),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  isSound = !isSound;
                });
              },
              icon: isSound
                  ? const Icon(Icons.volume_up_outlined)
                  : Icon(Icons.volume_mute))
        ],
        iconTheme: IconThemeData(
          color: controller.kBlack,
        ),
      ),
      body: Consumer<AzkaryProvider>(
        builder: (context, value, child) => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'سبح اسم ربك الأعلى ',
                  style: GoogleFonts.amiri(
                    fontSize: 25,
                    color: controller.kBlack,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Center(
                  child: Text(
                    '(سبحان الله | الحمدلله | الله أكبر | لا اله ال الله)',
                    style: GoogleFonts.amiri(
                      fontSize: 22,
                      color: controller.kBlack,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Text(
                  counterOfTasbeh.toString(),
                  style: TextStyle(
                      fontSize: 50,
                      color: controller.kBlack,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'عدد التسبيح ',
                  style: TextStyle(
                    fontSize: 40,
                    color: controller.kBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.058,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: controller.kBlack,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              counterOfTasbeh = 0;
                            });
                          },
                          icon: Icon(
                            Icons.restart_alt,
                            color: controller.kWhite,
                            size: 30,
                          )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    increment();
                    value.sumIncrement();
                    final player = AudioPlayer();
                    if (isSound) {
                      print(isSound);
                      player.play(AssetSource('sound_button.mp3'));
                    }
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: controller.kBlack,
                    child: Center(
                        child: Icon(
                      Icons.add,
                      color: controller.kWhite,
                      size: 64,
                    )),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: controller.kBlack)),
                  child: Text(
                    'مجموع التسبيحات ${value.sumNum}',
                    style: GoogleFonts.amiri(
                        fontSize: 25, color: controller.kBlack),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
