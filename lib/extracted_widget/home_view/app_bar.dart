import 'package:ebooks/constants/text_strings.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Row(
        children: [
          Flexible(
            child: Text(
              ZText.zOurTopRecommendations,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
      leading: Container(),
      leadingWidth: 1,
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       controller.openDrawer();
      //     },
      //     icon: const Icon(Icons.menu),
      //   )
      // ],
    );
  }
}
