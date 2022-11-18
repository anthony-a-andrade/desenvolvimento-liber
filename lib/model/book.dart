import 'package:liber/model/genre.dart';

class Book {
  String id;
  String title;
  String subtitle;
  String isbn;
  String url;
  List<String> authors;
  String synopsis;
  String publisher;
  int year;
  String location;
  String language;
  int pageCount;
  String dimensionHeight;
  String dimensionWidth;
  List<Genre> genre;
  List<String> keyWords;

  Book(this.id, this.title, this.subtitle, this.isbn, this.authors, this.synopsis, this.publisher, this.year, this.location, this.language, this.pageCount, this.dimensionHeight, this.dimensionWidth, this.genre, this.keyWords, [this.url = "https://png.pngtree.com/png-vector/20220622/ourlarge/pngtree-dismiss-or-invalid-settings-png-image_5257179.png"]);
  Book.build({required this.id, required this.title, required this.subtitle, required this.isbn, required this.authors, required this.synopsis, required this.publisher, required this.year, required this.location, required this.language, required this.pageCount, required this.dimensionHeight, required this.dimensionWidth, required this.genre, required this.keyWords, this.url = "https://png.pngtree.com/png-vector/20220622/ourlarge/pngtree-dismiss-or-invalid-settings-png-image_5257179.png"});
  
  static Book fromJson(dynamic json) {
    return Book.build(
      id: json["_id"], 
      title: json["title"], 
      url: "https://png.pngtree.com/png-vector/20220622/ourlarge/pngtree-dismiss-or-invalid-settings-png-image_5257179.png",
      subtitle: json["subtitle"], 
      isbn: json["isbn"], 
      authors: json["authors"], 
      synopsis: json["synopsis"], 
      publisher: json["publisher"], 
      year: json["year"], 
      location: json["location"], 
      language: json["language"], 
      pageCount: json["page_count"], 
      dimensionHeight: json["dimensions"]["height"], 
      dimensionWidth: json["dimensions"]["width"], 
      genre: Genre.fromJsonList(json["genre"]), 
      keyWords: json["key_words"]
    );
  }

  String getTitle() {
    return title.split(" ").map((e) => e.replaceFirst(e[0], e[0].toUpperCase())).join(" ");
  }
}