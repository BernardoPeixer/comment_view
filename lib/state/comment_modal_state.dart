import 'package:comment_view/entities/comment_entity.dart';
import 'package:comment_view/entities/user_entity.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../entities/post_entity.dart';

class PostCommentsState extends ChangeNotifier {
  /// ------------------- DECLARATIONS ---------------------------

  final _commentList = <CommentEntity>[
    CommentEntity(
      contentComment: 'Que postagem motivadora!',
      userEntity: UserEntity(
        username: 'LINCE TECH',
      ),
      commentDate: DateTime.now(),
    ),
    CommentEntity(
      contentComment: 'Muito legal!',
      userEntity: UserEntity(
        username: 'Paytrack',
      ),
      commentDate: DateTime.now(),
    ),
    CommentEntity(
      contentComment: 'Uau!',
      userEntity: UserEntity(
        username: 'SYYNC',
      ),
      commentDate: DateTime.now(),
    ),
  ];
  final _commentController = TextEditingController();
  bool _heartIsShowing = false;

  PostEntity? _postEntity;

  /// -------------------  GETTERS --------------------------------
  TextEditingController get commentController => _commentController;

  List<CommentEntity> get commentList => _commentList;

  bool get heartIsShowing => _heartIsShowing;

  PostEntity? get postEntity => _postEntity;

  /// -------------------- SETTERS --------------------------------

  set heartIsShowing(bool value) {
    _heartIsShowing = value;
    notifyListeners();
  }

  /// ------------------- FUNCTION -------------------------------

  Future<void> likePostWithDoubleTap() async {
    heartIsShowing = true;
    await Future.delayed(
      const Duration(milliseconds: 600),
    );
    heartIsShowing = false;
  }
}
