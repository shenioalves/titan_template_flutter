import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/config/flavors/flavors.dart';
import 'core/presentation/theme/app_theme.dart';

/// **Widget Raiz da Aplicação**
///
/// Ponto de entrada da árvore de Widgets. Responsável por configurações globais:
/// 1. Rotas (Modular)
/// 2. Tema e Localização
/// 3. Wrappers de desenvolvimento (DevicePreview, Banners)
/// 4. Proteção de Layout (TextScaler)
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
      //  TÍTULO
      // Define o nome do app na aba do navegador ou gerenciador de tarefas
      title: Flavors.appTitle,

      //  ROTAS (Modular)
      // Conecta o sistema de navegação do Modular ao MaterialApp
      routerConfig: Modular.routerConfig,

      // DEBUG
      // Remove a faixa "DEBUG" padrão do canto superior direito
      debugShowCheckedModeBanner: false,

      //  TEMA
      // Configuração de tema claro/escuro.
      theme: AppTheme.light(),
      // darkTheme: AppTheme.dark(), // Habilite se implementar Dark Mode
      // themeMode: ThemeMode.system,

      //  INTERNACIONALIZAÇÃO (I18n)
      // Registra os delegados de tradução e idiomas suportados.
      // Necessário para o DatePicker e outros widgets do Flutter funcionarem corretamente.
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],

      //  DEVICE PREVIEW
      // Permite que o DevicePreview controle o idioma do app dinamicamente nos testes.
      locale: DevicePreview.locale(context),

      // COMPORTAMENTO DE SCROLL
      // Permite arrastar listas com o mouse em Desktop/Web e configura o comportamento padrão.
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
        },
      ),

      //  BUILDER GLOBAL
      // Aqui interceptamos a construção do app para injetar comportamentos globais.
      // A ordem de aninhamento importa!
      builder: (context, child) {
        // 1. Device Preview: Envolve o app para simulação de telas
        Widget widget = DevicePreview.appBuilder(context, child);

        // 2. Proteção de Acessibilidade (Loomi):
        // Impede que fontes muito grandes do sistema quebrem o layout.
        // Limitamos o aumento da fonte a no máximo 20% (1.2). Ajuste conforme calibração do UI.
        final mediaQuery = MediaQuery.of(context);
        widget = MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: mediaQuery.textScaler.clamp(
              minScaleFactor: 1.0,
              maxScaleFactor: 1.2,
            ),
          ),
          child: widget,
        );

        // 3. Banner de Flavor (TITAN):
        // Se não for produção, mostra uma faixa (QA, DEV) para identificar o ambiente.
        widget = _applyFlavorBanner(context, widget);

        return widget;
      },
    );

  /// Adiciona uma faixa visual indicando o ambiente (QA, HML, DEV) se não for PROD.
  Widget _applyFlavorBanner(BuildContext context, Widget child) {
    if (Flavors.isProd) return child;

    return Banner(
      message: Flavors.current.name.toUpperCase(),
      textDirection: TextDirection.ltr,
      location: BannerLocation.topEnd,
      color: Colors.redAccent,
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      child: child,
    );
  }
}