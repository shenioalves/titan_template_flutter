import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/legacy/color_theme.dart';
import '../../../../core/presentation/state_management/bloc_view.dart';
import '../view_models/splash_bloc.dart';
import '../view_models/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    ReadContext(context).read<SplashBloc>().checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocView<SplashBloc, SplashState>(
      builder: (context, state) => BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.status == SplashStatus.authenticated) {
            Modular.to.navigate('/home/');
          } else if (state.status == SplashStatus.unauthenticated) {
            Modular.to.navigate('/auth/');
          }
        },
        child: Scaffold(
          backgroundColor: ColorTheme.background,
          body: Center(
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                // Fallback caso a imagem não exista ainda
                return const Icon(Icons.rocket_launch,
                    size: 100, color: Colors.white);
              },
            ),
          ),
        ),
      ),
    );
  }
}
