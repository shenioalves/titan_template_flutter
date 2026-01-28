import 'package:flutter/material.dart';
import '../../../../core/presentation/state_management/bloc_view.dart';
import '../../../../core/presentation/widgets/app_scaffold.dart';
import '../view_models/{{name.snakeCase()}}_bloc.dart';
import '../view_models/{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocView<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State>(
      builder: (context, state) => AppScaffold(
        title: '{{name.pascalCase()}}',
        isLoading: state.isLoading,
        failure: state.failure,
        body: const Center(child: Text('Módulo {{name.pascalCase()}} gerado com sucesso!')),
      ),
    );
  }
}
