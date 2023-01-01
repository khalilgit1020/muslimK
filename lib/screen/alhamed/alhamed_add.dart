import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/provider/alhamed_zeker.dart';
import 'package:provider/provider.dart';

import '../../model/zekery.dart';
import '../../provider/theme_provider.dart';

class AlhamedAdd extends StatefulWidget {
  const AlhamedAdd({Key? key, this.azkaryModel}) : super(key: key);

  final AzkaryModel? azkaryModel;

  @override
  State<AlhamedAdd> createState() => _AlhamedAddState();
}

class _AlhamedAddState extends State<AlhamedAdd> {
  late TextEditingController titleController;

  @override
  void initState() {
    // TODO: implement initState
    titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: controller.kPrimary,
      appBar: AppBar(
        backgroundColor: controller.kPrimary,
        leading: BackButton(
          color: controller.kPrimary,
        ),
        centerTitle: true,
        title: Text(
          'دعاء جديد ',
          style: GoogleFonts.amiri(
            color: controller.kWhite,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: TextField(
              readOnly: true,
              cursorColor: Colors.teal,
              cursorRadius: const Radius.circular(15),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: controller.kWhite,
                  hintText: 'الحمد لله على',
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: controller.kWhite, width: 1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: controller.kWhite, width: 1)),
                  hintStyle: GoogleFonts.amiri(fontSize: 22)),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Container(
              color: controller.kWhite,
              // margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 40),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'أضف نعمة',
                      style: GoogleFonts.amiri(color: controller.kPrimary),
                    ),
                  ),
                  Text(
                    '|',
                    style: GoogleFonts.amiri(
                      fontSize: 18,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: titleController,
                      cursorColor: Colors.teal,
                      cursorRadius: const Radius.circular(15),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: controller.kWhite,
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: controller.kWhite,
                            width: 1,
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: controller.kWhite, width: 1)),
                          hintStyle: GoogleFonts.amiri(fontSize: 22)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await PerformZeker();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: controller.kWhite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            child: Text(
              'أضف ذكر ',
              style: GoogleFonts.amiri(
                color: Colors.teal,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> PerformZeker() async {
    if (checkData()) {
      await createZeker();
    }
  }

  bool checkData() {
    if (titleController.text.isNotEmpty) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'الرجاء اضافة الذكر الذي تريده',
          style: GoogleFonts.amiri(
            color: Provider.of<ThemeProvider>(context, listen: false).kWhite,
            fontSize: 18,
          ),
        ),
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
    return false;
  }

  Future<void> createZeker() async {
    Provider.of<AlhamedProvider>(context, listen: false)
        .create(alhamedModel: alhamedModel);
    Navigator.pop(context);
  }

  AlhamedModel get alhamedModel {
    AlhamedModel alhamedModel = AlhamedModel();
    alhamedModel.title = titleController.text;
    return alhamedModel;
  }
}
