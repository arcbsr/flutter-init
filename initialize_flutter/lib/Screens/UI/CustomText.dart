import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TitleB extends StatelessWidget {
  final String text;

  const TitleB({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello, Guest',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class TextN extends StatelessWidget {
  final String text;
  final bool isSingleLine = true;

  const TextN({
    super.key,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello, Guest',
      style: TextStyle(fontSize: 12.sp),
      maxLines: isSingleLine ? 1 : 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class TextNM extends StatelessWidget {
  final String text;
  final bool isSingleLine;

  const TextNM({
    required this.text,
    required this.isSingleLine,
  });
  @override
  Widget build(BuildContext context) {
    return isSingleLine
        ? Text(
            'Hello, Guest',
            style: TextStyle(fontSize: 12.sp),
            maxLines: isSingleLine ? 1 : 1,
            overflow: TextOverflow.ellipsis,
          )
        : Text(
            'Hello, Guest',
            style: TextStyle(fontSize: 12.sp),
          );
  }
}
