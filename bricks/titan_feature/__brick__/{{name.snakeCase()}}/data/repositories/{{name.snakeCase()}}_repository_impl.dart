import '../../../../core/foundation/error/failure.dart';
import '../../../../core/foundation/result/result.dart';
import '../../../../core/infra/repositories/base_repository.dart';
import '../../domain/entities/{{name.snakeCase()}}_entity.dart';
import '../../domain/repositories/i_{{name.snakeCase()}}_repository.dart';
import '../datasources/i_{{name.snakeCase()}}_datasource.dart';

class {{name.pascalCase()}}RepositoryImpl extends BaseRepository implements I{{name.pascalCase()}}Repository {
  final I{{name.pascalCase()}}Datasource _datasource;

  {{name.pascalCase()}}RepositoryImpl(this._datasource, super.handler);

  @override
  Future<Result<Failure, {{name.pascalCase()}}Entity>> get() async {
    // Implementar mapeamento aqui
    return const Left(Failure(type: FailureType.unknown, message: 'Implementação pendente'));
  }
}
