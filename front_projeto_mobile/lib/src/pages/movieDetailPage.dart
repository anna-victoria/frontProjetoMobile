import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:front_projeto_mobile/src/services/cart_provider.dart';
class MovieDetailPage extends StatefulWidget {
  final Map<String, dynamic> movie;
  final String nome;

  MovieDetailPage({required this.movie, required this.nome});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  int _selectedTickets = 1;

  @override
  Widget build(BuildContext context) {
    final imageBase64 = widget.movie['imagem'] ?? '';
    final title = widget.movie['titulo'] ?? 'Título não disponível';
    final description = widget.movie['descricao'] ?? 'Descrição não disponível';
    final time = widget.movie['horario'] ?? 'Horário não disponível';
    final room = widget.movie['sala'] ?? 'Sala não disponível';

    ImageProvider imageProvider;
    if (imageBase64.isNotEmpty) {
      final bytes = base64Decode(imageBase64.split(',').last);
      imageProvider = MemoryImage(Uint8List.fromList(bytes));
    } else {
      imageProvider = AssetImage('assets/images/placeholder.png');
    }

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
              width: double.infinity,
              height: 54,
              color: Colors.purple[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Bem vindo(a) ${widget.nome}!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Row(
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
                    onSelected: (String value) {
                      if (value == 'Logout') {
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'Logout',
                          child: Text('Logout'),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 21,
            top: 121,
            right: 21,
            bottom: 61,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        description,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Horários: $time',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          Text('Sala: $room',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              'Escolha a quantidade de ingressos:',
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: DropdownButton<int>(
                              value: _selectedTickets,
                              items: List.generate(
                                10,
                                (index) => DropdownMenuItem<int>(
                                  value: index + 1,
                                  child: Text('${index + 1}'),
                                ),
                              ),
                              onChanged: (int? newValue) {
                                setState(() {
                                  _selectedTickets = newValue!;
                                });
                              },
                              hint: Text(
                                'Selecione',
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              ),
                              isExpanded: true,
                            ),
                          ),
                        ],
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
                          child: Text('Voltar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6BA5DA),
                            foregroundColor: Colors.black,
                            minimumSize: Size(100, 50),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .addToCart(widget.movie, _selectedTickets);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Item adicionado ao carrinho')),
                            );
                          },
                          child: Text('Adicionar ao carrinho'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3BCA63),
                            foregroundColor: Colors.black,
                            minimumSize: Size(100, 50),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
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
              width: double.infinity,
              height: 61,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart, size: 30),
                      Text(
                        'Comprar',
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.list, size: 30),
                      Text(
                        'Meus Pedidos',
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
