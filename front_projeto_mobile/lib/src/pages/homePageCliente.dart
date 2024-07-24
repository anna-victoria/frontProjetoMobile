import 'package:flutter/material.dart';
import 'package:front_projeto_mobile/src/pages/ticket_historic.dart';
import 'package:front_projeto_mobile/src/services/movie_service.dart';
import 'package:front_projeto_mobile/src/pages/movieDetailPage.dart';
import 'package:front_projeto_mobile/src/pages/Cart.dart';
import 'dart:convert';
import 'dart:typed_data';

class HomePageCliente extends StatefulWidget {
  final String nome;

  HomePageCliente({required this.nome});

  @override
  _HomePageClienteState createState() => _HomePageClienteState();
}

class _HomePageClienteState extends State<HomePageCliente> {
  late Future<List<dynamic>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture =
        MovieService(baseUrl: 'http://localhost:8080').fetchMovies();
  }

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
                      'Bem vindo(a) ${widget.nome}!',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Row(
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
                        const PopupMenuItem<String>(
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
          const Positioned(
            left: 61,
            top: 66,
            child: Text(
              'Cinema Garanhuns',
              style: TextStyle(
                fontFamily: 'Roboto Slab',
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 37,
            right: 37,
            top: 114,
            bottom: 61,
            child: FutureBuilder<List<dynamic>>(
              future: _moviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child:
                          Text('Erro ao carregar filmes: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum filme encontrado'));
                } else {
                  final movies = snapshot.data!;
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      final imageBase64 = movie['imagem'] ?? '';
                      final title = movie['titulo'] ?? 'Título não disponível';
                      final description =
                          movie['descricao'] ?? 'Sinopse não disponível';
                      final time = movie['horario'] ?? 'Horário não disponível';
                      final room = movie['sala'] ?? 'Sala não disponível';

                      ImageProvider imageProvider;
                      if (imageBase64.isNotEmpty) {
                        try {
                          final bytes =
                              base64Decode(imageBase64.split(',').last);
                          imageProvider =
                              MemoryImage(Uint8List.fromList(bytes));
                        } catch (e) {
                          imageProvider =
                              AssetImage('assets/images/placeholder.png');
                          print('Erro ao decodificar imagem: $e');
                        }
                      } else {
                        imageProvider =
                            AssetImage('assets/images/placeholder.png');
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailPage(
                                  movie: movie, nome: widget.nome),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Horários: $time',
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Sala: $room',
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Descrição: $description',
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart, size: 30),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(
                                cartItems: [],
                              ),
                            ),
                          );
                        },
                      ),
                      const Text(
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
                      IconButton(
                        icon: Icon(Icons.home, size: 30),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePageCliente(nome: widget.nome),
                            ),
                          );
                        },
                      ),
                      const Text(
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
                      IconButton(
                        icon: Icon(Icons.list, size: 30),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HistoricPage(historicItems: [],),
                            ),
                          );
                        },
                      ),
                      const Text(
                        'Compras',
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
