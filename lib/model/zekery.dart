class AzkaryModel {
  late int id;
  late String title;

  //read From database
  AzkaryModel.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    title = rowMap['title'];
  }

  AzkaryModel();

  // store on database
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    return map;
  }
}

class AlhamedModel {
  late int id;
  late String title;

  //read From database
  AlhamedModel.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    title = rowMap['title'];
  }

  AlhamedModel();

  // store on database
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    return map;
  }
}
