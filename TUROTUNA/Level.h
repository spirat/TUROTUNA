//
//  Level.h
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include "GameScene.h"

@interface Level : GameScene

enum {
    PLAYER_TYPE,
    TARGET_TYPE,
    ENEMY_TYPE,
    OBSTACLE_TYPE
};

- (void)LoadContent;

@end