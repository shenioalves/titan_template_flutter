import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/auth/auth_module.dart';
import '../../modules/home/home_module.dart';
import '../routing/routes.dart';
import 'core_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.module(Routes.initial, module: AuthModule());

    r.module('/home', module: HomeModule());

    // Adicione novas rotas aqui
    super.routes(r);
  }
}
