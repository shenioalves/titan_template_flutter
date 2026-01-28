import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final appName = (context.vars['app_name'] as String).snakeCase;

  final setupProgress = context.logger.progress(
    '🛠️  Finalizando configuração do ambiente...',
  );

  Future<ProcessResult> runCmd(String cmd, List<String> args) async {
    return await Process.run(
      cmd,
      args,
      runInShell: true,
      workingDirectory: './$appName',
    );
  }

  try {
    setupProgress.update('📦 Baixando dependências do Flutter...');
    await runCmd('fvm', ['flutter', 'pub', 'get']);

    setupProgress.update('🧱 Inicializando Bricks de Feature...');
    await runCmd('mason', ['get']);

    setupProgress.complete('✅ Template gerado com sucesso!');

    context.logger.info('\n🚀 Projeto $appName pronto para decolar!');
    context.logger.info('👉 Próximos passos:');
    context.logger.info('  1. cd $appName');
    context.logger.info('  2. just qa');
  } catch (e) {
    setupProgress.fail('⚠️ Erro no post-gen: $e');
  }
}
