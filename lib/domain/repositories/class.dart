import '../class.dart';

abstract class ClassRepository {
  Future<List<Class>> getAll(String tenant);
}
