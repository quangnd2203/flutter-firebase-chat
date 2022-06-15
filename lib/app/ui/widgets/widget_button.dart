import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({Key? key, required this.labelText, required this.onPressed})
      : super(key: key);
  final String labelText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(20),
          ),
          backgroundColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.blueAccent;
            }
            return Colors.blue;
          }),
          elevation: MaterialStateProperty.all(4),
        ),
        child: Center(
          child: Text(
            labelText,
            style: AppTextStyles.normalBold.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
