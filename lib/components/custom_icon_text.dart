import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  final IconData? iconData;
  final String text;

  const IconTextWidget({super.key, required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 30.0,
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
