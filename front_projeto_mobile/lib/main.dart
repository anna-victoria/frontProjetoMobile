import 'package:flutter/material.dart';
import 'package:front_projeto_mobile/src/pages/Cart.dart';
import 'package:front_projeto_mobile/src/pages/homePageCliente.dart';
import 'package:front_projeto_mobile/src/pages/home_page_funcionario.dart';
import 'package:front_projeto_mobile/src/pages/login_page.dart';
import 'package:front_projeto_mobile/src/pages/sign_up_page.dart';
import 'package:front_projeto_mobile/src/pages/ticket_historic.dart';

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
      onGenerateRoute: (settings) {
        if (settings.name == '/home_cliente') {
          final args = settings.arguments as Map<String, String>?;
          final nome = args?['nome'] ?? '';

          return MaterialPageRoute(
            builder: (context) => HomePageCliente(nome: nome),
          );
        }

        if (settings.name == '/home_funcionario') {
          final args = settings.arguments as Map<String, String>?;
          final nome = args?['nome'] ?? '';
          return MaterialPageRoute(
            builder: (context) => HomePageFuncionario(nome: nome),
          );
        }

        return MaterialPageRoute(
          builder: (context) => HomePageCliente(nome: '',),
        );
      },
    );
  }
}
