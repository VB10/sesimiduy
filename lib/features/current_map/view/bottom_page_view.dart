import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/features/current_map/provider/map_provider.dart';
import 'package:sesimiduy/product/model/want_help_model.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';
import 'package:sesimiduy/product/utility/validator/validator_items.dart';
import 'package:sesimiduy/product/widget/button/active_button.dart';
import 'package:sesimiduy/product/widget/combo_box/labeled_product_combo_box.dart';
import 'package:sesimiduy/product/widget/combo_box/product_combo_box.dart';
import 'package:sesimiduy/product/widget/spacer/dynamic_vertical_spacer.dart';

class BottomPageView extends ConsumerStatefulWidget {
  const BottomPageView({
    required this.wantedItems,
    required this.mapProvider,
    super.key,
  });

  final List<WantHelpModel> wantedItems;
  final MapProvider mapProvider;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomPageViewState();
}

class _BottomPageViewState extends ConsumerState<BottomPageView> {
  final PageController controller = PageController(
    viewportFraction: kIsWeb ? 0.2 : 0.6,
  );

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: (value) {
        widget.mapProvider.changeMapView(widget.wantedItems[value].location);
      },
      itemBuilder: (context, index) {
        return InfoCard(
          model: widget.wantedItems[index],
          onPressed: () {
            widget.mapProvider
                .changeMapView(widget.wantedItems[index].location);
            controller.animateToPage(
              index,
              duration: context.durationLow,
              curve: Curves.easeInOut,
            );
          },
        );
      },
      itemCount: widget.wantedItems.length,
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.model,
    super.key,
    this.onPressed,
  });

  final WantHelpModel model;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const PagePadding.verticalSymmetric(),
      child: InkWell(
        onTap: onPressed,
        child: Card(
          shape: context.roundedRectangleAllBorderNormal,
          child: Padding(
            padding: const PagePadding.allVeryLow(),
            child: ListTile(
              title: Text(model.fullName ?? ''),
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 0,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.categories?.map((e) => e.name).join() ?? ''),
                  Expanded(child: Text(model.address ?? '')),
                ],
              ),
              leading: const Icon(Icons.person_pin_circle_outlined),
            ),
          ),
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
