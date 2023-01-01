import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/component.dart';
import 'package:kh_project/provider/theme_provider.dart';
import 'package:kh_project/screen/count_ziker.dart';
import 'package:provider/provider.dart';

import '../clipBoard.dart';
import '../model/azkar_list.dart';

class Zikr extends StatefulWidget {
  final String title;

  Zikr({required this.title});

  @override
  State<Zikr> createState() => _ZikrState();
}

class _ZikrState extends State<Zikr> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List? FindTheList() {
    if (widget.title == 'أذكار الصباح') return Azkar.morningZikr;
    if (widget.title == 'أذكار المساء') return Azkar.eveningZikr;
    if (widget.title == 'أذكار بعد الصلاة') return Azkar.AfterPrayZikr;
    if (widget.title == 'أذكار النوم') return Azkar.sleepZikr;
    if (widget.title == 'أذكار الإستيقاظ') return Azkar.wakeUpZikr;
    if (widget.title == 'أذكار الصلاة') return Azkar.prayZikr;
    if (widget.title == 'أذكار وأدعية نبوية') return Azkar.propheticPrayers;
    if (widget.title == 'أذكار الطعام') return Azkar.foodZikr;
    if (widget.title == 'أذكار المنزل') return Azkar.homeZikr;
    if (widget.title == 'أذكار المسجد') return Azkar.mosqueZikr;
    if (widget.title == 'أذكار الوضوء') return Azkar.ablutionZikr;
    if (widget.title == 'أذكار الأذان') return Azkar.callToPrayerZikr;
    if (widget.title == 'أذكار الخلاء') return Azkar.emptinessZikr;
    if (widget.title == 'أدعية للمتوفى (ذكور)') return Azkar.PrayForManDaeth;
    if (widget.title == 'أدعية للمتوفية (إناث)') return Azkar.PrayForWomanDaeth;
    if (widget.title == 'أدعية للميّت الطفل الصغير (ذكر أو أنثى)')
      return Azkar.PrayForBoyDaeth;
    if (widget.title == 'الدّعاء للميّت في صّلاة الجنازة')
      return Azkar.PrayForFurnalDaeth;
    if (widget.title == 'أذكار عشوائية') return Azkar.randomZikr;
    if (widget.title == 'الرقية الشرعية') return Azkar.roqia;
    return null;
  }

  // get foundZikr => FindTheList();

  List? zikr;
  List? foundZikr;
  int countOfZiker = 0;
  int? counter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    foundZikr = FindTheList();
    zikr = foundZikr!.map((e) => e[1]).toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var controller = Provider.of<ThemeProvider>(context, listen: false);
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: controller.kPrimary,
            appBar: AppBar(
            leading: const Icon(
              Icons.abc,
              color: Colors.transparent,
            ),
            actionsIconTheme: IconThemeData(color: controller.kWhite),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountOfZiker(
                            title: widget.title,
                            zikerAdd: countOfZiker,
                          ),
                        ));
                  },
                  icon: const Icon(Icons.arrow_forward))
            ],
            backgroundColor: controller.kPrimary,
            centerTitle: true,
            title: Text(
              widget.title,
              style: GoogleFonts.amiri(
                color: controller.kWhite,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          body: AnimatedList(
              key: _listKey,
              physics: const BouncingScrollPhysics(),
              initialItemCount: zikr!.length,
              itemBuilder: (context, int index, animation) {
                return _buildItem(animation, controller, index, screenHeight,
                    screenWidth, _listKey);
              }),
        ),
      ),
    );
  }

  Widget _buildItem(Animation<double> animation, controller, index,
      screenHeight, screenWidth, key) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: zikr![index] != 0 ? controller.kWhite : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding:
            const EdgeInsets.only(top: 18, bottom: 18.0, left: 12, right: 12),
        child: MaterialButton(
          splashColor: controller.kPrimary,
          onPressed: () {
            // if(zikr![index]==0){
            //   _removeItem(index);
            // }
            // if (zikr![index] == 1) {
            //   _removeItem(index);
            if (zikr![index] >= 1) {
              setState(() {
                zikr![index] = zikr![index] - 1;
                countOfZiker++;
              });
            } else if (zikr![index] == 1) {
              setState(() {
                countOfZiker++;
                // zikr!.removeAt(index);
              });
            }
            // else if (zikr![index] <=0){
            //   _removeItem(zikr![index]);
            // }
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                alignment: Alignment.topRight,
                child: InteractiveViewer(
                  maxScale: 2,
                  minScale: 0.4,
                  child: Text(
                    foundZikr![index][0],
                    style: GoogleFonts.amiri(
                      fontSize: 20,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                    textScaleFactor: 1.2,
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () => getClipboard(
                          context, foundZikr![index][0], 'تم نسخ الذكر'),
                      icon: Icon(
                        Icons.copy,
                        color: controller.kPrimary,
                        size: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: screenWidth / 5,
                      height: screenHeight / 16,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: controller.kPrimary,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            '${index + 1}',
                            style: GoogleFonts.amiri(color: controller.kWhite),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: screenWidth / 5,
                      height: screenHeight / 16,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: controller.kPrimary,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Icon(Icons.repeat,color: ,),
                          Visibility(
                            visible: zikr![index] != 0,
                            replacement: FittedBox(
                                child: Text(
                              'تم',
                              style:
                                  GoogleFonts.amiri(color: controller.kWhite),
                            )),
                            child: FittedBox(
                                child: Text(
                              'عدد التكرار',
                              style:
                                  GoogleFonts.amiri(color: controller.kWhite),
                            )),
                          ),
                          Visibility(
                            visible: zikr![index] != 0,
                            child: FittedBox(
                                child: Text(
                              zikr![index].toString(),
                              style:
                                  GoogleFonts.amiri(color: controller.kWhite),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeItem(int id) {
    //azkary.indexWhere((element) => element.id ==id);
    // int index  = zikr!.indexWhere((element) => element.id ==id);
    _listKey.currentState!.removeItem(id, (context, animation) {
      return SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        )),
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.purple,
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text("تمت القراءة", style: TextStyle(fontSize: 24)),
          ),
        ),
      );
    }, duration: const Duration(seconds: 1));
  }
}
