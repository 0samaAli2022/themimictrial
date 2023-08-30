import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themimictrial/state/constants/firebase_collection_name.dart';
import 'package:themimictrial/state/constants/firebase_field_name.dart';
import 'package:themimictrial/state/likes/models/like.dart';
import 'package:themimictrial/state/likes/models/like_dislike_request.dart';

final likeDislikePostProvider = FutureProvider.family
    .autoDispose<bool, LikeDislikeRequest>((ref, likeDislikeRequest) async {
  final query = FirebaseFirestore.instance
      .collection(FireBaseCollectionName.likes)
      .where(
        FireBaseFieldName.postId,
        isEqualTo: likeDislikeRequest.postId,
      )
      .where(
        FireBaseFieldName.userId,
        isEqualTo: likeDislikeRequest.likedBy,
      )
      .get();

  final hasLiked = await query.then((snapshot) => snapshot.docs.isNotEmpty);
  if (hasLiked) {
    try {
      await query.then(
          (snapshot) async => await snapshot.docs.first.reference.delete());
      return true;
    } catch (_) {
      return false;
    }
  } else {
    final like = Like(
      postId: likeDislikeRequest.postId,
      likedBy: likeDislikeRequest.likedBy,
      date: DateTime.now(),
    );
    try {
      await FirebaseFirestore.instance
          .collection(FireBaseCollectionName.likes)
          .add(like);
      return true;
    } catch (_) {
      return false;
    }
  }
});
