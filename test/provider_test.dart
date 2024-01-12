import 'dart:async' show FutureOr;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

typedef ActMethod<T> = FutureOr<void> Function(T provider)?;

@isTest
void riverpodTest<R extends StateNotifier<State>, State>(
  String description, {
  required R Function() build,
  ActMethod<R> act,
  Iterable<State> Function()? expectedStates,
}) {
  test(description, () async {
    try {
      R? provider;

      provider = build.call();

      final states = <State>[];

      provider.addListener(states.add);

      await act?.call(provider);

      if (expectedStates != null) {
        final expected = expectedStates();
        expect(states, expected);
      }
    } on TestFailure catch (e) {
      fail('Exception : ${e.message}');
    }
  });
}
