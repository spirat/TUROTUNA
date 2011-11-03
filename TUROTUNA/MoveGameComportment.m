//
//  MoveGameComportment.m
//  TUROTUNA
//
//  Created by  on 11. 10. 4..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoveGameComportment.h"
#import "Obstacle.h"
#import "MathUtils.h"

@implementation MoveGameComportment

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)init:(GameScene *)scene player:(Player *)owner
{
    self = [super init:scene player:owner];
    if (self)
    {
    }
    return self;
}

- (void)update:(ccTime)dt;
{
}

- (bool) pointIntersectsObstacle:(CGPoint)origin point2:(CGPoint)end
{
    
    CGRect vectBound = CGRectMake(origin.x, origin.y, fabsf(end.x - origin.x), fabsf(end.y - origin.y));
    NSMutableArray *entities = [_scene getEntities];

    for (int i = 0, end = [entities count]; i < end; ++i)
    {
        if ([[entities objectAtIndex:i] isMemberOfClass:[Obstacle class]])
        {
            Obstacle *e = (Obstacle*)[entities objectAtIndex:i];

            if (CGRectIntersectsRect(vectBound, [e getHitbox]))
            {
                NSLog(@"Bounding box collision detected");
                // if MathVectorIntersects pour chaque cote de e.hitbox
            }
        }
    }
     
    return false;
}

- (void) touchPointMoved:(CGPoint *)point
{
    if ([_scene isPlayerFocused])
    {
        if ([[_owner getPath] getSize] == 0
            || [self pointIntersectsObstacle:[[_owner getPath] lastPointAdded]
                                 point2:*point] == false)
            [[_owner getPath] pushNextPoint:point];
    }
}

- (void) newTouchBegan:(CGPoint *)point
{
    if (![_scene isPlayerFocused])
        return;
    if ([_owner contains:*point])
    {
        [[_owner getPath] clear];
        *point = _owner.position;
        [[_owner getPath] pushNextPoint:point];
    }
}

-(void) touchEnded:(UITouch *)touch atLocation:(CGPoint)location
{
}

- (void) onComportmentSwitchedOn
{
    
}

- (void) onComportmentSwitchedOff
{
    
}

@end
