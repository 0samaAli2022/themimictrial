import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themimictrial/state/image_upload/typedefs/is_loading.dart';
import 'package:themimictrial/state/posts/notifiers/delete_post_state_notifier.dart';

final deletePostProvider =
    StateNotifierProvider<DeletePostStateNotifier, IsLoading>(
        (_) => DeletePostStateNotifier());
