import 'package:flutter/material.dart';

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(
        0, size.height - 10); // Start from bottom-left minus curve depth

    // Curve at the bottom center
    path.quadraticBezierTo(
      size.width / 2, size.height + 10, // Control point (lower = deeper curve)
      size.width, size.height - 10, // End point of curve
    );

    path.lineTo(size.width, 0); // Top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
