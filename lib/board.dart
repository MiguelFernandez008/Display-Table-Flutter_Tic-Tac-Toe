import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/token.dart';
import 'package:tic_tac_toe/turn.dart';

class Board extends StatefulWidget {

  final String title;

  Board({this.title});

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {

  List<int> _score = [0,0,0,0,0,0,0,0,0];
  int _player = 1;
  bool _started = false;
  bool _finished = false;

  void _startGame() {
    setState(() {
      this._started = true;
      this._finished = false;
    });
  }

  void _finishGame() {
    setState(() {
      this._finished = true;
    });
  }

  void tokenPressed(int index) {
    if(!this._started) {
      this._startGame();
    }
    if(!this._finished) {
      this._setPlay(index);
      this._checkWinner();
      this._setPlayer();
    }
    else {
      this._showMessage('Pulsa el botón Reset para jugar otra partida.');
    }
  }

  void _resetGame() {
    setState(() {
      this._score = [0,0,0,0,0,0,0,0,0];
      this._player = 1;
      this._started = false;
      this._finished = false;
    });
  }

  void _setPlayer() {
    if(!this._finished) {
      if(this._player == 1) {
        setState(() { this._player = 2; });
      }
      else {
        setState(() { this._player = 1; });
      }
    }
  }

  void _setPlay(int index) {
    setState(() {
      this._score[index] = this._player;
    });
  }

  void _checkWinner() {
    int player = this._player;
    if(
      (this._score[0] == player && this._score[1] == player && this._score[2] == player) ||
      (this._score[3] == player && this._score[4] == player && this._score[5] == player) ||
      (this._score[6] == player && this._score[7] == player && this._score[8] == player) ||
      (this._score[0] == player && this._score[3] == player && this._score[6] == player) ||
      (this._score[1] == player && this._score[4] == player && this._score[7] == player) ||
      (this._score[2] == player && this._score[5] == player && this._score[8] == player) ||
      (this._score[0] == player && this._score[4] == player && this._score[8] == player) ||
      (this._score[2] == player && this._score[4] == player && this._score[6] == player)
    ) {
      this._finishGame();
    }
  }

  void _showMessage(String message) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                )
            ),
            actions: [
              FlatButton(
                child: Text(
                    'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Turn(
                player: this._player,
                finished: this._finished,
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(9, (index) => Token(
                    index: index,
                    player: this._player,
                    score: this._score,
                    onTokenPressed: this.tokenPressed
                )),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: this._resetGame,
          icon: Icon(Icons.autorenew),
          label: Text('Reset')
      ),
    );
  }
}
