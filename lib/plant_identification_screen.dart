import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PlantIdentificationScreen extends StatefulWidget {
  const PlantIdentificationScreen({Key? key}) : super(key: key);

  @override
  _PlantIdentificationScreenState createState() =>
      _PlantIdentificationScreenState();
}

class _PlantIdentificationScreenState extends State<PlantIdentificationScreen> {
  File? _image;
  String _plantInfo = '';
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> identifyPlant() async {
    if (_image == null) {
      setState(() {
        _plantInfo = 'No image selected.';
      });
      return;
    }

    String apiKey = 'sk-45NW67ff61859e24e9825'; // Substitua pela sua chave real
    String imagePath = _image!.path;
    String imageName = imagePath.split('/').last;
    String url =
        "https://perenual.com/api/species-pictures?key=$apiKey&q=$imageName";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('file', _image!.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var result = json.decode(responseData);
        print(result);
        setState(() {
          _plantInfo = result.toString(); // Exibe a resposta da API
        });
      } else {
        setState(() {
          _plantInfo =
              'Erro ao identificar a planta. Código: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _plantInfo = 'Erro: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identificação de Planta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Center(
              child: _image == null
                  ? const Text('Nenhuma imagem selecionada.')
                  : Image.file(_image!),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: getImage,
              child: const Text('Selecionar Imagem'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: identifyPlant,
              child: const Text('Identificar Planta'),
            ),
            const SizedBox(height: 16),
            Text(_plantInfo),
          ],
        ),
      ),
    );
  }
}
