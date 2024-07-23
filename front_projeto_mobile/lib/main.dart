import 'package:flutter/material.dart';
import 'package:front_projeto_mobile/src/pages/homePageCliente.dart';
import 'package:front_projeto_mobile/src/pages/home_page_funcionario.dart';
import 'package:front_projeto_mobile/src/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home_cliente': (context) => HomePageCliente(),
        '/home_funcionario': (context) => HomePageFuncionario(),
      },
    );
  }
}
