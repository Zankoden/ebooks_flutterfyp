import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String appBarTitle; 
  final Color appBarTitleColor; 
  const AppBarWidget({
    super.key,
    required this.appBarTitle, required this.appBarTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Flexible(
            child: Text(
              appBarTitle,
              style:  TextStyle(
                  color: appBarTitleColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
      leading: Container(),
      leadingWidth: 1,
    );
  }
}
