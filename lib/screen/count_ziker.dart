import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/storge/pref_controller.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class CountOfZiker extends StatefulWidget {
  const CountOfZiker({
    Key? key,
    required this.title,
    required this.zikerAdd,
  }) : super(key: key);
  final String title;
  final int zikerAdd;

  @override
  State<CountOfZiker> createState() => _CountOfZikerState();
}

class _CountOfZikerState extends State<CountOfZiker> {


  int? count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(CacheHelper.getDataInt(key: 'sharedCount') == 0 || CacheHelper.getDataInt(key: 'sharedCount') == null ){
      CacheHelper.putDataInt(key: 'sharedCount', value: 0);
    }

    CacheHelper.putDataInt(key: 'sharedCount',value:CacheHelper.getDataInt(key: 'sharedCount')! + widget.zikerAdd ) ;

  }


  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ThemeProvider>(context, listen: false);
    Color v = Provider.of<ThemeProvider>(context) == ThemeData.dark()
        ? controller.kBlack
        : controller.kWhite;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller.kPrimary,
        actionsIconTheme: IconThemeData(color: controller.kWhite),
        elevation: 1,
        title: Text(
          widget.title,
          style: GoogleFonts.amiri(fontSize: 23, color: v),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: size.width * 1,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: controller.kPrimary,
                  child: Padding(
                    padding: EdgeInsets.all(
                      size.height * 0.12,
                    ),
                    child: Text(
                      'حاسبة الأذكار',
                      style: GoogleFonts.amiri(
                          fontSize: 23, color: controller.kWhite),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              //
            ],
          ),
          Center(
            child: Row(
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  height: size.width * 0.2,
                  padding:const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(15),
                      color: v,
                      border: Border.all(color: Colors.grey)),
                  child:const Text('اللأذكار المضافة'),
                ),
                Container(
                  alignment: Alignment.center,
                  width: size.width * 0.3,
                  height: size.width * 0.2,
                  padding:const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.grey)),
                  child: Text(widget.zikerAdd.toString()),
                ),
                Spacer()
              ],
            ),
          ),

          // shadowColor: Color(10)
          Positioned(
            bottom: size.height * 0.12,
            left: size.width * 0.12,
            child: SizedBox(
              height: size.height * 0.4,
              width: size.width * 0.75,
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    // width: size.width * 0.3,
                    height: size.width * 0.2,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(15),
                        color: v,
                        border: Border.all(color: Colors.grey)),
                    child: Text('اللأذكار المضافة'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 0.3,
                    height: size.width * 0.2,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                        border: Border.all(color: Colors.grey)),
                    child: Text(CacheHelper.getDataInt(key: 'sharedCount')!.toString()),
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
