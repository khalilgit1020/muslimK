import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/model/azkar_list.dart';
import 'package:kh_project/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import 'myazkar/my_azkar_list.dart';

class AzkaryScreen extends StatefulWidget {
  const AzkaryScreen({Key? key}) : super(key: key);

  @override
  State<AzkaryScreen> createState() => _AzkaryScreenState();
}

class _AzkaryScreenState extends State<AzkaryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: controller.kWhite,
      appBar: AppBar(
        title: Text('أذكاري الخاصة',style: GoogleFonts.amiri(fontSize: 18,color: controller.kBlack),),
        iconTheme: IconThemeData(color: controller.kBlack),
        backgroundColor: controller.kWhite,
        bottom: TabBar(
          onTap: (int value) {
            setState(() {
              _tabController.index = value;
            });
            print(value);
          },
          indicatorWeight: 5,
          indicatorColor: Colors.orange,
          // indicatorSize: TabBarIndicatorSize.label,
          labelColor: controller.kBlack,
          // unselectedLabelColor: controller.Black45,
          controller: _tabController,
          tabs:  [
            Tab(child: Text('أذكار التطبيق ',style: GoogleFonts.amiri(fontSize: 18,color: controller.kBlack),),),
            Tab(child: Text('أذكاري ',style: GoogleFonts.amiri(fontSize: 18,color: controller.kBlack),),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemBuilder: (context, index) => Card(
              shape:const  UnderlineInputBorder(
                borderSide: BorderSide(width: 2)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  Azkar.randomZikr[index][0],
                  style: GoogleFonts.amiri(
                    fontSize: 23
                  ),
                ),
              ),
            ),
            itemCount: Azkar.randomZikr.length,
          ),
          const MyAzkarList()
        ],
      ),
    );
  }
}
