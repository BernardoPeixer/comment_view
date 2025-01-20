import 'package:comment_view/entities/comment_entity.dart';
import 'package:comment_view/entities/user_entity.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../entities/post_entity.dart';

class PostCommentsState extends ChangeNotifier {
  PostCommentsState({
    required PostEntity post,
  }) {
    _postEntity = post;
    commentController.addListener(notifyListeners);
  }

  /// ------------------- DECLARATIONS ---------------------------
  final _commentController = TextEditingController();
  bool _heartIsShowing = false;

  late PostEntity _postEntity;

  final _commentFocus = FocusNode();

  /// -------------------  GETTERS --------------------------------
  TextEditingController get commentController => _commentController;

  bool get heartIsShowing => _heartIsShowing;

  PostEntity get postEntity => _postEntity;

  FocusNode get commentFocus => _commentFocus;

  /// -------------------- SETTERS --------------------------------

  set heartIsShowing(bool value) {
    _heartIsShowing = value;
    notifyListeners();
  }

  /// ------------------- FUNCTION -------------------------------

  Future<void> likePostWithDoubleTap() async {
    _heartIsShowing = true;
    notifyListeners();
    _postEntity = postEntity.copyWith(
      isLiked: true,
    );
    await Future.delayed(
      const Duration(milliseconds: 600),
    );
    _heartIsShowing = false;
    notifyListeners();
  }

  void likePost() {
    _postEntity.isLiked = !_postEntity.isLiked;
    notifyListeners();
  }

  void addComment() {

    final comment = CommentEntity(
      userEntity: UserEntity(username: 'Bernardo'),
      contentComment: _commentController.text,
      commentDate: DateTime.now(),
    );

    _postEntity.comments.add(comment);

    _commentController.clear();

    notifyListeners();
  }

  void requestFocusComment() {
    _commentFocus.requestFocus();
    return;
  }
}
