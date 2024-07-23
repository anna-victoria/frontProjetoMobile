import 'package:flutter/material.dart';

class HomePageCliente extends StatelessWidget {
  final String nome;

  HomePageCliente({required this.nome});

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
                      'Bem vindo(a) $nome!',
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
            child: ListView(
              children: List.generate(10, (index) => MovieCard()),
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
                        'Pagina Inicial',
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


class MovieCard extends StatefulWidget {
  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 340,
        height: isExpanded ? 400 : 150, 
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 12,
              top: 12,
              bottom: 12,
              child: Container(
                width: 80,
                color: Color(0xFFB75DEF),
              ),
            ),
            Positioned(
              left: 130,
              top: 15,
              child: Text(
                'Nome do filme',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: 130,
              top: 55,
              child: Text(
                'Horários: 10:00 - 12:00 - 15:00 - 20:00 - 22:00',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: 130,
              top: 100,
              child: Text(
                'Sala XX',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            if (isExpanded) ...[
              Positioned(
                left: 130,
                top: 135,
                child: Container(
                  width: 200,
                  child: Text(
                    'Descrição: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras viverra varius velit, a facilisis neque vulputate vel. Nulla facilisi.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 220, 
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Escolha o horário:',
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
              ),
              Positioned(
                left: 33,
                top: 280,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Escolha quantidade de ingressos:',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  items: List.generate(10, (index) => '${index + 1}').map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
              Positioned(
                left: 33,
                top: 340,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Forma de pagamento:',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  items: ['Cartão de crédito', 'Boleto', 'Pix'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
              Positioned(
                left: 33,
                top: 370,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = false;
                        });
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
                        'ADICIONAR',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
