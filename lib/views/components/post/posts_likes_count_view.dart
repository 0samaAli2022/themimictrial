import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themimictrial/state/likes/providers/posts_likes_count_provider.dart';
import 'package:themimictrial/state/posts/typedefs/post_id.dart';
import 'package:themimictrial/views/components/animations/animation_views.dart';
import 'package:themimictrial/views/components/constants/strings.dart';

class PostLikesCountView extends ConsumerWidget {
  final PostId postId;
  const PostLikesCountView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(postLikesCountProvider(postId));
    return likesCount.when(
      data: (likesCount) {
        final people = likesCount == 1 ? Strings.person : Strings.people;
        return Text('$likesCount $people ${Strings.likedThis}');
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
