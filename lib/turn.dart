import 'package:flutter/material.dart';

class Turn extends StatefulWidget {

  final int player;
  final bool finished;

  Turn({this.player, this.finished});

  @override
  _TurnState createState() => _TurnState();
}

class _TurnState extends State<Turn> {
  @override
  Widget build(BuildContext context) {
    String player = this.widget.player.toString();
    String turnLine1 = 'Es el turno de: ';
    String turnLine2 = 'Jugador $player';
    if(this.widget.finished) {
      turnLine1 = 'Felicidades jugador $player!!!!';
      turnLine2 = 'Pulsa el botón Reset para jugar otra partida.';
    }
    return Column(
      children: [
        Center(
          child: Text(
            turnLine1,
            style: Theme.of(context).textTheme.display1,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
              turnLine2,
              style: Theme.of(context).textTheme.body2,
            ),
        ),
      ],
    );
  }
}

