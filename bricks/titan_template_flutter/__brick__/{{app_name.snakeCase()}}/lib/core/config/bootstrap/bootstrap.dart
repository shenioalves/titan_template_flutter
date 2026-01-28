import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app.dart';
import '../../di/app_module.dart';
import '../../infra/http/app_http_overrides.dart';
import '../../infra/log/log_impl.dart';
import '../flavors/flavor.dart';
import '../flavors/flavors.dart';

/// Função responsável por inicializar todo o ambiente antes da UI ser desenhada.
///
/// Recebe o [Flavor] (QA ou PROD) para configurar variáveis de ambiente específicas.
Future<void> bootstrap({required Flavor flavor}) async {
  // O runZonedGuarded cria uma "zona de proteção" ao redor do app.
  // Ele serve para capturar erros que o Flutter Framework não consegue pegar nativamente,
  // como exceções em operações assíncronas puras (Futures soltos) ou erros de inicialização.
  await runZonedGuarded(() async {
    // 1. Garante que a engine do Flutter (canais nativos, texturas, etc) esteja pronta.
    // Nenhuma plugin ou chamada nativa funciona antes dessa linha.
    WidgetsFlutterBinding.ensureInitialized();

    // 2. Configura overrides de HTTP.
    // Útil para desenvolvimento local onde certificados SSL podem ser auto-assinados,
    // evitando o erro "HandshakeException".
    HttpOverrides.global = AppHttpOverrides();

    // 3. Inicializa as configurações do sabor (Flavor) atual (URLs, Chaves, Títulos).
    Flavors.init(flavor);

    // 4. Inicializações Assíncronas Críticas (Opcionais)
    // Este é o momento ideal para iniciar serviços que o app NÃO pode rodar sem.
    // Ex: Firebase, LocalStorage (Hive/SharedPreferences), Crashlytics.
    // await Firebase.initializeApp();
    // await AppAnalytics.init();

    // 5. Execução do App
    // Envolvemos o app no DevicePreview para facilitar testes de responsividade.

    // Ele só ativa se passarmos a flag "--dart-define=device_preview=true" no comando de run.
  
    FlutterError.onError = (details) {
      // Log no Crashlytics
      LogImpl()
          .error(details.exceptionAsString(), details.exception, details.stack);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      // Log no Crashlytics
      LogImpl().error('Async Error', error, stack);
      return true;
    };
    runApp(
      DevicePreview(
        enabled: const bool.fromEnvironment('DEVICE_PREVIEW'),
        builder: (context) => ModularApp(
          // O AppModule contém todas as injeções de dependência globais (Bind) e Rotas principais.
          module: AppModule(),
          child: const App(),
        ),
      ),
    );
  }, (error, stackTrace) {
    // 6. Tratamento Global de Erros (Zone Errors)
    // Qualquer erro que escape dos try/catch do app cairá aqui.
    // Ideal para enviar para ferramentas de monitoramento (Sentry, Crashlytics, Datadog).
    debugPrint('🔴 ERRO CRÍTICO NÃO TRATADO (Zone): $error');
    debugPrint(stackTrace.toString());

    // Exemplo de envio para Crashlytics:
    // FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  });
}
