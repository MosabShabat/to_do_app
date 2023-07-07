abstract class DBOperation<T> {
  //CRUD

  Future<int> insert({T data});
  Future<List<T>> read();
  Future<bool> update({T data});
  Future<int> delete({int? id});
}