import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_project/model/azkar_list.dart';
import 'package:kh_project/screen/alhamed/my_alhamed.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import '../myazkar/my_azkar_list.dart';


class AlhamedList extends StatefulWidget {
  const AlhamedList({Key? key}) : super(key: key);

  @override
  State<AlhamedList> createState() => _AlhamedListState();
}

class _AlhamedListState extends State<AlhamedList>
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
        backgroundColor: controller.kPrimary,
        bottom: TabBar(
          onTap: (int value) {
            setState(() {
              _tabController.index = value;
            });
            print(value);
          },
          indicatorWeight: 5,
          indicatorColor: Colors.orange,
          labelColor: controller.kBlack,
          controller: _tabController,
          tabs:  [
            Tab(child: Text('أذكار التطبيق ',style: GoogleFonts.amiri(fontSize: 18,color: controller.kWhite),),),
            Tab(child: Text('أذكاري ',style: GoogleFonts.amiri(fontSize: 18,color: controller.kWhite),),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.separated(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            itemCount: 5,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.shade200,
                    spreadRadius: 3,
                    blurRadius: 5,
                  ),
                ],
                color: Colors.teal.shade400,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'الحمد لله على ',
                    style: GoogleFonts.amiri(color: controller.kWhite, fontSize: 30),
                  ),
                  Text(
                    Azkar.listHamed[index],
                    style:
                    GoogleFonts.amiri(color: Colors.purple, fontSize: 25),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ),
          const MyAlhamedlist()
        ],
      ),
    );
  }
}



/*

 */