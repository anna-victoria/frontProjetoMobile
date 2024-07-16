import 'package:flutter/material.dart';
import 'package:front_projeto_mobile/src/pages/home_page_funcionario.dart';
import 'package:front_projeto_mobile/src/sign_up_page.dart';

class LoginPage extends StatelessWidget {
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
            // TODO: Fix the image
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
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              labelText: 'Email',
                            ),
                          ),
                          TextFormField(
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
                        onPressed: () {
                          // TODO: Implement login logic
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageFuncionario()));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
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
