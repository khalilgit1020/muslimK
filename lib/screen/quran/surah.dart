import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;

import '../../component.dart';
import '../../model/names.dart';
import '../../provider/All_surah.dart';
import '../../provider/theme_provider.dart';
import 'ayat_surah.dart';

class AllSurah extends StatefulWidget {
  const AllSurah({Key? key}) : super(key: key);

  @override
  State<AllSurah> createState() => _AllSurahState();
}

class _AllSurahState extends State<AllSurah> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ThemeProvider>(context);
    Orientation orientation = Orientation.portrait;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          appBar: AppBar(
            title: Text(
              'سور القران الكريم',
              style: GoogleFonts.cairo(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: controller.kBlack,
              ),
            ),
            backgroundColor: controller.kWhite,
            centerTitle: true,
            elevation: 2,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: NamesOfQuraan.names.length,
                      itemBuilder: (context, index) {
                        int ver = Provider.of<AllSu>(context, listen: false)
                            .getVerseCount(index);
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => AyatSurah(
                                      title: NamesOfQuraan.names[index],
                                      index: index + 1,
                                    )));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    orientation == Orientation.portrait ? 3 : 25,
                                vertical: 7),
                            decoration: BoxDecoration(
                              color: controller.kWhite,
                              border: Border.all(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: FittedBox(
                                      child: Text(
                                        Provider.of<AllSu>(context, listen: false)
                                                    .getPlaceOfRevelationByIndex(
                                                        index) ==
                                                'Madinah'
                                            ? 'مدنية'
                                            : 'مكية',
                                        style: GoogleFonts.cairo(
                                          fontSize: 14,
                                          // color: controller.kWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: screenWidth / 3,
                                        padding: const EdgeInsets.only(right: 8),
                                        child: FittedBox(
                                          child: Text(
                                            NamesOfQuraan.names[index],
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold,
                                              //   fontSize: 20,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        width: screenWidth / 1.7,
                                        padding: const EdgeInsets.only(right: 8),
                                        child: FittedBox(
                                          child: Text(
                                            '${NamesOfQuraan.pageNumber[index]} عدد الأيات $ver || رقم الجزء ${quran.getJuzNumber(index + 1, 1)} || رقم الصفحة ',
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold,
                                              // fontSize: 12,
                                              color: controller.kBlack,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CircleAvatar(
                                    backgroundColor: controller.kBlack,
                                    radius: 18,
                                    child: Center(
                                      child: FittedBox(
                                        child: Text(
                                          '${index + 1}',
                                          style: GoogleFonts.cairo(
                                              color: controller.kWhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _onPressed(context),
            child: const Icon(Icons.arrow_upward),
            backgroundColor: co,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  void _onPressed(context) {
    // Otherwise use this:
    _controller.animateTo(0,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 500));
  }
}
