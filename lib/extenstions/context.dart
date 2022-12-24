import 'package:flutter/material.dart';

extension MyContext on BuildContext {
  // Gets the current keyboard visibility
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom != 0;
}
