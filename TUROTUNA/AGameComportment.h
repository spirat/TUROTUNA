//
//  AGameComportment.h
//  TUROTUNA
//
//  Created by  on 11. 10. 4..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AScene.h"
#import "Player.h"
#import "GameScene.h"

@interface AGameComportment : NSObject
{
    @protected
    GameScene  *_scene;
    Player  *_owner;
}

- (id)init:(GameScene*)scene player:(Player*)owner;
- (void)update:(ccTime)dt;

- (void) touchPointMoved:(CGPoint *)point;
- (void) newTouchBegan:(CGPoint *)point;
- (void) touchEnded:(UITouch*)touch atLocation:(CGPoint)location;
- (void) onComportmentSwitchedOn;
- (void) onComportmentSwitchedOff;

@end
