class ListSeparatedItem {
  late String id;
  late String title;
  String? subTitle;

  ListSeparatedItem({required this.id, required this.title, this.subTitle});

  ListSeparatedItem.fromJson(arg, arg1, arg2) {
    id = arg;
    title = arg1;
    subTitle = arg2;
  }
}
