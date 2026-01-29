import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ISplashDatasource {
  Future<bool> hasToken();
}

class SplashDatasourceImpl implements ISplashDatasource {
  final FlutterSecureStorage _storage;

  SplashDatasourceImpl(this._storage);

  @override
  Future<bool> hasToken() async {
    // Simula um tempo de carregamento para ver a splash
    await Future.delayed(const Duration(seconds: 2)); 
    
    // Verifica se existe token salvo
    final token = await _storage.read(key: 'auth_token');
    return token != null && token.isNotEmpty;
  }
}
