import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themimictrial/state/auth/backend/authenticator.dart';
import 'package:themimictrial/state/auth/models/auth_result.dart';
import 'package:themimictrial/state/auth/models/auth_state.dart';
import 'package:themimictrial/state/posts/typedefs/user_id.dart';
import 'package:themimictrial/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();
  AuthStateNotifier() : super(const AuthState.unkonwn()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unkonwn();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = kIsWeb
        ? await _authenticator.loginWithGoogleWeb()
        : await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  // Future<void> loginWithFacebook() async {
  //   state = state.copiedWithIsLoading(true);
  //   final result = await _authenticator.loginWithFacebook();
  //   final userId = _authenticator.userId;
  //   if (result == AuthResult.success && userId != null) {
  //     await saveUserInfo(
  //       userId: userId,
  //     );
  //   }
  //   state = AuthState(
  //     result: result,
  //     isLoading: false,
  //     userId: userId,
  //   );
  // }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}
