import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappybirdapp/constants.dart';
import 'package:flappybirdapp/game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  // determine if the pipe is top or bottom
  final bool isTopPipe;

  // score
  bool scored = false;

  // init
  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  /* 
  
  LOAD

   */

  @override
  FutureOr<void> onLoad() async {
    // load sprite image
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');

    // add hit box for collison
    add(RectangleHitbox());
  }

  /* 
  
  UPDATE

   */

  @override
  void update(double dt) {
    // scroll pipe to left
    position.x -= groundScrollingSpeed * dt;

    // check it the bird has passed this pipe
    if (!scored && position.x + size.x < gameRef.bird.position.x) {
      scored = true;

      // only increment for the pipes to avoid double counting
      if (isTopPipe) {
        gameRef.incrementScore();
      }
    }

    // remove pipe if it goes off the screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
