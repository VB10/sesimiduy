import 'package:flutter/material.dart';
import 'package:sesimiduy/product/items/colors_custom.dart';

class BottomPageView extends StatelessWidget {
  BottomPageView({super.key});

  final PageController controller = PageController(
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: const [
        InfoCard(info: 'Page-1'),
        InfoCard(info: 'Page-2'),
        InfoCard(info: 'Page-3'),
        InfoCard(info: 'Page-4'),
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
      color: ColorsCustom.sambacus,
      child: InkWell(
        onTap: () {
          //do something
        },
        child: Center(
          child: Text(
            info,
            style: const TextStyle(color: ColorsCustom.white),
          ),
        ),
      ),
    );
  }
}
