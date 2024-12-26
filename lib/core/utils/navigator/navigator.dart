import 'package:flutter/material.dart';

class MovingNavigation {
  static navTo(BuildContext context, {required Widget page}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0), 
              end: Offset.zero, 
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut, 
              ),
            ),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 100), 
      ),
    );
  }
}
