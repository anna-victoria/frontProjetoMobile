import 'package:flutter/material.dart';
import 'package:front_projeto_mobile/src/services/movie_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class MovieFormScreen extends StatefulWidget {
  final Map<String, dynamic>? movie;

  MovieFormScreen({this.movie});

  @override
  _MovieFormScreenState createState() => _MovieFormScreenState();
}

class _MovieFormScreenState extends State<MovieFormScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ticketsController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  String _selectedTime = '10:00';
  String _selectedRoom = 'Sala 1';
  String _selectedGenre = 'Drama';
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();
  final MovieService _movieService = MovieService(
      baseUrl: 'http://localhost:8080'); 

  @override
  void initState() {
    super.initState();

    if (widget.movie != null) {
      _titleController.text = widget.movie?['titulo'] ?? '';
      _descriptionController.text = widget.movie?['sinopse'] ?? '';
      _selectedGenre = widget.movie?['genero'] ?? 'Drama';
      _durationController.text = widget.movie?['duracao']?.toString() ?? '';
      _ticketsController.text =
          widget.movie?['quantidadeIngressosDisponivel']?.toString() ?? '';
      _selectedTime = widget.movie?['horario'] ?? '10:00';
      _selectedRoom = widget.movie?['sala'] ?? 'Sala 1';
      _imageController.text = widget.movie?['imagem'] ?? '';
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          final bytes = _imageFile!.readAsBytesSync();
          _imageController.text = base64Encode(bytes);
        });
      }
    } catch (e) {
      print('Erro ao selecionar a imagem: $e');
    }
  }

Future<void> _saveMovie() async {
  try {
    if (_durationController.text.isEmpty) {
      throw Exception('Duração é um campo obrigatório');
    }
    if (_ticketsController.text.isEmpty) {
      throw Exception('Quantidade de ingressos é um campo obrigatório');
    }

    final duration = int.tryParse(_durationController.text) ?? 0;
    final totalTickets = int.tryParse(_ticketsController.text) ?? 0;
    final availableTickets = int.tryParse(_ticketsController.text) ?? 0;

    if (widget.movie != null) {
      await _movieService.updateMovie(
        widget.movie!['id'],
        {
          'titulo': _titleController.text,
          'sinopse': _descriptionController.text,
          'genero': _selectedGenre,
          'duracao': duration,
          'imagem': _imageController.text,
          'quantidadeIngressos': totalTickets,
          'quantidadeIngressosDisponivel': availableTickets,
          'horario': _selectedTime,
          'sala': _selectedRoom,
        },
      );
    } else {
      await _movieService.addMovie(
        title: _titleController.text,
        description: _descriptionController.text,
        genre: _selectedGenre,
        duration: duration,
        image: _imageController.text,
        totalTickets: totalTickets,
        availableTickets: availableTickets,
        horario: _selectedTime,
        sala: _selectedRoom,
      );
    }
    Navigator.pop(context);
  } catch (e) {
    print('Failed to save movie: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Nome do Filme',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedGenre,
              items: [
                'Drama',
                'Acao',
                'Comedia',
                'Romance',
                'Terror',
                'Aventura',
                'Ficcao Cientifica',
                'Suspense'
              ]
                  .map((genre) =>
                      DropdownMenuItem(value: genre, child: Text(genre)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGenre = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Gênero',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Duração (min)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedTime,
              items: ['10:00', '12:00', '15:00', '20:00', '22:00']
                  .map((time) =>
                      DropdownMenuItem(value: time, child: Text(time)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTime = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Horário',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ticketsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingressos Disponíveis',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedRoom,
              items: ['Sala 1', 'Sala 2', 'Sala 3', 'Sala 4', 'Sala 5']
                  .map((room) =>
                      DropdownMenuItem(value: room, child: Text(room)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRoom = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Sala',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _imageController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Foto',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: _pickImage,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveMovie,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
