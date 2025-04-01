import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappybirdapp/components/background.dart';
import 'package:flappybirdapp/components/bird.dart';
import 'package:flappybirdapp/components/ground.dart';
import 'package:flappybirdapp/components/pipe_manager.dart';
import 'package:flappybirdapp/constants.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  void onTap() {
    bird.flap();
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
        actions: [
          TextButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // reset Game
            },
            child: const Text("Restart"),
          )
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    isGameOver = false;
    resumeEngine();
  }
}
