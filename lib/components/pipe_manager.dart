import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappybirdapp/components/pipe.dart';
import 'package:flappybirdapp/constants.dart';
import 'package:flappybirdapp/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  /* 
  
  UPDATE -> every second (dt)

  We will continuously spawn new pipes

   */

  double pipeSpawnTime = 0;

  @override
  void update(double dt) {
    // generate new pipe at given interval
    pipeSpawnTime += dt;
    const double pipeInterval = 2;

    if (pipeSpawnTime > pipeInterval) {
      pipeSpawnTime = 0;
      spawnPipe();
    }
  }

  /*
  
  SPAWN NEW PIPES

   */

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;
    const double pipeGap = 150;
    const double minPipeHeight = 50;
    const double pipeWidth = 60;

    /*
    
    CALCULATE PIPE HEIGHT 

   */
    // max possible height
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;
    // height of the bottom pipe -> randomly select between min and max
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    // height of top pipe
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    /*
    
    CREATE BOTTOM PIPE
    
     */

    final bottomPipe = Pipe(
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    /*
    
    CREATE TOP PIPE
    
     */

    final topPipe = Pipe(
      Vector2(gameRef.size.x, 0),
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    // add both pipes to the game
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
