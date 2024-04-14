import 'package:flutter/material.dart';

class SCurveShapeWidget extends StatelessWidget {
  const SCurveShapeWidget({
    super.key,
    required this.media,
  });

  final Size media;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.5,
      origin: Offset(0, media.width * 0.8),
      child: Container(
        width: media.width,
        height: media.width,
        decoration: BoxDecoration(
            color: const Color(0xff5ABD8C),
            borderRadius:
                BorderRadius.circular(media.width * 0.5)),
      ),
    );
  }
}
