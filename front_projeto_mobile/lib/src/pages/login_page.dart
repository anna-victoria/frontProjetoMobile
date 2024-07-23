import 'package:flutter/material.dart';
import 'package:front_projeto_mobile/src/pages/homePageCliente.dart';
import 'package:front_projeto_mobile/src/pages/home_page_funcionario.dart';
import 'package:front_projeto_mobile/src/auth_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2B41),
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/images/CINEALL.png'),
            ),
            const SizedBox(height: 70),
            Container(
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
              child: Column(
                children: [
                  Form(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05),
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              labelText: 'Email',
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final email = emailController.text;
                          final password = passwordController.text;

                          final success =
                              await _authService.login(email, password);
                          if (success) {
                            final role = await _authService.getRole();
                            debugPrint('User role: $role');
                            if (role == 'ROLE_USUARIO') {
                              debugPrint('Navigating to HomePageCliente');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageCliente()),
                              );
                            } else if (role == 'ROLE_FUNCIONARIO') {
                              debugPrint('Navigating to HomePageFuncionario');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomePageFuncionario()),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Login falhou. Por favor, verifique suas credenciais.'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3BCA63),
                          foregroundColor: Colors.black,
                        ),
                        child: Text('Login'),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Navega diretamente para HomePageCliente
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageCliente()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC6EAD0),
                          foregroundColor: Colors.black,
                        ),
                        child: Text('Cadastro'),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
