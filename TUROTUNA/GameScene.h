//
//  GameScene.h
//  TUROTUNA
//
//  Created by  on 11. 10. 11..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AScene.h"
#import "cocos2d.h"
#import "Player.h"

#define MOVE_COMPORTMENT 0
#define ACTION_COMPORTMENT 1

@interface GameScene : AScene
{
    @protected
    Player  *_player;
    NSArray *gameComportments;
    int     currentComportment;
    bool    _bPlayerFocused;
}
+ (CCScene*) scene;
- (void)newTouchBegan:(CGPoint *)point;
- (void)touchPointMoved:(CGPoint *)point;
- (void)touchEnded:(UITouch *)touch atLocation:(CGPoint)location;

- (int)getCurrentComportment;
- (void)switchGameComportment;
- (bool)isPlayerFocused;
@end
