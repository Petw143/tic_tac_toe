
import 'package:flutter/material.dart';

void main()
{
  runApp(JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: _TelaJogoDaVelha(),
    );
  }
}

class _TelaJogoDaVelha extends StatefulWidget{
	_TelaJogoDaVelhaState createState() => _TelaJogoDaVelhaState();
}

class _TelaJogoDaVelhaState extends State<_TelaJogoDaVelha>
{
	@override
	Widget build(BuildContext context)
	{
		return Scaffold(

		);
	}

}