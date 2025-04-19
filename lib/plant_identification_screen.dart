import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PlantIdentificationScreen extends StatefulWidget {
  @override
  _PlantIdentificationScreenState createState() => _PlantIdentificationScreenState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plant Identification')),
      body: Center(child: Text('Plant Identification Screen')),
    );
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plant Identification')),
      body: Column(
        children: <Widget>[
          Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
          ),
          ElevatedButton(
            onPressed: getImage,
            child: Text('Select Image'),
          ),
          Text(_plantInfo),
        ],
      ),
    );
  }

  Future<void> identifyPlant() async {
    if (_image == null) {
      setState(() {
        _plantInfo = 'No image selected.';
      });
      return;
    }
    // Replace with your actual API key
    String apiKey = 'sk-45NW67ff61859e24e9825'; // TODO: Get API key from user
    String imagePath = _image!.path;
    String imageName = imagePath.split('/').last;
    String url = "https://perenual.com/api/species-pictures?key=" + apiKey + "&q=" + imageName;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var result = json.decode(responseData);
        print(result);
        setState(() {
          _plantInfo = result.toString(); // Display the API response
        });
      } else {
        setState(() {
          _plantInfo = 'Error identifying plant. Status code: ' + response.statusCode.toString();
        });
      }
    } catch (e) {
      setState(() {
        _plantInfo = 'Error identifying plant: ' + e.toString();
      });
    }
  }
}
