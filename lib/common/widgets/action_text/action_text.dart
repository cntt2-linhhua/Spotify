import 'package:flutter/material.dart';

class ActionText extends StatelessWidget {
  final String? desText;
  final Function action;
  final String actionText;
  final TextStyle? actionStyle;

  const ActionText({
    required this.action,
    required this.actionText,
    this.actionStyle,
    this.desText,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (desText != null)
            Text(
              desText!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          TextButton(
            onPressed: () {
              action();
            },
            child: Text(
              actionText,
              style: actionStyle ?? TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff288CE9),
              ),
            ),
          )
        ],
      );
  }
}
