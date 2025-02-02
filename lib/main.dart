import 'package:flutter/material.dart';

void main() {
  runApp(JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(primarySwatch: Colors.green),
      home: _TelaJogoDaVelha(),
    );
  }
}

class _TelaJogoDaVelha extends StatefulWidget {
  @override
  _TelaJogoDaVelhaState createState() => _TelaJogoDaVelhaState();
}

class _TelaJogoDaVelhaState extends State<_TelaJogoDaVelha> {
  //Criando o tabuleiro
  List<List<String>> tabuleiro = List.generate(3, (_) => List.filled(3, ''));

  // Jogador atual
  String jogadorAtual = 'X';

  // Verifica se o jogo acabou
  bool jogoAcabou = false;

  // Reinicia o tabuleiro
  void reiniciarJogo() {
    setState(() {
      tabuleiro = List.generate(3, (_) => List.filled(3, ''));
      jogadorAtual = 'X';
      jogoAcabou = false;
    });
  }

  // Verifica o vencedor
  String verificarVencedor() {
    // Verifica as linhas horizontais
    for (int i = 0; i < 3; i++) {
      if (tabuleiro[i][0] != '' &&
          tabuleiro[i][0] == tabuleiro[i][1] &&
          tabuleiro[i][1] == tabuleiro[i][2]) {
        return tabuleiro[i][0];
      }
    }

    //Verifica as linhas verticais
    for (int i = 0; i < 3; i++) {
      if (tabuleiro[0][i] != '' &&
          tabuleiro[1][i] == tabuleiro[1][i] &&
          tabuleiro[1][i] == tabuleiro[2][i]) {
        return tabuleiro[0][i];
      }
    }

    //Verifica as diagonais
    if (tabuleiro[0][0] != '' &&
        tabuleiro[0][0] == tabuleiro[1][1] &&
        tabuleiro[1][1] == tabuleiro[2][2]) {
      return tabuleiro[0][0];
    }
    if (tabuleiro[0][2] != '' &&
        tabuleiro[0][2] == tabuleiro[1][1] &&
        tabuleiro[1][1] == tabuleiro[2][0]) {
      return tabuleiro[0][2];
    }

    //Verifica empate
    bool empate = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (tabuleiro[i][j] == '') {
          empate = false;
          break;
        }
      }
    }
    if (empate) return 'Empate';

    return '';
  }

  //Função para jogar
  void jogar(int linha, int coluna) {
    if (tabuleiro[linha][coluna] == '' && !jogoAcabou) {
      setState(() {
        tabuleiro[linha][coluna] = jogadorAtual;
        String vencedor = verificarVencedor();
        if (vencedor != '') {
          jogoAcabou = true;
          //mostrarResultado(vencedor);
        }else{
			jogadorAtual = jogadorAtual == 'X' ? 'O' : 'X';
		}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
