import '../../../../core/infra/http/i_http.dart';
import '../../../../core/infra/http/models/http_response_model.dart';
import 'i_{{name.snakeCase()}}_datasource.dart';

class {{name.pascalCase()}}DatasourceImpl implements I{{name.pascalCase()}}Datasource {
  final IHttp _http;
  {{name.pascalCase()}}DatasourceImpl(this._http);
  @override
  Future<HttpResponseModel> get() async => _http.get(Uri.parse('URL_AQUI'));
}
