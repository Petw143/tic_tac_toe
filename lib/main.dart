import 'package:flutter/material.dart';

void main() {
  runApp(JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(primarySwatch: Colors.blue),
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

    //Verifica as colunas
    for (int j = 0; j < 3; j++) {
      if (tabuleiro[0][j] != '' &&
          tabuleiro[0][j] == tabuleiro[1][j] &&
          tabuleiro[1][j] == tabuleiro[2][j]) {
        return tabuleiro[0][j];
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
          mostrarResultado(vencedor);
        } else {
          jogadorAtual = jogadorAtual == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  //Mostrar o resultado do jogo
  void mostrarResultado(String vencedor) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(vencedor == 'Empate' ? 'Empate!' : 'Vitória!'),
              content: Text(vencedor == 'Empate'
                  ? 'O jogo terminou em empate.'
                  : 'O vencedor $vencedor venceu!'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      reiniciarJogo();
                    },
                    child: Text('Jogar Novamente'))
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
			title: Text("Jogo da Velha", style: TextStyle(color: Colors.white, fontFamily: 'Roboto')),
			centerTitle:  true,
			backgroundColor: Colors.blue[900],
        ),
        body: Center(
            child: Container(
                color: Colors.grey[300], // Define a cor do body para cinza claro
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        //Tabuleiro 3x3
                        for (int i = 0; i < 3; i++)
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    for (int j = 0; j < 3; j++)
                                        GestureDetector(
                                            onTap: () => jogar(i, j),
                                            child: Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black),
													color: Colors.white),
                                                child: Center(
                                                    child: Text(tabuleiro[i][j],
                                                        style: TextStyle(fontSize: 40)))))
                                ],
                            ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: reiniciarJogo, child: Text('Reiniciar Jogo', style: TextStyle(color: Colors.white)),)
                    ],
                ),
            ),
        ),
    );
  }
}
