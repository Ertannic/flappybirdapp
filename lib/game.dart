import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappybirdapp/components/background.dart';
import 'package:flappybirdapp/components/bird.dart';

class FlappyBirdGame extends FlameGame with TapDetector {
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

  /*
  
  LOAD

  */

  @override
  FutureOr<void> onLoad() {
    // load bird
    bird = Bird();
    add(bird);
  }

  @override
  void onTap() {
    bird.flap();

    background = Background(size);
    add(background);
  }
}
