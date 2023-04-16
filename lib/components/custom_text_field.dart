import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.nameController,
    required this.labelText,
    required this.textInputType,
    required this.hintText,
  });

  final TextEditingController nameController;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusColor: Theme.of(context).secondaryHeaderColor,
          fillColor: Theme.of(context).secondaryHeaderColor,
          hoverColor: Theme.of(context).secondaryHeaderColor,
          labelStyle: Theme.of(context).textTheme.bodyLarge),
      keyboardType: textInputType,
    );
  }
}
