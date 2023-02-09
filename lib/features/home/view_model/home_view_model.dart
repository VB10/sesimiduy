// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider() : super(const HomeState(''));

  void updateName() {
    state = state.copyWith(title: 'Hello World');
  }
}

@immutable
class HomeState {
  const HomeState(this.title);

  final String title;

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return other.title == title;
  }

  @override
  int get hashCode => title.hashCode;

  HomeState copyWith({
    String? title,
  }) {
    return HomeState(
      title ?? this.title,
    );
  }
}
