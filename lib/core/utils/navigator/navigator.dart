import 'package:flutter/material.dart';

class MovingNavigation {
  static navTo(BuildContext context, {required Widget page}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ));
  }
}
