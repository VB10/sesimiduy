import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'auth_provider.freezed.dart';
part 'auth_state.dart';

/// Create for an example
 class AuthProvider extends StateNotifier<AuthState> with NotifierMixin<AuthState> {
  AuthProvider() : super(const AuthState.initial());

  Future<void> updateAuthStatus() async {
    emit(const AuthState.authenticated());
  }
}

 mixin NotifierMixin<T> on StateNotifier<T> {
  void emit(T value) => state = value;
}
