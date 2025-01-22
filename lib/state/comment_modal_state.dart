import 'package:carousel_slider_plus/carousel_controller.dart';
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

  final _carouselController = CarouselSliderController();

  int actualPosition = 0;

  /// -------------------  GETTERS --------------------------------
  TextEditingController get commentController => _commentController;

  bool get heartIsShowing => _heartIsShowing;

  PostEntity get postEntity => _postEntity;

  FocusNode get commentFocus => _commentFocus;

  CarouselSliderController get carouselController => _carouselController;

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

  void reloadScreen() {
    notifyListeners();
  }

  void requestFocusComment() {
    _commentFocus.requestFocus();
    return;
  }

  (String?, int?) returnDateNumber(DateTime date) {
    final dateNow = DateTime.now();
    final difference = date.difference(dateNow);
    final duration = difference.abs();

    String? message;
    int? quantity;

    if (duration.inDays > 365) {
      quantity = (duration.inDays / 365).floor();
      message = quantity == 1 ? 'ano' : 'anos';
    } else if (duration.inDays > 30) {
      quantity = (duration.inDays / 30).floor();
      message = quantity == 1 ? 'mes' : 'meses';
    } else if (duration.inDays > 0) {
      quantity = duration.inDays;
      message = quantity == 1 ? 'dia' : 'dias';
    } else if (duration.inHours > 0) {
      quantity = duration.inHours;
      message = quantity == 1 ? 'hora' : 'horas';
    } else if (duration.inMinutes > 0) {
      quantity = duration.inMinutes;
      message = quantity == 1 ? 'minuto' : 'minutos';
    } else {
      quantity = duration.inSeconds;
      message = quantity == 1 ? 'segundo' : 'segundos';
    }

    return (message, quantity);
  }
}
