class Genre {
  String id;
  String name;
  String tag;

  Genre(this.id, this.name, this.tag);
  Genre.build({required this.id, required this.name, required this.tag});

  static Genre fromJson(dynamic json) {
    return Genre.build(
      id: json["_id"], 
      name: json["name"], 
      tag: json["tag"]
    );
  }

  static List<Genre> fromJsonList(dynamic json) {
    return (json as List).map((genre) => Genre.fromJson(genre)).toList();
  }
}