// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/login/service/firebase_service.dart';
import 'package:sesimiduy/product/utility/constants/app_constants.dart';
import 'package:sesimiduy/product/utility/maps/maps_manager.dart';

class AppProvider extends StateNotifier<AppProviderState> {
  AppProvider() : super(const AppProviderState());

  final FirebaseService firebaseService = FirebaseService();

  static final provider =
      StateNotifierProvider<AppProvider, AppProviderState>((_) {
    return AppProvider();
  });

  Future<void> init() async {
    await Future.wait([checkMapsPermission(), checkDeviceId()]);
  }

  Future<void> checkMapsPermission() async {
    final userPermission = await MapsManager.determinePosition();
    state = state.copyWith(position: userPermission);
  }

  Future<void> checkDeviceId() async {
    try {
      final deviceID = await DeviceUtility.instance.getUniqueDeviceId();
      state = state.copyWith(deviceID: deviceID);
    } catch (e) {
      state = state.copyWith(deviceID: kWeb);
    }
  }
}

@immutable
class AppProviderState extends Equatable {
  const AppProviderState({
    this.position,
    this.deviceID,
  });

  final Position? position;
  final String? deviceID;

  @override
  List<Object?> get props => [position, deviceID];

  AppProviderState copyWith({
    Position? position,
    String? deviceID,
  }) {
    return AppProviderState(
      position: position ?? this.position,
      deviceID: deviceID ?? this.deviceID,
    );
  }
}
