import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();

}

class _HomepageState extends State<Homepage> {
  final lista = [
    {
      'nomeLivro': 'H.P. Lovecraft - Miskatonic Edition',
      'imgLivro':
      'https://darkside.vteximg.com.br/arquivos/ids/168103-519-519/95-hp-lovecraft-medo-classico-miskatonic-edition-1.jpg?v=636802549118500000',
      'valorLivro': '35,90',
      'distancia': 'Próximo de você',
      'vendedor': 'Ana Banana',
      'tema': 'terror',
      'class': 'suspense'
    },{
      'nomeLivro': 'Um Estudo em Vermelho ',
      'imgLivro':
      'https://imgs.extra.com.br/1519392636/1xg.jpg?imwidth=500',
      'valorLivro': '15,90',
      'distancia': 'Próximo de você',
      'vendedor': 'João Mamão',
      'tema': 'Mistério',
      'class': 'aventura'
    }, {
      'nomeLivro': 'H.P. Lovecraft - Miskatonic Edition',
      'imgLivro':
      'https://darkside.vteximg.com.br/arquivos/ids/168103-519-519/95-hp-lovecraft-medo-classico-miskatonic-edition-1.jpg?v=636802549118500000',
      'valorLivro': '35,90',
      'distancia': 'Próximo de você',
      'vendedor': 'Ana Banana',
      'tema': 'terror',
      'class': 'suspense'
    },
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10, bottom: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Descobertas da Semana!',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width - 25,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.blue,
              ),

              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    height: 200,
                    color: Colors.black,
                  ),
                  Text("MARX, uma introdução"),
                  Text("200,00")
                ],
              ),
            ),

            Container(
              height: 600,
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, i){
                  var infor= lista[i];
                  return Container(
                    height: 155,
                    width: MediaQuery.of(context).size.width - 25,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      boxShadow: [BoxShadow(color: Color(0xFFECEFF1), blurRadius: 8)],
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              height: 90,
                              width: 100,
                              decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                         infor['imgLivro']!))),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width: MediaQuery.of(context).size.width - 150,
                                  child: Text(infor['nomeLivro']!
                                    ,
                                    style: TextStyle(fontSize: 21),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 15, left: 5),
                                      child:  Text(
                                        infor['valorLivro']!,
                                        style: TextStyle(fontSize: 26),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 20,
                                      ),
                                      child: Text(infor['distancia']!,
                                          style: TextStyle(
                                              fontSize: 18, color: Color(0xFF78909C))),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 5, top: 5),
                                      child: const Text(
                                        'Vendido por:',
                                        style: TextStyle(
                                            fontSize: 18, color: Color(0xFF78909C)),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 5, top: 5),
                                      child:  Text(infor['vendedor']!,
                                          style: TextStyle(
                                              fontSize: 18, color: Color(0xFFE265D8))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 15, top: 12),
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 8, right: 8),
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE43D61),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                infor['tema']!.toUpperCase(),
                                style:
                                 TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ),
                             SizedBox(
                              width: 8,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 8, right: 8),
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4A4A4A),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                infor['class']!.toUpperCase(),
                                style:
                                const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        )
                      ],

                    ),

                  );

                },

              ),
            )

          ],
        ),
      ),
    );
  }
}
