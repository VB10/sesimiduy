// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    TryRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const TryPage(),
      );
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          TryRoute.name,
          path: '/',
        )
      ];
}

/// generated route for
/// [TryPage]
class TryRoute extends PageRouteInfo<void> {
  const TryRoute()
      : super(
          TryRoute.name,
          path: '/',
        );

  static const String name = 'TryRoute';
}
