//
//  ActionGameComportment.m
//  TUROTUNA
//
//  Created by  on 11. 10. 4..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActionGameComportment.h"
#import "Player.h"
#import "PathManager.h"
#import "GameScene.h"

@implementation ActionGameComportment

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) init:(GameScene *)scene player:(Player *)owner
{
    self = [super init:(GameScene*) scene
                player:(Player*) owner];
    if (self)
    {
        
    }
    return self;
}

- (void)update:(ccTime)dt
{
    if ([[_owner getPath] getSize] != 0)
    {
        CGPoint current = _owner.position;
        CGPoint next = [[_owner getPath] peekPoint];
        if (CGPOINTEQUALS(current, next))
        {
            [[_owner getPath] popPoint];
            next = [[_owner getPath] peekPoint];
            float distance = sqrtf(powf(next.x - current.x, 2) + powf(next.y - current.y, 2));
            [_owner moveTo:next inDuration: distance / _owner.speed];
        }
    }
    else
        [_scene switchGameComportment];
}

- (void) touchPointMoved:(CGPoint *)point
{
    
}

- (void) newTouchBegan:(CGPoint *)point
{
    
}

- (void) touchEnded:(UITouch *)touch atLocation:(CGPoint)location
{
    
}

- (void) onComportmentSwitchedOn
{
    if ([[_owner getPath] getSize] == 0)
        return;
    CGPoint next = [[_owner getPath] peekPoint];
    CGPoint pos = _owner.position;
    float distance = sqrtf(powf(next.x - pos.x, 2) + powf(next.y - pos.y, 2));
    [_owner moveTo:next
        inDuration:distance / _owner.speed];
}

- (void) onComportmentSwitchedOff
{
    [_owner moveTo:_owner.position
        inDuration:1.f];
}

@end
