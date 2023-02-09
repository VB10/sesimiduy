import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/home/provider/home_provider.dart';
import 'package:sesimiduy/product/init/language/locale_keys.g.dart';
import 'package:sesimiduy/product/utility/dialog/register_error_dialog.dart';
import 'package:sesimiduy/product/utility/dialog/register_success_dialog.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final StateNotifierProvider<HomeProvider, HomeState> homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = StateNotifierProvider((ref) => HomeProvider());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(homeProvider.notifier).updateName();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(ref.watch(homeProvider).title),
      ),
      body: Image.network(''.randomImage),
    );
  }

  Future<void> displayErrorDialog(BuildContext context) async {
    final dialog = RegisterErrorDialog(context: context);
    await dialog.showAlertDialog<void>(
      content: LocaleKeys.dialog_errorContent.tr(),
    );
  }

  Future<void> displaySuccessDialog(BuildContext context) async {
    final dialog = RegisterSuccessDialog(context: context);
    await dialog.showAlertDialog<void>(
      content: LocaleKeys.dialog_successContent.tr(),
    );
  }
}
