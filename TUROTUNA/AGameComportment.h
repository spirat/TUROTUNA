//
//  AGameComportment.h
//  TUROTUNA
//
//  Created by  on 11. 10. 4..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "AScene.h"
#include "Player.h"

@interface AGameComportment : NSObject
{
    @protected
    AScene  *_scene;
    Player  *_owner;
}

- (id)init:(AScene*)scene player:(Player*)owner;
- (void)update:(ccTime)dt;

- (void) touchPointMoved:(CGPoint *)point;
- (void) newTouchBegan:(CGPoint *)point;
- (void) touchEnded:(UITouch*)touch atLocation:(CGPoint)location;

@end
