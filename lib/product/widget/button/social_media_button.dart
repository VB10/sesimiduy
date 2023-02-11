// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SocialMediaButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const SocialMediaButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<SocialMediaButton> createState() => _SocialMediaButtonState();
}

class _SocialMediaButtonState extends State<SocialMediaButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(widget.icon), Text(widget.title)],
      ),
    );
  }
}
