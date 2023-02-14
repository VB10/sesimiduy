import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sesimiduy/product/utility/state/app_provider.dart';

mixin AppProviderMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  AppProvider get appProvider => ref.read(AppProvider.provider.notifier);
  AppProviderState get appState => ref.read(AppProvider.provider);
}
