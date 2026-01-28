class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  const PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) => PostModel(
    id: map['id'] ?? 0,
    userId: map['userId'] ?? 0,
    title: map['title'] ?? '',
    body: map['body'] ?? '',
  );
}
