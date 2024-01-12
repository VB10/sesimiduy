import 'package:flutter_test/flutter_test.dart';
import 'package:sesimiduy/features/example/auth_provider.dart';

import '../provider_test.dart';

void main() {
  late AuthProvider authProvider;

  setUp(() {
    authProvider = AuthProvider();
  });

  riverpodTest<AuthProvider, AuthState>(
    'AuthProvider test',
    build: () => authProvider,
    act: (AuthProvider provider) async => provider.checkAndUpdateAuthStatus(),
    expectedStates: () => [
      const AuthState.initial(),
      const AuthState.authenticated(),
    ],
  );
}
