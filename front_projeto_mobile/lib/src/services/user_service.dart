import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = 'http://localhost:8080/usuarios';

  Future<bool> registerUser({
    required String nome,
    required String email,
    required String senha,
    required String dataNascimento,
    required String cpf,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
        'email': email,
        'senha': senha,
        'dataNascimento': dataNascimento,
        'cpf': cpf,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
