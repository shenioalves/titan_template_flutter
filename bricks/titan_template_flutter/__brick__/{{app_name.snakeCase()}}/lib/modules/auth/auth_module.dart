import 'package:flutter_modular/flutter_modular.dart';
import 'domain/usecases/login_usecase.dart';
import 'presentation/view_models/login_bloc.dart';
import 'presentation/views/login_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    // Domain
    i.addLazySingleton(LoginUsecase.new);
    
    // Presentation
    i.addLazySingleton(LoginBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const LoginPage());
    // r.child('/recovery', child: (_) => const PasswordRecoveryPage());
  }
}
