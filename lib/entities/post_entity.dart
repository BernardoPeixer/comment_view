import 'package:comment_view/entities/comment_entity.dart';
import 'package:comment_view/entities/user_entity.dart';

class PostEntity {
  PostEntity({
    this.isLiked = false,
    this.postImage,
    required this.author,
    required this.comments,
    required this.postDate,
  });

  bool isLiked;
  final String? postImage;
  final UserEntity author;
  final List<CommentEntity> comments;
  final DateTime postDate;

  PostEntity copyWith({
    bool? isLiked,
    String? postImage,
    UserEntity? author,
    List<CommentEntity>? comments,
    DateTime? postDate,
  }) {
    return PostEntity(
      author: author ?? this.author,
      postDate: postDate ?? this.postDate,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
      postImage: postImage ?? this.postImage,
    );
  }
}
