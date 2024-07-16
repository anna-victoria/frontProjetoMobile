import 'package:flutter/material.dart';

class MovieFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF2A2B41),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              width: 414,
              height: 54,
              color: Colors.purple[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Bem vindo(a) Pessoinha!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.black),
                        SizedBox(width: 4),
                        Text(
                          'Meu perfil',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 21,
            top: 73,
            child: Container(
              width: 371,
              height: 510, 
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nome do filme',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Adicionar horários',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: ['10:00', '12:00', '15:00', '20:00', '22:00'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Ingressos disponíveis',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Sala',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: ['Sala 1', 'Sala 2'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Adicionar foto',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: Icon(Icons.attach_file),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: Size(100, 50),
                          ),
                          child: Text(
                            'VOLTAR',
                            style: TextStyle(color: Colors.black), 
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            fixedSize: Size(100, 50),
                          ),
                          child: Text(
                            'SALVAR',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: 414,
              height: 61,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.movie, size: 30),
                      Text(
                        'Filmes',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, size: 30),
                      Text(
                        'Página Inicial',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
