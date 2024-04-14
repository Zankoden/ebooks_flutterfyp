import 'package:flutter/material.dart';

class CustomShape extends StatelessWidget {
  const CustomShape({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        color: const Color(0xff5ABD8C),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from top center
    path.moveTo(size.width / 2, 0);
    // Draw curves for custom shape
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.4,
      size.width * 0.1,
      size.height * 0.6,
    ); // Adjusted y-coordinate
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.8,
      size.width * 0.2,
      size.height,
    ); // Adjusted y-coordinate

    path.quadraticBezierTo(
      size.width * 0.2,
      size.height - size.height * 0.4,
      size.width * 0.1,
      size.height - size.height * 0.6,
    ); // Adjusted y-coordinate
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height - size.height * 0.8,
      size.width * 0.2,
      size.height,
    );

    // Start from top center
    path.moveTo(size.width / 2, 0);

// Draw curves for custom shape
    path.quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.4, // Adjusted x-coordinate
        size.width * 0.9,
        size.height * 0.6); // Adjusted x-coordinate

    path.quadraticBezierTo(
        size.width * 0.7,
        size.height * 0.8, // Adjusted x-coordinate
        size.width * 0.8,
        size.height); // Adjusted x-coordinate

    path.quadraticBezierTo(
        size.width * 0.8,
        size.height - size.height * 0.4, // Adjusted x-coordinate
        size.width * 0.9,
        size.height - size.height * 0.6); // Adjusted x-coordinate

    path.quadraticBezierTo(
        size.width * 0.7,
        size.height - size.height * 0.8, // Adjusted x-coordinate
        size.width * 0.8,
        size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
