import '../../../../core/presentation/state_management/base_bloc.dart';
import '../../domain/usecases/check_login_usecase.dart';
import 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashState> {
  final CheckLoginUseCase _checkLoginUseCase;

  SplashBloc(this._checkLoginUseCase) : super(const SplashState());

  Future<void> checkLogin() async {
    // updateLoading(true); // Opcional, se quiser mostrar loader
    final result = await _checkLoginUseCase();
    // updateLoading(false);

    result.fold(
      (left) => emit(state.copyWith(status: SplashStatus.unauthenticated)),
      (isLogged) => emit(state.copyWith(
        status: isLogged ? SplashStatus.authenticated : SplashStatus.unauthenticated,
      )),
    );
  }
}
