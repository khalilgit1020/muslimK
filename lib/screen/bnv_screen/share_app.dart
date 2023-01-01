import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../provider/theme_provider.dart';

class ShareAppScreen extends StatelessWidget {
  const ShareAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ThemeProvider>(context, listen: false);
    Color v= Provider.of<ThemeProvider>(context) == ThemeData.dark()
        ? controller.kBlack
        : controller.kWhite;
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                color: Colors.blueGrey.shade300,
                child: Text(
                  'شارك التطبيق لمن تعرفه الأن ليصبح "صدقة جارية " خاصة بك ! بحيث يتناقله\n ألاف الناس من بعدك',
                  style: GoogleFonts.amiri(fontSize: 23, color: controller.kBlack,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Container(
                // color: v,
              ),
            ),
            //
          ],
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.width / 1.3 ,
          left: MediaQuery.of(context).size.width / 8,
          child: ElevatedButton(
            onPressed: () {
              Share.share('ios:'
                  '\n'
                  'https://apple.co/33qsudl '
                  '\n'
                  'الاندرويد: '
                  '\n'
                  '  https://play.google.com/store/apps/details?id=com.azker96.azker1196');
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                backgroundColor: v,
                minimumSize: const Size(180, 90),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.grey, width: 1))
                // shadowColor: Color(10)
                ),
            child: Text(
              'مشاركة  التطبيق',
              style: GoogleFonts.amiri(color: controller.kBlack, fontSize: 22),
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.width / 2.3 ,
          left: MediaQuery.of(context).size.width / 8,
          child: Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                StoreRedirect.redirect(
                  androidAppId: "com.azker96.azker1196",
                  iOSAppId: "1004470625",
                );
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  backgroundColor: controller.kWhite,
                  minimumSize: const Size(180, 90),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.grey, width: 1),
                  )),
              child: Text(
                'تقييم التطبيق',
                style: GoogleFonts.amiri(color: controller.kBlack, fontSize: 23),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
