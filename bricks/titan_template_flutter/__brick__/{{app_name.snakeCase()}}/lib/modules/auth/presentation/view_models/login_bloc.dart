
import '../../../../core/presentation/state_management/base_bloc.dart';
import '../../../../core/presentation/state_management/failure_state.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginBloc extends BaseBloc<LoginState> {
  final LoginUsecase _loginUsecase;

  LoginBloc(this._loginUsecase) : super(const LoginState());

  Future<void> login({required String email, required String password}) async {
    updateLoading(true);
    
    final result = await _loginUsecase(LoginParams(email: email, password: password));
    
    updateLoading(false);

    result.fold(
      (failure) => handleFailureFrom(
        FailureState.of(failure.message), 
        asSnackbar: true
      ),
      (user) => emit(state.copyWith(status: LoginStatus.success)),
    );
  }
}
