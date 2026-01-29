import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/auth/auth_module.dart';
import '../../modules/home/home_module.dart';
import '../../modules/splash/splash_module.dart';
import '../routing/routes.dart';
import 'core_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    // Rota Inicial agora é o Splash
    r.module(Routes.initial, module: SplashModule());

    // Rotas de Auth e Home
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());

    super.routes(r);
  }
}
