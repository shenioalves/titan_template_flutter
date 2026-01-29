import '../../../../core/foundation/error/failure.dart';
import '../../../../core/foundation/result/result.dart';
import '../../domain/repositories/i_splash_repository.dart';
import '../datasources/splash_datasource.dart';

class SplashRepositoryImpl implements ISplashRepository {
  final ISplashDatasource _datasource;

  SplashRepositoryImpl(this._datasource);

  @override
  Future<Result<Failure, bool>> checkIsLogged() async {
    try {
      final result = await _datasource.hasToken();
      return Right(result);
    } catch (e) {
      return const Left(Failure(type: FailureType.unknown, message: 'Erro ao verificar token'));
    }
  }
}
