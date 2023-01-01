import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/provider/theme_provider.dart';
import 'package:kh_project/screen/zikr.dart';
import 'package:provider/provider.dart';

import '../model/azkar_list.dart';

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  @override
  Widget build(BuildContext context) {

    var controller = Provider.of<ThemeProvider>(context, listen: false);
    Color v= Provider.of<ThemeProvider>(context) == ThemeData.dark()
        ? controller.kBlack
        : controller.kWhite;
    return Scaffold(
      backgroundColor: controller.kWhite,
      appBar: AppBar(
        backgroundColor:controller.kWhite,
        title: Text('الأذكار',style: GoogleFonts.amiri(color: controller.kBlack),),
        iconTheme: IconThemeData(color: controller.kBlack),
      ),
      body:GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Zikr(title: Dummy_Zikr[index].title),
              ),
            );
          },
          child: Card(
            color: v,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: controller.kBlack)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(zikerImage[index],height: MediaQuery.of(context).size.height *0.09),
                  Text(
                    Dummy_Zikr[index].title,
                    style: GoogleFonts.amiri(fontSize: MediaQuery.of(context).size.height * 0.025),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        itemCount: Dummy_Zikr.length,
      ),
    );
  }
}
