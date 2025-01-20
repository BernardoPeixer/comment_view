import 'package:comment_view/entities/user_entity.dart';

class CommentResponseEntity {
  CommentResponseEntity({
    required this.userEntity,
    required this.commentResponseContent,
  });

  final UserEntity userEntity;
  final String commentResponseContent;
}
