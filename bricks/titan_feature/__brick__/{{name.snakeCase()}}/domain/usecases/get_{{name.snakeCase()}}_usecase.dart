import '../../../../core/foundation/error/failure.dart';
import '../../../../core/foundation/result/result.dart';
import '../../../../core/foundation/usecase/usecase.dart';
import '../entities/{{name.snakeCase()}}_entity.dart';
import '../repositories/i_{{name.snakeCase()}}_repository.dart';

class Get{{name.pascalCase()}}Usecase extends UseCaseNoParams<{{name.pascalCase()}}Entity> {
  final I{{name.pascalCase()}}Repository _repository;

  Get{{name.pascalCase()}}Usecase(this._repository);

  @override
  Future<Result<Failure, {{name.pascalCase()}}Entity>> call() => _repository.get();
}
