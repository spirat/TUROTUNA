//
//  GameScene.h
//  TUROTUNA
//
//  Created by  on 11. 10. 11..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AScene.h"
#import "ActionGameComportment.h"
#import "MoveGameComportment.h"

#define MOVE_COMPORTMENT 0
#define ACTION_COMPORTMENT 1

@interface GameScene : AScene
{
    @private
    Player  *_player;
    NSArray *gameComportments;
    int     currentComportment;
}

- (void)newTouchBegan:(CGPoint *)point;
- (void)touchPointMoved:(CGPoint *)point;


- (int)getCurrentComportment;
- (void)switchGameComportment;

@end
