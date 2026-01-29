import '../../../../core/foundation/error/failure.dart';
import '../../../../core/foundation/result/result.dart';

abstract class ISplashRepository {
  Future<Result<Failure, bool>> checkIsLogged();
}
