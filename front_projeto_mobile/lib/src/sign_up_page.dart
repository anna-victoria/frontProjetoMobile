import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => print("A"), // TEMPLATE
          tooltip: "Voltar",
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/images/CINEALL.png'),
            ),
            const SizedBox(height: 70), 
            Form(
              // key: _formKey,
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
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        // The validator receives the text that the user has entered.
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
                        keyboardType: TextInputType.emailAddress,
                        // The validator receives the text that the user has entered.
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
                        obscureText: true,
                        // The validator receives the text that the user has entered.
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
                        keyboardType: TextInputType.datetime,
                        // The validator receives the text that the user has entered.
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
                        keyboardType: TextInputType.number,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } 
                          else {return value;}
                        },
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          labelText: 'CPF',
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
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
              )
            ),
          ],
        ),
      ),
    );
  }
}