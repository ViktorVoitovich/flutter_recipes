import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon;
  final Function validator;
  final Function onChanged;

  const InputField({
    @required this.controller,
    @required this.hintText,
    @required this.prefixIcon,
    @required this.validator,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
