import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappybirdapp/constants.dart';

class Bird extends SpriteComponent {
  /* 
  
    INIT BIRD
  
   */

  // initialize bird position & size
  Bird()
      : super(
            position: Vector2(birdStartX, birdStartY),
            size: Vector2(birdWidth, birdHeight));

  // phisical world properties
  double velocity = 0;


  /* 
  
  LOAD
  
   */

  @override
  FutureOr<void> onLoad() async {
    // load bird sprite image
    sprite = await Sprite.load('bird.png');
  }

  /*

  JUMP / FLAP
  
  */
  void flap() {
    velocity = jumpStrength;
  }

  /* 
  
  UPDATE -> every second
  
  */

  @override
  void update(double dt) {
    // apply gravity
    velocity += gravity * dt;

    // update bird's position based on current velosity
    position.y += velocity * dt;
  }
}
