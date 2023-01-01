import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kh_project/provider/theme_provider.dart';
import 'package:kh_project/screen/bnv_screen/pray_time.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import '../component.dart';
import '../model/bnb_model.dart';
import '../storge/pref_controller.dart';
import '../widget/image_icon.dart';
import 'bnv_screen/home_app.dart';
import 'bnv_screen/qiblah.dart';
import 'bnv_screen/share_app.dart';
import 'quran/surah.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<BNBModel> listScreen = <BNBModel>[
    BNBModel(title: 'الصفحة الرئيسية', body: const HomeApp()),
    BNBModel(title: 'مواقيت الصلاة', body: PrayTime()),
    BNBModel(title: 'القرآن الكريم', body: const AllSurah()),
    BNBModel(title: 'القبلة ', body:  const Qiblah()),
    BNBModel(title: 'صدقة جارية', body: const ShareAppScreen()),
  ];
  IconData iconMode = Icons.dark_mode_outlined;

  BannerAd? bannerAd;
  bool isLoaded = false;

  InterstitialAd? interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRandomZikr();

    Workmanager().registerPeriodicTask(
      "1",
      "periodic Notification",
      frequency: const Duration(hours: 1),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    InterstitialAd.load(
      adUnitId: "ca-app-pub-8189351478187072/5614570591",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
            interstitialAd = ad;
          });
          print('interstitial loaded');
        },
        onAdFailedToLoad: (error) {
          print('interstitial Ad failed to load ;');
        },
      ),
    );
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-8189351478187072/9745387296",
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
          });
          print('Banner Ad Loaded ');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: controller.kWhite,
      appBar: currentIndex != 1
          ? AppBar(
              backgroundColor: controller.kWhite,
              // centerTitle: currentIndex == 3 ? false : true,
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        iconMode = iconMode == Icons.sunny
                            ? Icons.dark_mode_outlined
                            : Icons.sunny;
                      });
                      controller.changeTheme();
                      print('****************');
                      print(CacheHelper.sharedPreferences!.getBool('isDarkMode'));
                      print('****************');
                    },
                    icon: Icon(iconMode, color: controller.kBlack))
              ],
              actionsIconTheme: IconThemeData(color: controller.kBlack),
              elevation: 0,
              title: Text(
                listScreen[currentIndex].title,
                style:
                    GoogleFonts.amiri(fontSize: 20, color: controller.kBlack),
              ),
            )
          : null,
      body: Stack(
        children: [
          listScreen[currentIndex].body,
          isLoaded
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: AdWidget(ad: bannerAd!),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      bottomNavigationBar: Container(
        // clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: co,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          boxShadow: const [
            BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 0)
          ],
        ),
        child: BottomNavigationBar(
          elevation: 2,
          backgroundColor: controller.kWhite,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            if (isLoaded) {
              interstitialAd!.show();
            }
          },
          selectedItemColor: controller.kBlack,
          unselectedItemColor: controller.kBlack,
          items: [
            BottomNavigationBarItem(
              icon: ImagesIcons('assets/image/home.png',
                  active: false, color: controller.kBlack),
              activeIcon: ImagesIcons('assets/image/active_home.png'),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: ImagesIcons('assets/image/prayer-mat.png',
                  active: false, color: controller.kBlack),
              label: 'أوقات الصلاة',
              activeIcon: ImagesIcons('assets/image/prayer-mat (1).png'),
            ),
            BottomNavigationBarItem(
              icon: ImagesIcons('assets/image/koran (1).png',
                  active: false, color: controller.kBlack),
              activeIcon: ImagesIcons('assets/image/quran (4).png'),
              // activeIcon: Icon(Icons.access_time_filled),
              label: 'القرأن الكريم',
            ),
            BottomNavigationBarItem(
              icon: ImagesIcons('assets/image/kaaba.png',
                  active: false, color: controller.kBlack),
              activeIcon: ImagesIcons('assets/image/kaaba (1).png'),
              label: 'القبلة',
            ),
            BottomNavigationBarItem(
              icon: ImagesIcons('assets/image/gear.png',
                  active: false, color: controller.kBlack),
              activeIcon: ImagesIcons('assets/image/setting.png'),
              label: 'مشاركة',
            ),
          ],
        ),
      ),
    );
  }
}


