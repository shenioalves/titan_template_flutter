import '../../../../core/foundation/error/failure.dart';
import '../../../../core/foundation/result/result.dart';
import '../../../../core/foundation/usecase/usecase.dart';
import '../entities/user_entity.dart';

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}

class LoginUsecase implements UseCase<LoginParams, UserEntity> {
  // Adicione o repositório aqui depois
  // final IAuthRepository repository;
  // LoginUsecase(this.repository);

  @override
  Future<Result<Failure, UserEntity>> call(LoginParams params) async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulação de Sucesso
    return Right(UserEntity(name: 'Usuário Teste', token: '123'));
    
    // Para testar erro, descomente abaixo:
    // return const Left(Failure(type: FailureType.unauthorized, message: 'Credenciais inválidas'));
  }
}
