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

/*
- (bool) pointIntersectsObstacle:(CGPoint)origin point2:(CGPoint)end side:(int*)s point:(CGPoint*)intersection
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
 
                int intersects = 0;
                CGPoint p3, p4;
                
                //top right to bot right
                p3.x = obst.origin.x + obst.size.width;
                p3.y = obst.origin.y + obst.size.height;
                p4.x = p3.x;
                p4.y = p3.y - obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p3, p4, intersection);
                
                //bot right to bot left
                p3.y = p4.y;
                p3.x = p4.x - obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p4, p3, intersection) << 1;
                
                //bot left to top left
                p4.x = p3.x;
                p4.y = p3.y + obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p3, p4, intersection) << 2;
                
                //top left to top right
                p3.y = p4.y;
                p3.x = p4.x + obst.size.width;
                intersects |= MathVectorIntersects(origin, end, p4, p3, intersection) << 3;

                if (intersects != 0)
                {
                    *s = intersects;
                    return true;
                }
                
                if (CGRectContainsPoint(obst, end) || CGRectContainsPoint(obst, origin))
                {
                    if (*s & 0x5)
                        intersection->x = end.x;
                    else if (*s & 0xA)
                        intersection->y = end.y;
                    return true;
                }
            }
        }
    }
     
    return false;
}
*/
/*
- (void) touchPointMoved:(CGPoint *)point
{
    if ([_scene isPlayerFocused])
    {
        if ([[_owner getPath] getSize] != 0)
        {
            static int lastSide;
            static CGPoint lastIntersection;
            if ([self pointIntersectsObstacle:[[_owner getPath] lastPointAdded]
                                       point2:*point 
                                         side:&lastSide 
                                        point:&lastIntersection] == true)
            {
                NSLog(@"Side : %d", lastSide);
                if (lastSide == 1)
                    point->x = lastIntersection.x + 5;
                else if (lastSide == 1 << 1)
                    point->y = lastIntersection.y - 5;
                else if (lastSide == 1 << 2)
                    point->x = lastIntersection.x - 5;
                else if (lastSide == 1 << 3)
                    point->y = lastIntersection.y + 5;
            }
        }
        [[_owner getPath] pushNextPoint:point];
    }
}
*/

bool _CGRectContainsPoint(CGRect r, CGPoint p)
{
    if (CGRectContainsPoint(r, p))
        return true;
    
    if ((p.x == r.origin.x || p.x == r.origin.x + r.size.width) && p.y >= r.origin.y && p.y <= r.origin.y + r.size.height)
        return true;
    if ((p.y == r.origin.y || p.y == r.origin.y + r.size.height) && p.x >= r.origin.x && p.x <= r.origin.x + r.size.width)
        return true;
    
    return false;
}

- (bool) pointIntersectsObstacle:(CGPoint)origin point2:(CGPoint)end point:(CGPoint*)intersection obstacle:(CGRect*)obstInt
{
    
    CGRect vectBound = CGRectMake(MIN(origin.x, end.x), MIN(origin.y, end.y), fabsf(end.x - origin.x), fabsf(end.y - origin.y));
    NSMutableArray *entities = [_scene getEntities];
    
    for (int i = 0, itEnd = [entities count]; i < itEnd; ++i)
    {
        if ([[entities objectAtIndex:i] isMemberOfClass:[Obstacle class]])
        {
            CGRect obst = [(Obstacle*)[entities objectAtIndex:i] getHitbox];
            
            if (CGRectIntersectsRect(vectBound, obst) || _CGRectContainsPoint(obst, end)) //contains does not work on sides of the rect ?
            {
                NSLog(@"Bounding box collision detected");
                
                int intersects = 0;
                CGPoint p3, p4;
                
                //top right to bot right
                p3.x = obst.origin.x + obst.size.width;
                p3.y = obst.origin.y + obst.size.height;
                p4.x = p3.x;
                p4.y = p3.y - obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p3, p4, intersection);
                
                //bot right to bot left
                p3.y = p4.y;
                p3.x = p4.x - obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p4, p3, intersection) << 1;
                
                //bot left to top left
                p4.x = p3.x;
                p4.y = p3.y + obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p3, p4, intersection) << 2;
                
                //top left to top right
                p3.y = p4.y;
                p3.x = p4.x + obst.size.width;
                intersects |= MathVectorIntersects(origin, end, p4, p3, intersection) << 3;
                
                if (intersects != 0 || _CGRectContainsPoint(obst, end))
                {
                    NSLog(@"Intersection OK");
                    *obstInt = obst;
                    return true;
                }
            }
        }
    }
    return false;
}


- (void) touchPointMoved:(CGPoint *)point
{
    static bool inObstacle = false;
    if ([_scene isPlayerFocused])
    {
        PathManager *path = [_owner getPath];
        
        if ([path getSize] != 0)
        {
            CGPoint intersectionPoint;
            // if last doesn't exist
            // if last is too far away from the wall (?)
            CGPoint last = [path lastPointAdded];
            CGRect  obst;
            bool it = [self pointIntersectsObstacle:last
                                             point2:*point 
                                              point:&intersectionPoint
                                           obstacle:&obst];
            if (it == true)
            {
                if (inObstacle == false)
                {
                    NSLog(@"COLLISION DEBUG : last.y = %f obst = %f + %f", last.y, obst.origin.y, obst.size.height);
                    if (last.x <= obst.origin.x)
                        point->x = obst.origin.x - 5;
                    else if (last.x >= (obst.origin.x + obst.size.width))
                        point->x = obst.origin.x + obst.size.width + 5;
                    else if (last.y >= obst.origin.y + obst.size.height)
                        point->y = obst.origin.y + obst.size.height + 5;
                    else if (last.y <= obst.origin.y)
                        point->y = obst.origin.y - 5;
                    inObstacle = true;
                }
                else
                {
                    if (last.x <= obst.origin.x || last.x >= obst.origin.x + obst.size.width)
                        point->x = last.x;
                    else if (last.y >= obst.origin.y || last.x <= obst.origin.y - obst.size.height)
                        point->y = last.y;
                }
            }
            else
                inObstacle = false;
        }
        
        [path pushNextPoint:point];
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
