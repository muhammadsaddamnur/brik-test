import 'package:flutter/material.dart';
import 'package:store/core/utils/colors_util.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsUtil.yellow,
        elevation: 0,
      ),
      child: Text(text, style: TextStyle(color: ColorsUtil.black)),
    );
  }
}
