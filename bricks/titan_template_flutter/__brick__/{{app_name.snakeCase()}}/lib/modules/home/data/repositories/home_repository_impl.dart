import '../../../../core/foundation/error/failure.dart';
import '../../../../core/foundation/result/result.dart';
import '../../../../core/infra/repositories/base_repository.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/params/get_posts_params.dart';
import '../../domain/repositories/i_home_repository.dart';
import '../datasources/i_home_datasource.dart';
import '../mappers/home_mapper.dart';
import '../models/post_model.dart';

class HomeRepositoryImpl extends BaseRepository implements IHomeRepository {
  final IHomeDatasource _datasource;

  HomeRepositoryImpl(this._datasource, super.handler);

  @override
  Future<Result<Failure, List<PostEntity>>> getPosts(GetPostsParams params) async {
    // 1. Chamamos o handler para tratar exceções HTTP (Try/Catch/NoInternet)
    final result = await handler.handleListRequest<PostModel>(
      _datasource.getPosts(params),
      PostModel.fromMap,
    );

    // 2. Aqui usamos o Mapper explicitamente
    // Se o result for Sucesso (Right), mapeamos a lista de Models para Entities
    return result.map(
      (models) => models.map(HomeMapper.toEntity).toList(),
    );
  }
}
