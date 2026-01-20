class Category {
  final int index;
  final String label;

  const Category({required this.index, required this.label});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["index"] = index;
    map["label"] = label;

    return map;
  }
}
