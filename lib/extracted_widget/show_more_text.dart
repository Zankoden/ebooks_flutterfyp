import 'package:ebooks/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowMoreTextController extends GetxController {
  var isExpanded = false.obs;
}

class ShowMoreText extends StatelessWidget {
  final String text;
  final int maxLength;
  final ShowMoreTextController controller = Get.put(ShowMoreTextController());

  ShowMoreText({
    super.key,
    required this.text,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final text = this.text;
    final maxLength = this.maxLength;

    if (text.length <= maxLength) {
      return Text(text);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            controller.isExpanded.value
                ? text
                : '${text.substring(0, maxLength)}...',
            textAlign: TextAlign.start,
          ),
        ),
        InkWell(
          onTap: () {
            controller.isExpanded.toggle();
          },
          child: Obx(
            () => Text(
              controller.isExpanded.value ? ZText.zShowLess : ZText.zShowMore,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
