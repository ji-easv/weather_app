import 'package:flutter/material.dart';

class SharedUtilityComponents {
  Divider divider() {
    return const Divider(
      color: Colors.black,
      thickness: 2,
      height: 10,
    );
  }

  Text darkText(String text, BuildContext context) {
    return Text(
      text,
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
    );
  }

  Widget textWithIcon(
      String text, String iconUrl, BuildContext context, double iconSize) {
    return Row(
      children: [
        SizedBox(
          height: iconSize,
          width: iconSize,
          child: Image.network(iconUrl),
        ),
        darkText(text, context),
      ],
    );
  }

  Widget spacer() {
    return const SizedBox(
      height: 16,
    );
  }

  String extractTimeOutOfISODateString(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.hour}:${date.minute}';
  }
}
