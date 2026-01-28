import '../../../../core/presentation/state_management/base_state.dart';
import '../../../../core/presentation/state_management/failure_state.dart';

class {{name.pascalCase()}}State extends BaseState<{{name.pascalCase()}}State> {
  const {{name.pascalCase()}}State({super.isLoading, super.failure});

  factory {{name.pascalCase()}}State.initial() => const {{name.pascalCase()}}State();

  @override
  {{name.pascalCase()}}State copyWith({bool? isLoading, FailureState? failure}) {
    return {{name.pascalCase()}}State(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [isLoading, failure];
}
