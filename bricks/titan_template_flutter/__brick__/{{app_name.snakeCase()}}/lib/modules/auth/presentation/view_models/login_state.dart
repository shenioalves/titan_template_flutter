import '../../../../core/presentation/state_management/base_state.dart';
import '../../../../core/presentation/state_management/failure_state.dart';


enum LoginStatus { initial, success, error }

class LoginState extends BaseState<LoginState> {
  final LoginStatus status;

  const LoginState({
    this.status = LoginStatus.initial,
    super.isLoading,
    super.failure,
  });

  @override
  LoginState copyWith({
    bool? isLoading,
    FailureState? failure,
    LoginStatus? status,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [isLoading, failure, status];
}
