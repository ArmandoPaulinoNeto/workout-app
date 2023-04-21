import 'package:flutter/material.dart';

class CostomTextFormField extends StatelessWidget {
  final String label;
  final IconData? iconTextField;
  final bool obscureText;
  final bool readOnly;
  final TextEditingController? inputController;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function()? onTap;

  const CostomTextFormField(
      {super.key,
      required this.label,
      this.iconTextField,
      required this.obscureText,
      this.validator,
      this.onSaved,
      this.onTap,
      required this.readOnly,
      this.inputController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: inputController != null ? inputController : null,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 0, 100, 0),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          prefixIcon: iconTextField != null ? Icon(iconTextField) : null),
      validator: validator,
      onSaved: onSaved,
      onTap: onTap,
      readOnly: readOnly,
    );
  }
}
