import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

import 'package:sesimiduy/product/utility/constants/social_media_links_constants.dart';
import 'package:sesimiduy/product/utility/constants/string_constants.dart';
import 'package:sesimiduy/product/utility/size/index.dart';
import 'package:sesimiduy/product/widget/button/social_media_button.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: WidgetSizes.spacingM,
      children: [
        SocialMediaButton(
          onTap: () => openWeb(SocialMediaLinksConstants.twitterUrl),
          icon: FontAwesomeIcons.twitter,
          title: StringConstants.twitter,
        ),
        SocialMediaButton(
          onTap: () => openWeb(SocialMediaLinksConstants.instagramUrl),
          icon: FontAwesomeIcons.instagram,
          title: StringConstants.instagram,
        ),
        SocialMediaButton(
          onTap: () => openWeb(SocialMediaLinksConstants.afadUrl),
          icon: FontAwesomeIcons.a,
          title: StringConstants.afad,
        ),
      ],
    );
  }

  void openWeb(String value) => value.launchWebsite;
}
