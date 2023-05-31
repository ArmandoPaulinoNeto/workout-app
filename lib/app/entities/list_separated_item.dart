class ListSeparatedItem {
  late String id;
  late String title;
  String? subTitle;
  String? date;
  String? sex;
  ListSeparatedItem(
      {required this.id,
      required this.title,
      this.subTitle,
      this.date,
      this.sex});

  ListSeparatedItem.fromJson(arg, arg1, arg2, arg3, arg4) {
    id = arg;
    title = arg1;
    subTitle = arg2;
    date = arg3;
    sex = arg4;
  }
}
