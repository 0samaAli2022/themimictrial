import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themimictrial/state/auth/models/auth_result.dart';
import 'package:themimictrial/state/auth/providers/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>(
    (ref) => ref.watch(authStateProvider).result == AuthResult.success);
