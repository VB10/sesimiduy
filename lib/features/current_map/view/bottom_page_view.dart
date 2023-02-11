import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';
import 'package:sesimiduy/product/utility/padding/page_padding.dart';

class BottomPageView extends StatelessWidget {
  BottomPageView({super.key});

  final PageController controller = PageController(
    viewportFraction: kIsWeb ? 0.2 : 0.6,
  );

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      padEnds: false,
      children: const [
        InfoCard(info: 'Page-1'),
        InfoCard(info: 'Page-2'),
        InfoCard(info: 'Page-3'),
        InfoCard(info: 'Page-4'),
        InfoCard(info: 'Page-5'),
        InfoCard(info: 'Page-6'),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.info,
    super.key,
  });
  final String info;

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
            const ListTile(
              title: Text('YARDIM TITLE'),
              subtitle: Text('YARDIM DESCRIPTION'),
              leading: Icon(Icons.person_pin_circle_outlined),
            ),
            FloatingActionButton.extended(
              heroTag: info,
              onPressed: () {},
              backgroundColor: ColorsCustom.endless,
              label: const Text('Bildir'),
            )
          ],
        ),
      ),
    );
  }
}
