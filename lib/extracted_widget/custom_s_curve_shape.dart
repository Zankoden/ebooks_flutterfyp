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

    path.moveTo(size.width / 2, 0);

    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.4,
      size.width * 0.1,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.8,
      size.width * 0.2,
      size.height,
    );

    path.quadraticBezierTo(
      size.width * 0.2,
      size.height - size.height * 0.4,
      size.width * 0.1,
      size.height - size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height - size.height * 0.8,
      size.width * 0.2,
      size.height,
    );

    path.moveTo(size.width / 2, 0);

    path.quadraticBezierTo(size.width * 0.8, size.height * 0.4,
        size.width * 0.9, size.height * 0.6);

    path.quadraticBezierTo(
        size.width * 0.7, size.height * 0.8, size.width * 0.8, size.height);

    path.quadraticBezierTo(size.width * 0.8, size.height - size.height * 0.4,
        size.width * 0.9, size.height - size.height * 0.6);

    path.quadraticBezierTo(size.width * 0.7, size.height - size.height * 0.8,
        size.width * 0.8, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
