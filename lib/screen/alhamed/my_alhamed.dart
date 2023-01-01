import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/provider/alhamed_zeker.dart';
import 'package:kh_project/provider/azkary_provider.dart';
import 'package:kh_project/screen/myazkar/add_azkar.dart';
import 'package:provider/provider.dart';

import '../../clipBoard.dart';
import '../../provider/theme_provider.dart';
import 'alhamed_add.dart';

class MyAlhamedlist extends StatefulWidget {
  const MyAlhamedlist({Key? key}) : super(key: key);

  @override
  State<MyAlhamedlist> createState() => _MyAlhamedlistState();
}

class _MyAlhamedlistState extends State<MyAlhamedlist> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AlhamedProvider>(context, listen: false).read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: controller.kPrimary,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: controller.kPrimary,
          centerTitle: true,
          title: Text(
            'أذكاري الخاصة ',
            style: GoogleFonts.amiri(
              fontSize: 18,
              color: controller.kWhite,
            ),
          ),
          actionsIconTheme: IconThemeData(color: controller.kWhite),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AlhamedAdd(),
                      ));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Consumer<AlhamedProvider>(
          builder: (context, value, child) {
            if (value.alhamed.isNotEmpty) {
              print('we are here');
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: controller.kWhite,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.alhamed[index].title,
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
                                onPressed: () => getClipboard(context,
                                    value.alhamed[index].title, 'تم نسخ الذكر'),
                                icon: Icon(
                                  Icons.copy,
                                  color: controller.kPrimary,
                                  size: 24,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () => deleteZiker(index),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                physics: const BouncingScrollPhysics(),
                itemCount: value.alhamed.length,
              );
            } else {
              return Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: controller.kWhite,
                        borderRadius: BorderRadius.circular(25)),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.32,
                    child: Text(
                      'لا يوجد أذكار خاصة بعد ,قم بأضافة ذكرك الخاص .. ',
                      style: GoogleFonts.amiri(fontSize: 22),
                    )),
              );
            }
          },
        ));
  }

  void deleteZiker(int index) async {
    await Provider.of<AlhamedProvider>(context, listen: false).delete(index);
  }
}
