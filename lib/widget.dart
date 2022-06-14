import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double scaleSize(double size) {
  // iphone 11 based
  var logicalScreenSize = window.physicalSize / window.devicePixelRatio;
  var screenWidth = logicalScreenSize.width;
  return size * screenWidth / 414;
}

class Header extends StatelessWidget {
  const Header(
      {Key? key,
      this.title = '',
      this.onPressRight,
      this.iconRight,
      this.titleColor,
      this.backgroundColor})
      : super(key: key);
  final String title;
  final VoidCallback? onPressRight;
  final Widget? iconRight;
  final Color? backgroundColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: scaleSize(55),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 32,
                  color: titleColor,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: scaleSize(20), color: titleColor),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: iconRight != null
                ? GestureDetector(
                    onTap: onPressRight,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: iconRight,
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}

class FontU {
  final hangman = GoogleFonts.nanumBrushScript;
}
