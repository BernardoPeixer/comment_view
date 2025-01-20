import 'package:comment_view/entities/comment_response_entity.dart';
import 'package:comment_view/entities/user_entity.dart';

class CommentEntity {

  CommentEntity({
    required this.userEntity,
    required this.contentComment,
    required this.commentDate,
    this.commentResponse,
});

  final UserEntity userEntity;
  final String contentComment;
  final DateTime commentDate;
  final List<CommentResponseEntity>? commentResponse;

}