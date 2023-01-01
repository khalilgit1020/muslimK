import 'package:kh_project/db/db_controller.dart';
import 'package:kh_project/db/db_operation.dart';
import 'package:kh_project/model/zekery.dart';
import 'package:sqflite/sqflite.dart';

class AzkaryController implements DbOperation<AzkaryModel> {
  //CRUD -> ,Create ,Read ,Update , Delete

  Database database = DbController().database;

  @override
  Future<int> create(AzkaryModel model) async {
    // INSERT INTO azkary (title) VALUES ('TITLE');
    // INSERT INTO azkary ('title') ;
    int newRow = await database.insert('azkary', model.toMap());
    return newRow;
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeleteRows =
        await database.delete('azkary', where: 'id = ?', whereArgs: [id]);
    return countOfDeleteRows == 1;
  }

  @override
  Future<List<AzkaryModel>> read() async {
    List<Map<String, dynamic>> rows = await database.query('azkary');
    List<AzkaryModel> azkary = rows
        .map((Map<String, dynamic> row) => AzkaryModel.fromMap(row))
        .toList();
    return azkary;
  }
}
