import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/current_map/provider/map_provider.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/validator/validator_items.dart';
import 'package:sesimiduy/product/widget/button/active_button.dart';
import 'package:sesimiduy/product/widget/combo_box/labeled_product_combo_box.dart';
import 'package:sesimiduy/product/widget/combo_box/product_combo_box.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_vertical_spacer.dart';

class BottomPageView extends ConsumerStatefulWidget {
  const BottomPageView({required this.provider, super.key});

  final StateNotifierProvider<MapProvider, MapState> provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomPageViewState();
}

class _BottomPageViewState extends ConsumerState<BottomPageView> {
  final PageController controller = PageController(
    viewportFraction: kIsWeb ? 0.2 : 0.6,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      padEnds: false,
      itemBuilder: (context, index) {
        final items = ref.watch(widget.provider).requestMarkers;
        return const InfoCard(
          address: '',
          title: '',
        );
      },
      itemCount: 1,
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.address,
  });
  final String title;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: context.roundedRectangleAllBorderNormal,
      child: Padding(
        padding: const PagePadding.allVeryLow(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ListTile(
              title: Text(title),
              subtitle: Text(address),
              leading: const Icon(Icons.person_pin_circle_outlined),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const _AcceptDialog();
                  },
                );
              },
              backgroundColor: ColorsCustom.endless,
              label: const Text('Bildir'),
            )
          ],
        ),
      ),
    );
  }
}

class _AcceptDialog extends StatelessWidget {
  const _AcceptDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const PagePadding.all(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Test label'),
            const VerticalSpace.standard(),
            Material(
              child: LabeledProductComboBox<ProductDropDownModel>(
                labelText: 'labelText',
                items: const [],
                onChanged: (_) {},
                hintText: 'hintText',
                validator: (value) =>
                    ValidateGenericItems<ProductDropDownModel>(
                  value,
                ).validateDropDown,
              ),
            ),
            const VerticalSpace.standard(),
            ActiveButton(label: 'label', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
