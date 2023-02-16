import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sesimiduy/features/current_map/provider/map_provider.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/model/want_help_model.dart';

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
    viewportFraction: kIsWeb ? 0.6 : 0.6,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.wantedItems.length,
      itemBuilder: (BuildContext context, int index) {
        return InfoCard(
          model: widget.wantedItems[index],
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              widget.mapProvider
                  .changeMapView(widget.wantedItems[index].location);
            });

            // controller.animateToPage(
            //   index,
            //   duration: context.durationLow,
            //   curve: Curves.easeInOut,
            // );
          },
        );
      },
    );
    return PageView.builder(
      controller: controller,
      padEnds: false,
      pageSnapping: false,
      allowImplicitScrolling: true,
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
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Card(
          shape: context.roundedRectangleAllBorderNormal,
          child: Row(
            children: [
              const Icon(Icons.person_pin_circle_outlined),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(model.fullName ?? ''),
                  SizedBox(
                    width: getValueForScreenType<double>(
                      context: context,
                      mobile: context.dynamicWidth(.4),
                      tablet: context.dynamicWidth(.2),
                      desktop: context.dynamicWidth(.2),
                    ),
                    child: const Divider(
                      color: ColorsCustom.sambacus,
                    ),
                  ),
                  Text(model.categories?.map((e) => e.name).join() ?? ''),
                  Text(model.address ?? ''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
