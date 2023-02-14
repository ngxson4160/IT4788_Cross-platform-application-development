import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../values/api_values.dart';

class UploadImages extends StatefulWidget {
  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  List<File> _images = [];
  final ImagePicker picker = ImagePicker();
  Future<void> _pickImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _images.add(File(image!.path));
    });
  }

  Future<void> _uploadImage(File image) async {
    String url =
        'https://flutter-hust.onrender.com/it4788/post/add_post?token=${ApiValues.TOKEN.toString()}';

    // use FormData to handle binary data
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var response = await request.send();
    // var response = await streamedResponse.stream.bytesToString();

    if (response.statusCode == 201) {
      print('Image uploaded successfully');
      // print(response);
    } else {
      print('Failed to upload image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick and Upload Multiple Images'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Image.file(_images[index]);
              },
            ),
          ),
          TextButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          TextButton(
            onPressed: () {
              for (var image in _images) {
                _uploadImage(image);
              }
            },
            child: Text('Upload Images'),
          ),
        ],
      ),
    );
  }
}
