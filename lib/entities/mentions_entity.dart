import 'package:comment_view/entities/user_entity.dart';

/// Entity to mentions
class MentionsEntity {
  /// Constructor
  MentionsEntity({
    this.mentionedUser,
  });

  /// User as mentioned
  final UserEntity? mentionedUser;
}
