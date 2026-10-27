import '../../../../core/error/result.dart';

abstract class HomeRepository {
  Future<Result<int>> getErPatientsCount();
  Future<Result<int>> getInPatientsCount();
}
