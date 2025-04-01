import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappybirdapp/components/ground.dart';
import 'package:flappybirdapp/constants.dart';
import 'package:flappybirdapp/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
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

    // add hit box
    add(RectangleHitbox());
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

  /* 
  
  COLLISION -> with another object 
  
  */

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // check if bird collides with ground
    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
