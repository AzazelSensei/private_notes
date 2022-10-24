import 'package:flutter/material.dart';
import 'package:private_notes/core/extension/ui_extension.dart';

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: context.normalWidth * 0.1);
  }
}
