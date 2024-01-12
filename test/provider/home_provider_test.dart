import 'package:flutter_test/flutter_test.dart';
import 'package:sesimiduy/features/home/provider/home_provider.dart';

import '../provider_test.dart';

void main() {
  late HomeProvider homeProvider;

  setUp(() {
    homeProvider = HomeProvider();
  });

  riverpodTest<HomeProvider, HomeState>(
    'HomeProvider test',
    build: () => homeProvider,
    act: (HomeProvider provider) => provider.updateName(),
    expectedStates: () => [
      const HomeState(''), // Initial state
      const HomeState('Hello World'), // State after updating name
    ],
  );
}
