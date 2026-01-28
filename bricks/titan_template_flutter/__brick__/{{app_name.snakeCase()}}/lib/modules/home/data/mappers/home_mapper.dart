import '../../domain/entities/post_entity.dart';
import '../models/post_model.dart';

/// **Mapper da Home**
///
/// Responsável por converter os objetos crus da API (Models) em objetos
/// de negócio seguros (Entities).
///
/// Vantagens:
/// 1. Remove lógica de conversão de dentro do Model.
/// 2. Permite tratar nulos e valores padrão aqui, mantendo a Entity limpa.
/// 3. Se a API mudar, a Entity não é afetada.
abstract class HomeMapper {
  
  // Converte de DTO (Data) -> Entity (Domain)
  static PostEntity toEntity(PostModel model) => PostEntity(
      id: model.id,
      userId: model.userId,
      title: model.title,
      // Exemplo de tratamento: Se vier nulo da API, a entity recebe vazio.
      body: model.body.isNotEmpty ? model.body : 'Sem conteúdo', 
    );

  // (Opcional) Converte de Entity (Domain) -> Map (Data)
  // Útil para POST/PUT
  static Map<String, dynamic> toMap(PostEntity entity) => {
      'id': entity.id,
      'userId': entity.userId,
      'title': entity.title,
      'body': entity.body,
    };
}