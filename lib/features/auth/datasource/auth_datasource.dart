abstract class AuthDatasource {
  Future<int> registerUSer();
}

class AuthDatasourceImpl implements AuthDatasource {
  @override
  Future<int> registerUSer() {
    throw UnimplementedError();
  }
}
