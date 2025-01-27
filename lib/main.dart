import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const JogoDaVelha(),
    );
  }
}

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  State<JogoDaVelha> createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> board = List.generate(9, (index) => '');
  String currentPlayer = '🐇'; // 🐇 para jogador 1, 🥕 para jogador 2
  bool gameOver = false;
  String winner = '';

  void resetGame() {
    setState(() {
      board = List.generate(9, (index) => '');
      currentPlayer = '🐇';
      gameOver = false;
      winner = '';
    });
  }

  void playMove(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = currentPlayer;
        checkWinner();
        if (!gameOver) {
          currentPlayer = currentPlayer == '🐇' ? '🥕' : '🐇';
        }
      });
    }
  }

  void checkWinner() {
    // Condições de vitória
    const winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var positions in winningPositions) {
      if (board[positions[0]] == board[positions[1]] &&
          board[positions[1]] == board[positions[2]] &&
          board[positions[0]] != '') {
        gameOver = true;
        winner = board[positions[0]];
        return;
      }
    }

    if (!board.contains('')) {
      gameOver = true;
      winner = 'Empate';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pastelYellow,
      appBar: AppBar(
        title: const Text('Jogo da Velha: Tema de Coelho'),
        backgroundColor: Colors.pastelBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (gameOver)
            Text(
              winner == 'Empate'
                  ? 'O jogo terminou em empate!'
                  : '$winner venceu!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => playMove(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pastelGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pastelPink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Reiniciar Jogo',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

extension Colors on ColorScheme {
  static const pastelBlue = Color(0xFFA7C7E7);
  static const pastelPink = Color(0xFFF4C2C2);
  static const pastelGreen = Color(0xFFB7E4C7);
  static const pastelYellow = Color(0xFFFFE5B4);
}
