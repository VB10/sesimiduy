import 'package:flutter_test/flutter_test.dart';
import 'package:sesimiduy/features/example/auth_provider.dart';

import '../riverpod_test.dart';

void main() {
  late AuthProvider authProvider;

  setUp(() {
    authProvider = AuthProvider();
  });

  riverpodTest<AuthProvider, AuthState>(
    'AuthProvider test',
    build: () => authProvider,
    act: (AuthProvider provider) async => provider.updateAuthStatus(),
    expectedStates: () => [
      const AuthState.initial(),
      const AuthState.authenticated(),
    ],
  );
}
