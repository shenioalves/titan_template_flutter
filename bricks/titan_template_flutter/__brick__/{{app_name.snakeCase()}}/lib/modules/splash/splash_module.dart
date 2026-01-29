import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'data/datasources/splash_datasource.dart';
import 'data/repositories/splash_repository_impl.dart';
import 'domain/repositories/i_splash_repository.dart';
import 'domain/usecases/check_login_usecase.dart';
import 'presentation/view_models/splash_bloc.dart';
import 'presentation/views/splash_page.dart';

class SplashModule extends Module {
  @override
  void binds(Injector i) {
    // External
    i.addLazySingleton(FlutterSecureStorage.new);
    
    // Data
    i.addLazySingleton<ISplashDatasource>(SplashDatasourceImpl.new);
    i.addLazySingleton<ISplashRepository>(SplashRepositoryImpl.new);
    
    // Domain
    i.addLazySingleton(CheckLoginUseCase.new);
    
    // Presentation
    i.addLazySingleton(SplashBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const SplashPage());
  }
}
