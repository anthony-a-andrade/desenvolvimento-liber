import 'package:flutter/material.dart';
import 'package:liber/config/font_helper.dart';
import 'package:liber/model/ad.dart';
import 'package:liber/model/solicitation.dart';
import 'package:liber/model/user.dart';
import 'package:liber/widgets/info/account_details_row.dart';

class AccountDetailsCard extends StatelessWidget {
  final User account;
  final List<Ad> publishedAds;
  final List<Solicitation> trades;
  final List<Solicitation> sells;

  const AccountDetailsCard({
    required this.account, 
    required this.publishedAds,
    required this.trades,
    required this.sells,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(account.url),
                      fit: BoxFit.fitWidth
                    )
                  )
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(account.name, style: Font.bold()))
              ]
            ),
            const Divider(),
            AccountDetailsRow("Conta", account.accountType, boldEnd: true),
            const Divider(),
            AccountDetailsRow(publishedAds.length, "anúncio${plural(publishedAds.length)} publicado${plural(publishedAds.length)}", boldStart: true),
            AccountDetailsRow(trades.length, "livro${plural(trades.length)} trocado${plural(trades.length)}", boldStart: true),
            AccountDetailsRow(sells.length, "livro${plural(sells.length)} vendido${plural(sells.length)}", boldStart: true)
          ]
        )
      )
    );
  }
  
  String plural(int length) => length == 1 ? "" : "s";
}