import 'dart:math';

import 'package:liber/model/book.dart';
import 'package:liber/model/genre.dart';

class BookService {
  static int amount = 0;
  static final _random = Random();

  static String randomWord(int min, int max) {
    String alfa = "ABCDEFGHIJKLMNOPQRSTUVWXYZ", palavra = "";
    var tamanho = min;
    if (min != max) tamanho += _random.nextInt(max - min);
    for (var i = 0; i < tamanho; i++) { palavra += alfa[_random.nextInt(26)]; }
    return palavra;
  }

  static List<String> randomWords(int min, int max, int de, int ate) {
    var result = <String>[];
    var tamanho = min;
    if (min != max) tamanho += _random.nextInt(max - min);
    for (int i = 0; i < tamanho; i++) { result.add(randomWord(de, ate)); }
    return result;
  } 

  static Book randomBook() {
    var urls = [
      'https://m.media-amazon.com/images/I/51qnfeR7uCL.jpg',
      'https://marketplace.canva.com/EAE4oJOnMh0/1/0/1003w/canva-capa-de-livro-de-suspense-O7z4yw4a5k8.jpg',
      'https://http2.mlstatic.com/D_NQ_NP_949628-MLB48701262296_122021-O.jpg',
      'https://marketplace.canva.com/EAD0UDNeCTY/1/0/501w/canva-branco-c%C3%A9u-noturno-autobiografia-capa-de-livro-2DbYt-ROvOE.jpg',
      'https://marketplace.canva.com/EAFK6vGA_UA/1/0/1003w/canva-capa-de-livro-com-foto-de-cidade-noturna-com-fuma%C3%A7a-e-pessoas-moderno-preto-nNp97h0CD0Y.jpg',
      'https://marketplace.canva.com/EAD0ULlFoO8/1/0/1003w/canva-preto-e-branco-moderno-fotografia-capa-de-livro-5O393TQEFJ8.jpg'
    ];

    amount++;
    return Book.build(
      id: randomWord(15, 15), 
      title: randomWords(2, 4, 8, 15).join(" "), 
      subtitle: randomWords(2, 4, 8, 15).join(" "), 
      isbn: "xxx.xxx.xxx.xxx.xx".replaceAll("x", BookService.amount.toString()), 
      authors: randomWords(2, 2, 8, 10), 
      synopsis: randomWords(10, 20, 10, 20).join(" "), 
      publisher: randomWords(1, 3, 5, 15).join(" "), 
      year: 1900 + _random.nextInt(122), 
      location: ["BR", "BR", "US", "US", "ES", "ES"][_random.nextInt(6)], 
      language: ["PT", "EN", "ES"][_random.nextInt(3)], 
      pageCount: 150 + _random.nextInt(122), 
      dimensionHeight: "${10 + _random.nextInt(5)}cm", 
      dimensionWidth: "${7 + _random.nextInt(5)}cm", 
      genre: List<Genre>.generate(3 + _random.nextInt(3), (index) => Genre(index.toString(), randomWord(5, 10), randomWord(5, 10))), 
      keyWords: randomWords(2, 8, 8, 15),
      url: urls[_random.nextInt(urls.length)]
    );
  }

  static Future<List<Book>> expand(int qntExpand) {
    List<Book> items = [];
    for (int i = 0; i < qntExpand; i++) { items.add(randomBook()); }
    return Future.value(items);
  }
}