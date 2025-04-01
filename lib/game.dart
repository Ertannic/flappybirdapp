import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappybirdapp/components/background.dart';
import 'package:flappybirdapp/components/bird.dart';
import 'package:flappybirdapp/components/ground.dart';
import 'package:flappybirdapp/components/pipe_manager.dart';
import 'package:flappybirdapp/components/score.dart';
import 'package:flappybirdapp/constants.dart';
import 'package:flutter/material.dart';
import 'components/pipe.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  /* 
  
  Basic Game Components:
  - bird
  - background
  - ground 
  - pipes 
  - score
  
  */

  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  /*
  
  LOAD

  */

  @override
  FutureOr<void> onLoad() {
    // load backgorund
    background = Background(size);
    add(background);

    // load bird
    bird = Bird();
    add(bird);

    // load ground
    ground = Ground();
    add(ground);

    // load pipes
    pipeManager = PipeManager();
    add(pipeManager);

    // load score
    scoreText = ScoreText();
    add(scoreText);
  }

  @override
  void onTap() {
    bird.flap();
  }

  /*
  
  SCORE 

  */

  int score = 0;

  void incrementScore() {
    score += 1;
  }

  /*
  
  GAME OVER 

  */

  bool isGameOver = false;

  void gameOver() {
    // prevent multiple game over triggers
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    // show dialog box for user
    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text("High Score: $score"), // показываем текущий счет
        actions: [
          TextButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // reset game
              resetGame(); // вызываем resetGame для перезапуска игры
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY); // сбросить позицию птицы
    bird.velocity = 0; // сбросить скорость
    score = 0; // сбросить счет
    isGameOver = false; // сбросить статус Game Over

    // Удалить все трубы
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());

    // Возобновить игру
    resumeEngine();
  }
}
