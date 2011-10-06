//
//  Player.h
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AEntity.h"
#import "AScene.h"

#define MOVE_COMPORTMENT 0
#define ACTION_COMPORTMENT 1

@interface Player : AEntity
{
    float dieTime;
    NSArray *gameComportments;
    int     currentComportment;
}

- (int)getCurrentComportment;
- (void)switchGameComportment;
- (void)update:(ccTime)dt;

@end
