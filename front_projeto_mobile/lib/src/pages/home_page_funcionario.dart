import 'package:flutter/material.dart';
import 'package:front_projeto_mobile/src/pages/cadastro_filme_funcionario.dart';

class HomePageFuncionario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2A2B41),
        appBar: AppBar(
          title: const Text('Página Inicial - Funcionário'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          //Button for add new movie
          const SizedBox(height: 70),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroFilmeFuncionario()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3BCA63),
              foregroundColor: Colors.black,
            ),
            child: const Text('ADICIONAR FILME',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold)), //TODO: Border radius
          ),
        ])));
  }
}