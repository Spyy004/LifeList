import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  final IconData? iconData;
  final String text;
  final double iconSize;
  const IconTextWidget({super.key, required this.iconData, required this.text, this.iconSize = 30.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: iconSize,
          color: Theme.of(context)
              .secondaryHeaderColor, // Set the size of the icon as needed
        ),
        const SizedBox(height: 8.0), // Add spacing between icon and text
        Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyMedium, // Set the style of the text as needed
        ),
      ],
    );
  }
}
