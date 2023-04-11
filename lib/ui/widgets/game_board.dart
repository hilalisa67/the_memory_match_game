import 'dart:async';

import 'package:flutter/material.dart';

import 'package:the_memory_match_game/models/game.dart';
import 'package:the_memory_match_game/ui/widgets/game_timer.dart';
import 'package:the_memory_match_game/ui/widgets/memory_card.dart';
import 'package:the_memory_match_game/ui/widgets/restart_game.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({
    required this.gameLevel,
    super.key,
  });

  final int gameLevel;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late Timer timer;
  late Game game;
  late Duration duration;
  @override
  void initState() {
    super.initState();
    game = Game(widget.gameLevel);
    duration = const Duration();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        final seconds = duration.inSeconds + 1;
        duration = Duration(seconds: seconds);
      });

      if (game.isGameOver) {
        timer.cancel();
      }
    });
  }

  pauseTimer() {
    timer.cancel();
  }

  void _resetGame() {
    game.resetGame();
    setState(() {
      timer.cancel();
      duration = const Duration();
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          GameTimer(
            time: duration,
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: game.gridSize,
              children: List.generate(game.cards.length, (index) {
                return MemoryCard(
                  index: index,
                  card: game.cards[index],
                  onCardPressed: game.onCardPressed,
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0),
            child: RestartGame(
              isGameOver: game.isGameOver,
              pauseGame: () => pauseTimer(),
              restartGame: () => _resetGame(),
              continueGame: () => startTimer(),
            ),
          ),
        ],
      ),
    );
  }
}
