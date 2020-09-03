import 'dart:math';

import 'package:flutter/material.dart';

class Token extends StatefulWidget {
  final int index;
  final int player;
  final List<int> score;
  final dynamic onTokenPressed;

  Token({Key key,
    this.index,
    this.player,
    this.score,
    this.onTokenPressed}) : super(key: key);

  @override
  _TokenState createState() => _TokenState();
}

class _TokenState extends State<Token> {

  Widget _image;

  @override
  Widget build(BuildContext context) {
    this._image = SizedBox( width: 96, height: 96, );
    int clickedIndex = this.widget.score[this.widget.index];
    int player = this.widget.player;
    if(clickedIndex == 1) {
      this._image = Image(image: AssetImage('assets/circle.png'), width: 96.0, height: 96.0);
    }
    if(clickedIndex == 2) {
      this._image = Image(image: AssetImage('assets/cross.png'), width: 96.0, height: 96.0);
    }
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                boxShadow: [
                  BoxShadow(
                      offset: Offset.fromDirection(0.25*pi, 2.5),
                      blurRadius: 2.5
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
          ),
          this._image,
        ],
      ),
      onTap: () {
        int clickedIndex = this.widget.score[this.widget.index];
        if(clickedIndex == 0) {
          this.widget.onTokenPressed(this.widget.index);
        }
      },
    );
  }
}
