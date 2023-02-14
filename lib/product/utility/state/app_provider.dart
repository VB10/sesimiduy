// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sesimiduy/features/login/service/firebase_service.dart';
import 'package:sesimiduy/product/utility/maps/maps_manager.dart';

class AppProvider extends StateNotifier<AppProviderState> {
  AppProvider() : super(const AppProviderState());

  final FirebaseService firebaseService = FirebaseService();

  static final provider =
      StateNotifierProvider<AppProvider, AppProviderState>((_) {
    return AppProvider();
  });

  Future<void> checkMapsPermission() async {
    final userPermission = await MapsManager.determinePosition();
    state = state.copyWith(position: userPermission);
  }
}

@immutable
class AppProviderState extends Equatable {
  const AppProviderState({this.position});

  final Position? position;

  @override
  List<Object?> get props => [position];

  AppProviderState copyWith({
    Position? position,
  }) {
    return AppProviderState(
      position: position ?? this.position,
    );
  }
}
