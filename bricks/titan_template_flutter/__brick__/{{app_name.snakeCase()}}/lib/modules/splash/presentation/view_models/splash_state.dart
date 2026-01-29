import '../../../../core/presentation/state_management/base_state.dart';
import '../../../../core/presentation/state_management/failure_state.dart';

enum SplashStatus { initial, loading, authenticated, unauthenticated }

class SplashState extends BaseState<SplashState> {
  final SplashStatus status;

  const SplashState({
    this.status = SplashStatus.initial,
    super.isLoading,
    super.failure,
  });

  @override
  SplashState copyWith({
    bool? isLoading,
    FailureState? failure,
    SplashStatus? status,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [isLoading, failure, status];
}
