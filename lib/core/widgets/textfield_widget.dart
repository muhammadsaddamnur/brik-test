import 'package:flutter/material.dart';
import 'package:store/core/utils/colors_util.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({super.key, this.controller, required this.hint, this.keyboardType, this.onChanged, this.maxLines, this.readOnly = false});

  final TextEditingController? controller;
  final String hint;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final int? maxLines;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLines: maxLines ?? 1,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: ColorsUtil.grey.withValues(alpha: 0.1),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
      ),
    );
  }
}
