import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_alternar_telas/cadastro/cadastro.dart';
import 'package:demo_alternar_telas/home/home.dart';
import 'package:demo_alternar_telas/reset/reset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
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
                        "Bem Vindo",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),




            Container(
              padding: const EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 20)
                        ]),
                    child:  TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          hintText: 'Email'),
                      validator: (email){
                        if(email == null || email.isEmpty){
                          return 'Digite seu E-mail';
                        }
                        return null;
                      },

                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 32),
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 20)
                        ]),
                    child:  TextFormField(
                      controller: _senhaController,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.security,
                            color: Colors.grey,
                          ),
                          hintText: 'Senha'),
                      validator: (senha){
                        if(senha == null || senha.isEmpty){
                          return 'Digite sua senha';
                        }
                        return null;
                      },
                    ),
                  ),




                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    child: TextButton(
                      child: const Text(
                        'Esquecu seu e-mail ou senha ?',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Reset()));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),


                  ElevatedButton(onPressed: (){
                    if (_formKey.currentState!.validate())

                    {
                      logar();
                    }  
                    
                    
                  }, child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFf45d27), Color(0xFFf5851f)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: Text(
                        "Entrar".toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    child: TextButton(
                      child: const Text(
                        'Cadastra-se',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Cadastro()));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  logar() async{
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://apionfire.herokuapp.com/sessions');
    var response = await http.post(
        url,
        body:{
          'username': _emailController.text,
          'password': _senhaController.text,
        },
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      print('Legal você logou');
      String token = json.decode(response.body)['token'];
      await _sharedPreferences.setString('token',' Token $token');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DemoHome(),
          ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('e-mail ou senha inválidos'),
          behavior: SnackBarBehavior.floating,
        )
      );
    }
  }
}
