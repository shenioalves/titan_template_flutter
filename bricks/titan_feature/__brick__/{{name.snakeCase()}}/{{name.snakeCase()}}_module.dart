import 'package:flutter_modular/flutter_modular.dart';
import 'data/datasources/{{name.snakeCase()}}_datasource_impl.dart';
import 'data/repositories/{{name.snakeCase()}}_repository_impl.dart';
import 'domain/usecases/get_{{name.snakeCase()}}_usecase.dart';
import 'presentation/view_models/{{name.snakeCase()}}_bloc.dart';
import 'presentation/views/{{name.snakeCase()}}_page.dart';

class {{name.pascalCase()}}Module extends Module {
  @override
  void binds(i) {
    i.addLazySingleton({{name.pascalCase()}}DatasourceImpl.new);
    i.addLazySingleton({{name.pascalCase()}}RepositoryImpl.new);
    i.addLazySingleton(Get{{name.pascalCase()}}Usecase.new);
    i.addLazySingleton({{name.pascalCase()}}Bloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const {{name.pascalCase()}}Page());
  }
}
