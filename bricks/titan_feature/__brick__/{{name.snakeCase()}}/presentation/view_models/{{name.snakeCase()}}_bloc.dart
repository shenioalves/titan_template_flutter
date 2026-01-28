import '../../../../core/presentation/state_management/base_bloc.dart';
import '../../domain/usecases/get_{{name.snakeCase()}}_usecase.dart';
import '{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Bloc extends BaseBloc<{{name.pascalCase()}}State> {
  final Get{{name.pascalCase()}}Usecase _usecase;

  {{name.pascalCase()}}Bloc(this._usecase) : super({{name.pascalCase()}}State.initial());

  Future<void> init() async {
    updateLoading(true);
    // Lógica inicial aqui
    updateLoading(false);
  }
}
