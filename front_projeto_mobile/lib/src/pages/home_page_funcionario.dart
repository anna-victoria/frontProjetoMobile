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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CadastroFilmeFuncionario()));
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
          //box for list a movie color: ECECEC, rouded border of 5, inside the box,
          //space for the poster, in the right of the poster: title, schedule
          //Button for delete, movie, edit movie and more info and the very right one above other
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: MediaQuery.of(context).size.width * 0.10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 150,
                      color: Color.fromARGB(255, 196, 131, 131),
                    ),
                    const Column(
                      children: [
                        //TODO: Align text to the left
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Nome do Filme:',
                              style: TextStyle(color: Colors.black)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Exemplo de nome de filme',
                              style: TextStyle(color: Colors.black)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Horários:',
                              style: TextStyle(color: Colors.black)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('10:00 - 12:00 - 15:30',
                              style: TextStyle(color: Colors.black)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('18:00 - 22:00',
                              style: TextStyle(color: Colors.black)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Sala 02',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.black,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.black,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          color: Colors.black,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ])));
  }}