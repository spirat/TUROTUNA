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
    OBSTACLE_TYPE,
    NEUTRAL_TYPE
};

#define FLOOR '0'
#define GRASS '1'
#define FLOWERS '2'
#define SWAMP '3'
#define OBS_H '4'
#define OBS_M '5'
#define OBS_T '6'


- (void)LoadContent;

@end