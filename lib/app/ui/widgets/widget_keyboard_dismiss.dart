import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class WidgetKeyboardDismiss extends StatelessWidget {

  const WidgetKeyboardDismiss({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(child: child);
  }
}
