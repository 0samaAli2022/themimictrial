import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themimictrial/state/auth/providers/user_id_provider.dart';
import 'package:themimictrial/state/image_upload/models/file_type.dart';
import 'package:themimictrial/state/image_upload/models/thumbnail_request.dart';
import 'package:themimictrial/state/image_upload/providers/image_uploader_provider.dart';
import 'package:themimictrial/state/post_settings/models/post_settings.dart';
import 'package:themimictrial/state/post_settings/providers/post_settings_provider.dart';
import 'package:themimictrial/utils/loading_dialog.dart';
import 'package:themimictrial/views/components/constants/strings.dart' as str;
import 'package:themimictrial/views/components/file_thumbnail_view.dart';
import 'package:themimictrial/views/constants/strings.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;
  const CreateNewPostView({
    super.key,
    required this.fileToPost,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );
    final postSettings = ref.watch(postSettingsProvider);
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);

      return () {
        postController.removeListener(listener);
      };
    }, [postController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createNewPost),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: isPostButtonEnabled.value
                  ? () async {
                      final userId = ref.read(userIdProvider);
                      if (userId == null) {
                        return;
                      }
                      final message = postController.text;
                      loadingScrean(context, str.Strings.loading);
                      final isUploaded =
                          await ref.read(imageUploadProvider.notifier).upload(
                                file: widget.fileToPost,
                                fileType: widget.fileType,
                                message: message,
                                postSettings: postSettings,
                                userId: userId,
                              );
                      if (isUploaded && mounted) {
                        // pop the loading screen
                        Navigator.of(context).pop();
                        // pop the create new post screen
                        Navigator.of(context).pop();
                      }
                    }
                  : null,
              icon: const Icon(Icons.send),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // thumbnail
            FileThumbnailView(
              thumbnailRequest: thumbnailRequest,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: Strings.pleaseWriteYourMessageHere,
                ),
                autofocus: true,
                maxLines: null,
                controller: postController,
              ),
            ),
            ...PostSetting.values.map(
              (postSetting) => ListTile(
                title: Text(postSetting.title),
                subtitle: Text(postSetting.description),
                trailing: Switch(
                  value: postSettings[postSetting] ?? false,
                  onChanged: (isOn) {
                    ref.read(postSettingsProvider.notifier).setSetting(
                          postSetting,
                          isOn,
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
