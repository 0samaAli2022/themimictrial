import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themimictrial/state/post_settings/models/post_settings.dart';
import 'package:themimictrial/state/post_settings/notifiers/post_settings_notifier.dart';

final postSettingsProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSetting, bool>>(
  (_) => PostSettingNotifier(),
);
