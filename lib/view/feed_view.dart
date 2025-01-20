import 'package:comment_view/entities/post_entity.dart';
import 'package:comment_view/entities/user_entity.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../entities/comment_entity.dart';
import '../state/comment_modal_state.dart';
import 'comment_modal.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
          child: const Text('Press'),
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return ChangeNotifierProvider(
                    create: (context) => PostCommentsState(
                      post: PostEntity(
                        author: UserEntity(username: 'Bernardo'),
                        postDate: DateTime.now(),
                        isLiked: false,
                        comments: [
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
                        ],
                      ),
                    ),
                    child: Center(
                      child: MediaQuery.of(context).size.width < 800
                          ? JustPost(
                              user: UserEntity(username: 'Bernardo'),
                            )
                          : PostWithComment(
                              user: UserEntity(username: 'Bernardo'),
                            ),
                    ),
                  );
                });
          }),
    );
  }
}
