import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:themimictrial/state/constants/firebase_field_name.dart';
import 'package:themimictrial/state/posts/typedefs/post_id.dart';
import 'package:themimictrial/state/posts/typedefs/user_id.dart';

@immutable
class Like extends MapView<String, String> {
  Like({
    required PostId postId,
    required UserId likedBy,
    required DateTime date,
  }) : super(
          {
            FireBaseFieldName.postId: postId,
            FireBaseFieldName.userId: likedBy,
            FireBaseFieldName.date: date.toIso8601String(),
          },
        );
}
