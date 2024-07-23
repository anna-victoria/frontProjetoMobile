import 'package:flutter/material.dart';
import 'package:front_projeto_mobile/src/services/movie_service.dart';
import 'package:front_projeto_mobile/src/pages/MovieFormScreen.dart';
import 'dart:convert';
import 'dart:typed_data';

class HomePageFuncionario extends StatefulWidget {
  final String nome;

  HomePageFuncionario({required this.nome});

  @override
  _HomePageFuncionarioState createState() => _HomePageFuncionarioState();
}

class _HomePageFuncionarioState extends State<HomePageFuncionario> {
  final MovieService _movieService =
      MovieService(baseUrl: 'http://localhost:8080');
  late Future<List<dynamic>> _movies;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _loadMovies() {
    setState(() {
      _movies = _movieService.fetchMovies();
    });
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/');
  }

  Future<void> _deleteMovie(dynamic id) async {
    try {
      if (id is int) {
        print('Deletando filme com ID: $id');
        await _movieService.deleteMovie(id);
        _loadMovies();
      } else {
        throw Exception('ID do filme é inválido');
      }
    } catch (e) {
      print('Erro ao deletar filme: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao deletar filme: $e')),
      );
    }
  }

  void _editMovie(Map<String, dynamic> movie) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieFormScreen(movie: {
          'id': movie['id'],
          'titulo': movie['titulo'],
          'sinopse': movie['sinopse'],
          'genero': movie['genero'],
          'duracao': movie['duracao'],
          'imagem': movie['imagem'],
          'quantidadeIngressos': movie['quantidadeIngressos'],
          'quantidadeIngressosDisponivel':
              movie['quantidadeIngressosDisponivel'],
          'horario': movie['horario'],
          'sala': movie['sala'],
        }),
      ),
    );
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2B41),
      appBar: AppBar(
        title: const Text('Página Inicial - Funcionário'),
      ),
      body: Column(
        children: [
          Container(
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
                      _logout();
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieFormScreen(),
                ),
              );
              _loadMovies();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3BCA63),
              foregroundColor: Colors.black,
            ),
            child: const Text('ADICIONAR FILME',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _movies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child:
                          Text('Erro ao carregar filmes: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum filme cadastrado.'));
                }

                final movies = snapshot.data!;
                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    final imageBase64 = movie['imagem'] ?? '';
                    final title = movie['titulo'] ?? 'Título não disponível';
                    final genre = movie['genero'] ?? 'Gênero não disponível';
                    final horario =
                        movie['horario'] ?? 'Horário não disponível';
                    final sala = movie['sala'] ?? 'Não disponível';

                    ImageProvider imageProvider;
                    if (imageBase64.isNotEmpty) {
                      final bytes = base64Decode(imageBase64.split(',').last);
                      imageProvider = MemoryImage(Uint8List.fromList(bytes));
                    } else {
                      imageProvider =
                          AssetImage('assets/images/placeholder.png');
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: MediaQuery.of(context).size.width * 0.05),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                              image: imageProvider,
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Gênero: $genre',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Horário: $horario',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Sala: $sala',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editMovie(movie),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteMovie(movie['id']),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
