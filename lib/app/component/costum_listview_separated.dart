import 'dart:math';

import 'package:flutter/material.dart';

class CostumListViewSeparated extends StatelessWidget {
  var itemList;
  final List<String>? subTitleItemList;
  final void Function()? onTapEdit;
  final void Function()? onTapDelete;

  CostumListViewSeparated(
      {super.key,
      required this.itemList,
      this.subTitleItemList,
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
                          Icons.edit_note_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          print("edit: " + itemList[index]);
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
            itemList[index],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 100, 0)),
          ),
          subtitle: subTitleItemList != null
              ? Text(
                  subTitleItemList![index] + randomNumbers(10),
                  style: TextStyle(color: Color.fromARGB(255, 47, 79, 79)),
                )
              : null,
        );
      },
      separatorBuilder: (_, __) => Divider(),
      itemCount: itemList.length,
    );
  }

  randomNumbers(int n) {
    Random random = new Random();
    String randomNumber = "";
    for (var i = 0; i < n; i++) {
      randomNumber += random.nextInt(10).toString();
    }
    return randomNumber;
  }
}
