import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart'; 
import 'package:front_projeto_mobile/src/services/user_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _userService = UserService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final MaskedTextController _dataNascimentoController =
      MaskedTextController(mask: '00/00/0000');
  final MaskedTextController _cpfController =
      MaskedTextController(mask: '000.000.000-00'); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2B41),
      appBar: AppBar(
        title: const Text('Tela de Cadastro'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/images/CINEALL.png'),
            ),
            const SizedBox(height: 70),
            Form(
              key: _formKey,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.80,
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nomeController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'Nome',
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        controller: _senhaController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'Senha',
                        ),
                      ),
                      TextFormField(
                        controller: _dataNascimentoController,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'Data de Nascimento',
                        ),
                      ),
                      TextFormField(
                        controller: _cpfController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'CPF',
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final success = await _userService.registerUser(
                                nome: _nomeController.text,
                                email: _emailController.text,
                                senha: _senhaController.text,
                                dataNascimento: _dataNascimentoController.text,
                                cpf: _cpfController.text,
                              );
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Cadastro realizado com sucesso')),
                                );
                                Navigator.pop(context); 
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Erro ao cadastrar')),
                                );
                              }
                            } catch (e) {
                              print('Erro: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Erro ao realizar o cadastro')),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC6EAD0),
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Confirmar'),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
