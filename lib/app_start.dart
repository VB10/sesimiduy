part of '../../main.dart';

class _AppStart {
  final String _localizationAssetPath = 'assets/translations';
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  }
}
