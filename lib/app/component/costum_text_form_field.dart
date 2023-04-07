import 'package:flutter/material.dart';

class CostomTextFormField extends StatelessWidget {
  final String label;
  final IconData? iconTextField;
  final bool obscureText;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;

  const CostomTextFormField(
      {super.key,
      required this.label,
      this.iconTextField,
      required this.obscureText,
      this.validator,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          prefixIcon: iconTextField == null ? null : Icon(iconTextField)),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
