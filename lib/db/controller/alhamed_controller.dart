import 'package:kh_project/db/db_controller.dart';
import 'package:kh_project/db/db_operation.dart';
import 'package:kh_project/model/zekery.dart';
import 'package:sqflite/sqflite.dart';

class AlhamedController implements DbOperation<AlhamedModel> {
  //CRUD -> ,Create ,Read ,Update , Delete

  Database database = DbController().database;

  @override
  Future<int> create(AlhamedModel model) async {
    int newRow = await database.insert('alhamed', model.toMap());
    return newRow;
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeleteRows =
        await database.delete('alhamed', where: 'id = ?', whereArgs: [id]);
    return countOfDeleteRows == 1;
  }

  @override
  Future<List<AlhamedModel>> read() async {
    List<Map<String, dynamic>> rows = await database.query('alhamed');
    List<AlhamedModel> alhamed = rows
        .map((Map<String, dynamic> row) => AlhamedModel.fromMap(row))
        .toList();
    return alhamed;
  }
}
