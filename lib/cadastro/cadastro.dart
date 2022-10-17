import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liber_app/reset/reset.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFf45d27),
                      Color(0xFFf5851f),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 32,
                        ),
                        child: Text(
                          "Cadatro",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 32),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only( top: 4, left: 16, right: 16) ,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 20
                            )
                          ]
                      ),
                      child:  TextField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle,
                              color: Colors.grey,),
                            hintText: 'Nome'

                        ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only( top: 4, left: 16, right: 16) ,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 20
                            )
                          ]
                      ),
                      child:  TextField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.email,
                              color: Colors.grey,),
                            hintText: 'E-mail'

                        ),),
                    ),


                    Container(
                      margin: EdgeInsets.only(top: 32),
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only( top: 4, left: 16, right: 16) ,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 20
                            )
                          ]
                      ),
                      child:  TextField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.security,
                              color: Colors.grey,),
                            hintText: 'Senha'

                        ),),
                    ),


                    Container(
                      margin: EdgeInsets.only(top: 32),
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      padding: EdgeInsets.only( top: 4, left: 16, right: 16) ,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 20
                            )
                          ]
                      ),
                      child:  TextField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.security,
                              color: Colors.grey,),
                            hintText: 'Confimação da senha'

                        ),),
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0xFFf45d27),
                            Color(0xFFf5851f)
                          ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))


                      ),
                      child: Center(child: Text("Cadastra".toUpperCase(), style: TextStyle(color: Colors.white, fontWeight:  FontWeight.bold),),),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      child: TextButton(
                        child: Text('Voltar', style: TextStyle(color: Colors.black),),
                        onPressed: (){ Navigator.pop(context);},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
