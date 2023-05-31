import 'dart:math';

import 'package:flutter/material.dart';

import '../entities/list_separated_item.dart';

class CostumListViewSeparated extends StatelessWidget {
  List<ListSeparatedItem> listItem;
  final IconData? iconTextField;
  final void Function()? onTapAdd;
  final void Function()? onTapEdit;
  final void Function()? onTapDelete;

  CostumListViewSeparated(
      {super.key,
      required this.listItem,
      this.iconTextField,
      this.onTapAdd,
      this.onTapEdit,
      this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          trailing: Wrap(
            spacing: 8,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                    width: 36,
                    height: 36,
                    color: Color.fromARGB(255, 0, 100, 0),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          iconTextField,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          onTapAdd != null ? onTapAdd : onTapEdit;
                        },
                      ),
                    )),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Container(
                  width: 36,
                  height: 36,
                  color: Color.fromARGB(255, 0, 100, 0),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onTapEdit;
                    },
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            listItem[index].title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 100, 0)),
          ),
          subtitle: listItem[index].subTitle != null
              ? Text(
                  listItem[index].subTitle ?? "",
                  style: TextStyle(color: Color.fromARGB(255, 47, 79, 79)),
                )
              : null,
        );
      },
      separatorBuilder: (_, __) => Divider(),
      itemCount: listItem.length,
    );
  }
}
