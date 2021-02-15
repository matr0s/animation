import 'package:flutter/material.dart';
// * Simple Cat calss where we define image as an atribute
class Cat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network('https://i.imgur.com/QwhZRyL.png');
  }
}
