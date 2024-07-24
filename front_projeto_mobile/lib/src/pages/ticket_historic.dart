import 'package:flutter/material.dart';
import 'package:front_projeto_mobile/src/pages/Cart.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'homePageCliente.dart';

class HistoricPage extends StatefulWidget {
  final List<Map<String, dynamic>> historicItems;

  HistoricPage({required this.historicItems});

  @override
  _HistoricPage createState() => _HistoricPage();
}

class _HistoricPage extends State<HistoricPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF2A2B41),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 54,
            child: Container(
              color: Colors.purple[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Histórico de Compras',
                      style: TextStyle(
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
          Positioned(
            left: 21,
            top: 121,
            right: 21,
            bottom: 61,
            child: widget.historicItems.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma compra, por enquanto',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.historicItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.historicItems[index];
                      final imageBase64 = item['imagem'] ?? '';
                      final title = item['titulo'] ?? 'Título não disponível';
                      final quantity = item['quantidade'] ?? 1;
                      final local = item['local'] ?? 'Local não disponível';

                      ImageProvider imageProvider;
                      if (imageBase64.isNotEmpty) {
                        try {
                          final bytes = base64Decode(imageBase64.split(',').last);
                          imageProvider = MemoryImage(Uint8List.fromList(bytes));
                        } catch (e) {
                          imageProvider = AssetImage('assets/images/placeholder.png');
                          print('Erro ao decodificar imagem: $e');
                        }
                      } else {
                        imageProvider = AssetImage('assets/images/placeholder.png');
                      }

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Image(
                              image: imageProvider,
                              width: 80,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Local: $local',
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Quantidade: $quantity',
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 68,
            child: SafeArea(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePageCliente(nome: widget.historicItems.isEmpty ? '' : widget.historicItems[0]['nome']),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoricPage(historicItems: widget.historicItems),
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
          ),
        ],
      ),
    );
  }
}
