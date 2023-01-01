
abstract class DbOperation<Model> {
  Future<int> create(Model model);

  Future<List<Model>> read();

  Future<bool> delete(int id);

}
