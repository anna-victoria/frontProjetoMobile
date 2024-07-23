import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieService {
  final String _baseUrl;

  MovieService({required String baseUrl}) : _baseUrl = baseUrl;

  Future<void> addMovie({
    required String title,
    required String description,
    required String genre,
    required int duration,
    required String image, 
    required int totalTickets,
    required int availableTickets,
    required String horario,
    required String sala,
  }) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/filmes"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'titulo': title,
        'sinopse': description,
        'genero': genre,
        'duracao': duration,
        'imagem': image, 
        'quantidadeIngressos': totalTickets,
        'quantidadeIngressosDisponivel': availableTickets,
        'horario': horario,
        'sala': sala,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar filme');
    }
  }

  Future<List<dynamic>> fetchMovies() async {
    final response = await http.get(Uri.parse("$_baseUrl/filmes"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      return data.map((item) {
        return {
          'imagem': item['imagem'],
          'titulo': item['titulo'],
          'genero': item['genero'] ?? 'Gênero não disponível',
          'horario': item['horario'] ?? 'Não disponível',
          'sala': item['sala'] ?? 'Não disponível',
        };
      }).toList();
    } else {
      throw Exception('Falha ao carregar filmes');
    }
  }

  Future<void> deleteMovie(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/filmes/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete movie');
    }
  }

  Future<void> updateMovie(int id, Map<String, dynamic> movie) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/filmes/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(movie),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update movie');
    }
  }
}
