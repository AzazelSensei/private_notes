// ignore_for_file: prefer_initializing_formals

import 'package:private_notes/common_libs.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController xController,
    required this.hintText,
    required this.icon,
    required this.inputFormatters,
  }) : xController = xController;

  final TextEditingController xController;
  final String hintText;
  final Icon icon;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      keyboardType: TextInputType.text,
      controller: xController,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
      ),
    );
  }
}
