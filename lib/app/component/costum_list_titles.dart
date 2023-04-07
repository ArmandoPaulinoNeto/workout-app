import 'package:flutter/material.dart';

class CostomListTitles extends StatelessWidget {
  final String title;
  final IconData? iconTextField;
  final void Function()? actionOntap;

  const CostomListTitles(
      {super.key, required this.title, this.iconTextField, this.actionOntap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Container(
        width: 48,
        height: 48,
        child: iconTextField == null ? null : Icon(iconTextField),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: actionOntap,
      iconColor: Colors.white,
      dense: true,
    );
  }
}
