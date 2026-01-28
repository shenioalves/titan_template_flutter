import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../core/presentation/state_management/bloc_view.dart';
import '../../../../core/presentation/widgets/app_scaffold.dart';
import '../view_models/home_bloc.dart';
import '../view_models/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc get bloc => context.read<HomeBloc>();
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(bloc.getPosts);
  }

  @override
  Widget build(BuildContext context) => BlocView<HomeBloc, HomeState>(
        builder: (context, state) => AppScaffold(
          isLoading: state.isLoading,
          failure: state.failure,
          title: 'Home',
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: state.posts
                    .map(
                      (post) => Card(
                        child: ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      );
}
