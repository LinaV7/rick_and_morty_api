import 'package:flutter/material.dart';
import 'package:rick_and_morty/ui/theme/colors.dart';

class CustomTextWithIcon extends StatelessWidget {
  final String text;
  final IconData? icon;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const CustomTextWithIcon({
    super.key,
    required this.text,
    this.icon,
    this.style,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.darkGray),
          const SizedBox(width: 10),
          Text(
            text,
            style: style,
          ),
        ],
      ),
    );
  }
}
