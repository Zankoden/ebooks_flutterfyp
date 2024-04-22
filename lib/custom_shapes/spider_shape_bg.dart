import 'package:flutter/material.dart';

class SpiderShape extends StatelessWidget {
  const SpiderShape({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SpiderClipper(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        color: const Color(0xff5ABD8C),
      ),
    );
  }
}

class SpiderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    
    path.moveTo(size.width / 2, 0);
    
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.2,
        size.width * 0.1, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.6,
        size.width * 0.3, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.7,
        size.width * 0.7, size.height * 0.9);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.6,
        size.width * 0.9, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.65, size.height * 0.2, size.width / 2, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
