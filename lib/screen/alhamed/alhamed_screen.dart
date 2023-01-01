import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/model/azkar_list.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import 'alhamed_list.dart';

class AlhamedScreen extends StatefulWidget {
  const AlhamedScreen({Key? key}) : super(key: key);

  @override
  State<AlhamedScreen> createState() => _AlhamedScreenState();
}

class _AlhamedScreenState extends State<AlhamedScreen> {
  bool finish = false;



  @override
  Widget build(BuildContext context) {

    var controller = Provider.of<ThemeProvider>(context,listen: false);

    return Scaffold(
      backgroundColor: controller.kWhite,
      appBar: AppBar(
        backgroundColor: controller.kWhite,
        elevation: 0,
        iconTheme: IconThemeData(color: controller.kBlack),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1),
            Text(
              'الحمدلله على ',
              style: GoogleFonts.amiri(fontSize: 70.0, color: controller.kBlack),
            ),
            DefaultTextStyle(
              style: GoogleFonts.amiri(fontSize: 70.0, color: Colors.teal.shade500),
              child: AnimatedTextKit(
                repeatForever: false,
                isRepeatingAnimation: false,
                onFinished: () {
                  print('finished animation');
                  setState(() {
                    finish = true;
                    print(finish);
                  });
                },
                animatedTexts:
                    Azkar.listHamed.map((e) => ScaleAnimatedText(e)).toList(),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.4),
            Visibility(
              visible: finish,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlhamedList(),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: controller.kBlack,
                          child: Icon(
                            Icons.add,
                            color: controller.kWhite,
                            size: 38,
                          ),
                        ),
                      ),
                      Text(
                        'اضافة و تعديل',
                        style: GoogleFonts.amiri(
                          color: controller.kBlack,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: controller.kBlack,
                          child: Icon(
                            Icons.cancel_outlined,
                            color: controller.kWhite,
                            size: 38,
                          ),
                        ),
                      ),
                      Text(
                        'خروج',
                        style: GoogleFonts.amiri(
                          color: controller.kBlack,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
