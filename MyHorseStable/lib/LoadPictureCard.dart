import 'package:flutter/material.dart';
import 'LoadPicture.dart';

class LoadPictureCard extends StatelessWidget {
  LoadPictureCard({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return new LoadPicture("Aucune photo pour ce cheval");
  }
}
