import 'package:flutter/cupertino.dart';
import 'package:kh_project/db/controller/alhamed_controller.dart';

import '../model/zekery.dart';

class AlhamedProvider extends ChangeNotifier {


  List<AlhamedModel> alhamed = <AlhamedModel>[];

  final AlhamedController alhamedController = AlhamedController();



  void read() async {
    alhamed = await alhamedController.read();
    print(alhamed.length);
    notifyListeners();
  }

  Future<bool> create({required AlhamedModel alhamedModel}) async {
    int newRowId = await alhamedController.create(alhamedModel);
    if (newRowId != 0) {
      alhamedModel.id = newRowId;
      alhamed.add(alhamedModel);
      notifyListeners();
    }
    return newRowId != 0;
  }

  Future<bool> delete(/*int id*/ int index) async {
    bool deleted = await alhamedController.delete(alhamed[index].id);
    if (deleted) {
      alhamed.removeAt(index);
      notifyListeners();
      //*************
      // azkary.indexWhere((element) => element.id ==id);
      // notifyListeners();
      // ******************
      // int index = azkary.indexWhere((element) => element.id ==id);
      // if(index!=-1){
      //   azkary.removeAt(index);
      //   notifyListeners();
      // }
    }
    return deleted;
  }
}
