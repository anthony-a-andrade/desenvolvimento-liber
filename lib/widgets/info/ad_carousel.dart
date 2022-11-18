import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/model/ad.dart';
import 'package:liber/widgets/info/carousel_indicator.dart';
import 'package:liber/widgets/info/scrollable_text.dart';

class AdCarousel extends StatefulWidget {
  final List<Ad> items;

  const AdCarousel({required this.items, super.key});

  @override
  State<AdCarousel> createState() => _AdCarouselState();
}

class _AdCarouselState extends State<AdCarousel> {
  @override
  Widget build(BuildContext context) {
    var items = widget.items;
    
    return CarouselSlider(
      items: List<Widget>.generate(items.length, (index) {
        var ad = items[index];
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(ad.book.url),
                  fit: BoxFit.cover
                )
              )
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [ Colors.black, Colors.transparent ],
                  begin: Alignment(0, 1), 
                  end: Alignment(0, -0.3)
                )
              )
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScrollableText(
                      text: ad.book.getTitle(), 
                      style: Font.color(Colors.white).size(16).bold()
                    ),
                    Text("R\$${ad.getPrice()}", style: Font.color(Colors.white).size(20))
                  ]
                )
              )
            )
          ]
        );
      }), 
      options: CarouselOptions(
        height: 170, 
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayAnimationDuration: const Duration(seconds: 3),
        enableInfiniteScroll: true,
        disableCenter: true,
        viewportFraction: 0.8,
        pauseAutoPlayOnTouch: true,
        onPageChanged: (index, reason) => CarouselIndicator.switchCurrent(index)
      )
    );
  }
}