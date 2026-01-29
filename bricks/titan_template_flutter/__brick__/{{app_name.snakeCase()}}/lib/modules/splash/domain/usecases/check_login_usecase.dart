import '../../../../core/foundation/error/failure.dart';
import '../../../../core/foundation/result/result.dart';
import '../../../../core/foundation/usecase/usecase.dart';
import '../repositories/i_splash_repository.dart';

class CheckLoginUseCase extends UseCaseNoParams<bool> {
  final ISplashRepository _repository;

  CheckLoginUseCase(this._repository);

  @override
  Future<Result<Failure, bool>> call() => _repository.checkIsLogged();
}
