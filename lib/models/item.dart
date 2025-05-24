class Item {
  String title;
  bool done;

  Item({required this.title, required this.done});

  Item.fromjason(Map<String, dynamic> json)
      : title = json['title'],
        done = json['done'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['done'] = done;
    return data;
  }
}