import 'package:flutter/material.dart';
import 'package:liber/config/style_helper.dart';
import 'package:liber/model/ad.dart';
import 'package:liber/model/enums/screen_index.dart';
import 'package:liber/model/solicitation.dart';
import 'package:liber/model/user.dart';
import 'package:liber/services/ad_service.dart';
import 'package:liber/services/file_service.dart';
import 'package:liber/services/user_service.dart';
import 'package:liber/views/login.dart';
import 'package:liber/views/subviews/books.dart';
import 'package:liber/views/subviews/edit_account.dart';
import 'package:liber/views/subviews/edit_account_details.dart';
import 'package:liber/views/subviews/library.dart';
import 'package:liber/widgets/control/redirect_panel.dart';
import 'package:liber/widgets/info/account_details_card.dart';
import 'package:liber/widgets/input/rounded_icon_text_button.dart';
import 'package:liber/widgets/input/squared_text_button.dart';

class Home extends StatefulWidget {
  final User account;
  final List<Ad> publishedAds;
  final List<Solicitation> trades;
  final List<Solicitation> sells;
  static late void Function(ScreenIndex index) switchScreen;
  const Home(this.account, this.publishedAds, this.trades, this.sells, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late ScreenIndex index;
  late Widget screen;
  bool menuVisible = false;
  late AnimationController controller;
  late Animation<Offset> offset;

  switchScreen(ScreenIndex index) {
    if (index == this.index) return;
    
    setState(() {
      this.index = index;

      switch (index) {
        case ScreenIndex.books: screen = const Books(); break;
        case ScreenIndex.editAccount: screen = EditAccount(widget.account); break;
        case ScreenIndex.editAddressDetails: screen = EditAccountDetails(addresses: widget.account.address); break;
        case ScreenIndex.editPaymentDetails: screen = EditAccountDetails(cards: widget.account.cards); break;
        case ScreenIndex.library: screen = Library(widget.account, adsMade: AdService.randomAds(5), purchasesMade: AdService.randomAds(3)); break;
        case ScreenIndex.createAd: screen = const Text("not implemented"); break;
        case ScreenIndex.cart: screen = const Text("not implemented"); break;
        default:
          screen = Text(index.toString());
          break;
      }
    });
    if (menuVisible) menuVisibility();
  }

  menuVisibility() {
    switch (controller.status) {
      case AnimationStatus.completed:
        menuVisible = false;
        controller.reverse();
        break;
      case AnimationStatus.dismissed:
        menuVisible = true;
        controller.forward();
        break;
      default:
    }
  }
  
  logout() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
    await LoginFileService.delete();
  }

  @override
  void initState() {
    super.initState();
    index = ScreenIndex.books;
    screen = const Books();
    Home.switchScreen = switchScreen;
    Books.menuVisibility = menuVisibility;
    EditAccount.menuVisibility = menuVisibility;
    Library.menuVisibility = menuVisibility;

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    offset = Tween<Offset>(end: Offset.zero, begin: const Offset(-1.0, 0)).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    var account = widget.account;
    var ads = widget.publishedAds;
    var sells = widget.sells;
    var trades = widget.trades;

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails drag) {
        if(drag.primaryVelocity == null) { return; } 
        else if(drag.primaryVelocity! < 0 && menuVisible) { menuVisibility(); } 
        else if(drag.primaryVelocity! > 0 && !menuVisible) { menuVisibility(); }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [ Style.gradientColorFrom, Style.gradientColorTo ])
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Expanded(child: screen),
                  const SizedBox(height: 5),
                  RedirectPanel(current: index)
                ])
              )
            )
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SlideTransition(
              position: offset,
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(right: BorderSide(width: 1, color: Colors.black))
                    ),
                    width: Style.width(context) * 0.75,
                    height: Style.height(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        AccountDetailsCard(
                          account: account,
                          publishedAds: ads,
                          sells: sells,
                          trades: trades,
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              RoundedIconTextButton("Editar conta", Icons.edit, () => switchScreen(ScreenIndex.editAccount), 15),
                              RoundedIconTextButton("Cadastrar anúncio", Icons.add, () => switchScreen(ScreenIndex.createAd), 15),
                              RoundedIconTextButton("Carrinho", Icons.shopping_cart, () => switchScreen(ScreenIndex.cart), 15),
                              RoundedIconTextButton("Biblioteca", Icons.layers, () => switchScreen(ScreenIndex.library), 15),
                            ]
                          ),
                        ),
                        Expanded(child: Container()),
                        SquaredTextButton("SAIR", logout, icon: Icons.logout),
                        const SizedBox(height: 15)
                      ]
                    )   
                  ),
                  GestureDetector(
                    onTap: menuVisibility,
                    child: Container(
                      color: Colors.transparent,
                      width: Style.width(context) * 0.25,
                      height: Style.height(context)
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}