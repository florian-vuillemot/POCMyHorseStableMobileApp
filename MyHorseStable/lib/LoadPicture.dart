import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LoadPicture extends StatelessWidget {
  const LoadPicture();

  @override
  Widget build(BuildContext context) {
    return new _LoaderPictureWrapper();
  }
}

class _LoaderPictureWrapper extends StatefulWidget {
  _LoaderPictureWrapper({Key key}) : super(key: key);

  @override
  _LoaderPicture createState() => new _LoaderPicture();
}

class _LoaderPicture extends State<_LoaderPictureWrapper> {
  Future<File> _imageFile;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
//          heightFactor: 0.5,
          child: new FutureBuilder<File>(
              future: _imageFile,
              builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return new Image.file(snapshot.data);
                } else {
                  return const Text('You have not yet picked an image.');
                }
              })),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          setState(() {
            _imageFile = ImagePicker.pickImage();
          });
        },
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}