import 'package:flutter/foundation.dart' show immutable;
import 'package:themimictrial/views/components/constants/strings.dart';
import 'package:themimictrial/views/components/dialogs/alert_dialog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  LogoutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}
