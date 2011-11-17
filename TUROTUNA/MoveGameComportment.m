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

- (bool) pointIntersectsObstacle:(CGPoint)origin point2:(CGPoint)end side:(int*)s
{
    
    CGRect vectBound = CGRectMake(origin.x, origin.y, fabsf(end.x - origin.x), fabsf(end.y - origin.y));
    NSMutableArray *entities = [_scene getEntities];

    for (int i = 0, itEnd = [entities count]; i < itEnd; ++i)
    {
        if ([[entities objectAtIndex:i] isMemberOfClass:[Obstacle class]])
        {
            CGRect obst = [(Obstacle*)[entities objectAtIndex:i] getHitbox];

            if (CGRectIntersectsRect(vectBound, obst))
            {
                NSLog(@"Bounding box collision detected");
 
                CGPoint r;
                int intersects = 0;
                CGPoint p3, p4;
                
                //top right to bot right
                p3.x = obst.origin.x + obst.size.width;
                p3.y = obst.origin.y + obst.size.height;
                p4.x = p3.x;
                p4.y = p3.y - obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p3, p4, &r);
                
                //bot right to bot left
                p3.y = p4.y;
                p3.x = p4.x - obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p4, p3, &r) << 1;
                
                //bot left to top left
                p4.x = p3.x;
                p4.y = p3.y + obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p3, p4, &r) << 2;
                
                //top left to top right
                p3.y = p4.y;
                p3.x = p4.x + obst.size.width;
                intersects |= MathVectorIntersects(origin, end, p4, p3, &r) << 3;

                *s = intersects;
                
                if (intersects != false)
                    return true;
            }
        }
    }
     
    return false;
}

- (void) touchPointMoved:(CGPoint *)point
{
    if ([_scene isPlayerFocused])
    {
        if ([[_owner getPath] getSize] != 0)
        {
            int s;
            if ([self pointIntersectsObstacle:[[_owner getPath] lastPointAdded]
                                 point2:*point side:&s] == true)
            {
                if (s == 1)
                    point->x += 2;
                else if (s == 1 << 1)
                    point->y -= 2;
                else if (s == 1 << 2)
                    point->x -= 2;
                else if (s == 1 << 3)
                    point->y += 2;
            }
        }
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
