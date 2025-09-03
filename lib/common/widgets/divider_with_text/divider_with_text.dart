import 'package:flutter/material.dart';

class CommonDividerWithText extends StatelessWidget {
  final Text text;

  const CommonDividerWithText({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: text,
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
