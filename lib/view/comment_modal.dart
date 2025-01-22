import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:comment_view/entities/comment_entity.dart';
import 'package:comment_view/entities/post_entity.dart';
import 'package:comment_view/entities/user_entity.dart';
import 'package:comment_view/util/circle_user_image.dart';
import 'package:comment_view/util/text_button_default.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../state/comment_modal_state.dart';

class PostWithComment extends StatelessWidget {
  const PostWithComment({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PostCommentsState>(context);
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 600,
        maxWidth: 800,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _ImageSection(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(
                    user: user,
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.postEntity.comments.length,
                      itemBuilder: (context, index) {
                        final comment = state.postEntity.comments[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: _SingleComment(
                            commentEntity: CommentEntity(
                              userEntity: comment.userEntity,
                              contentComment: comment.contentComment,
                              commentDate: comment.commentDate,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  const _PostActions(),
                  const Divider(),
                  const _CommentWrite(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JustPost extends StatelessWidget {
  const JustPost({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PostHeader(
              user: user,
            ),
            SizedBox(
              height: 450,
              child: Image.network(
                'https://th.bing.com/th/id/OIP.zz9qT2DAH-9GNx6i6lkqiwAAAA?w=274&h=167&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                fit: BoxFit.fitHeight,
              ),
            ),
            const _PostActions(),
          ],
        ),
      ),
    );
  }
}

class _CommentWrite extends StatelessWidget {
  const _CommentWrite();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PostCommentsState>(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormBox(
              controller: state.commentController,
              validator: (value) {
                if (state.commentController.text.trim().isEmpty) {
                  return 'Campo não pode ser vazio';
                }
                return null;
              },
              focusNode: state.commentFocus,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: TextButtonDefault(
              text: 'Publicar',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: state.commentController.text.isEmpty
                      ? const Color(0xffbfbbbb)
                      : Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                state.commentController.text.isNotEmpty
                    ? state.addComment()
                    : null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PostCommentsState>(context);
    final PostEntity post = state.postEntity;
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              disableCenter: false,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              padEnds: false,
              pageSnapping: true,
              aspectRatio: 1,
              autoPlay: false,
              animateToClosest: true,
              viewportFraction: 1,
              onPageChanged: (int actualPage, _) {
                state.actualPosition = actualPage;
                state.reloadScreen();
              }
            ),
            controller: state.carouselController,
            items: [
              for(final item in post.postImage ?? [])
              _ItemSlider(
                state: state,
                image:
                    item
              ),
            ],
          ),
          if(state.actualPosition != 0)
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  state.carouselController.previousPage();
                },
                child: const Icon(
                  material.Icons.arrow_circle_left,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          if(state.actualPosition != (post.postImage?.length ?? 0) - 1)
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  state.carouselController.nextPage();
                  state.actualPosition++;
                  state.reloadScreen();
                },
                child: const Icon(
                  material.Icons.arrow_circle_right,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          if (state.heartIsShowing) ...[
            const AnimatedSize(
              duration: Duration(milliseconds: 400),
              alignment: Alignment.center,
              child: _IconAnimated(),
            ),
          ] else
            const AnimatedSize(
                duration: Duration(milliseconds: 400),
                alignment: Alignment.center,
                child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

class _ItemSlider extends StatelessWidget {
  const _ItemSlider({super.key, required this.state, required this.image});

  final PostCommentsState state;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        await state.likePostWithDoubleTap();
      },
      child: Container(
        color: Colors.black,
        child: Image.network(
          image,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class _IconAnimated extends StatefulWidget {
  const _IconAnimated();

  @override
  State<_IconAnimated> createState() => _IconAnimatedState();
}

class _IconAnimatedState extends State<_IconAnimated>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment.bottomCenter,
    end: Alignment.center,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlignTransition(
      alignment: _animation,
      child: Icon(
        FluentIcons.heart_fill,
        size: 80,
        color: Colors.red,
      ),
    );
  }
}

class _SingleComment extends StatelessWidget {
  const _SingleComment({
    required this.commentEntity,
  });

  final CommentEntity commentEntity;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PostCommentsState>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleUserImage(),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  commentEntity.userEntity.username,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  commentEntity.contentComment,
                  style: const TextStyle(fontSize: 14),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2,
                  ),
                ),
                Text(
                  '${state.returnDateNumber(commentEntity.commentDate).$2} ${state.returnDateNumber(commentEntity.commentDate).$1}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostActions extends StatelessWidget {
  const _PostActions();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PostCommentsState>(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  (state.postEntity.isLiked)
                      ? FluentIcons.heart_fill
                      : FluentIcons.heart,
                  size: 26,
                  color: (state.postEntity.isLiked) ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  state.likePost();
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
              ),
              IconButton(
                icon: const Icon(
                  FluentIcons.comment,
                  size: 26,
                ),
                onPressed: () {
                  state.requestFocusComment();
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Há ${state.returnDateNumber(state.postEntity.postDate).$2} ${state.returnDateNumber(state.postEntity.postDate).$1}'),
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      height: 70,
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleUserImage(),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                ),
              ),
              Text(
                user.username,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
              ),
            ],
          ),
          const Icon(
            FluentIcons.more,
            size: 25,
          )
        ],
      ),
    );
  }
}
