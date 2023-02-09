// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider() : super(const HomeState(''));

  void updateName() {
    state = state.copyWith(title: 'Hello World');
  }
}

@immutable
class HomeState extends Equatable {
  const HomeState(this.title);

  final String title;

  @override
  // TODO: implement props
  List<Object?> get props => [title];

  HomeState copyWith({
    String? title,
  }) {
    return HomeState(
      title ?? this.title,
    );
  }
}
