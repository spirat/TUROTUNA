//
//  PathManager.m
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PathManager.h"
#import "Player.h"
#import "Line.h"

@implementation PathManager

- (id)init
{
    self = [super init];
    if (self) {
        _pathPoints = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id) initWithScene:(AScene*)scene
{
    self = [super init];
    if (self)
    {
        _scene = scene;
        _line = [[Line alloc]init];
        _pathPoints = [[NSMutableArray alloc]init];
        [_scene addChild:_line];
    }
    return self;
}

- (void) dealloc
{
    [_scene removeChild:_line cleanup:true];
    [_line release];
    [_pathPoints release];
    [super dealloc];
}

- (void)pushNextPoint:(CGPoint*)point
{
    if ([_pathPoints count])
    {
        CGPoint tail = [(NSValue*)[_pathPoints objectAtIndex:[_pathPoints count] - 1] CGPointValue];
        if (point->x == tail.x && point->y == tail.y)
            return;
    }
    id next = (id)[NSValue valueWithCGPoint:*point];
    [_pathPoints addObject:next];
}

- (CGPoint)peekPoint
{
    return [(NSValue*)[_pathPoints objectAtIndex:0] CGPointValue];
}

- (CGPoint)popPoint
{
    if ([_pathPoints count] == 0)
        return CGPointZero;
    CGPoint head = [(NSValue*)[_pathPoints objectAtIndex:0] CGPointValue];
    [_pathPoints removeObjectAtIndex:0];
    return head;
}

- (void) drawPath
{
    int idx = 1;
    int end = [_pathPoints count];
    
    CGPoint next = [(NSValue*)[_pathPoints objectAtIndex:0] CGPointValue];
    CGPoint beg;
    
    while (idx < end)
    {
        beg = next;
        next = [(NSValue*)[_pathPoints objectAtIndex:idx] CGPointValue];

        [_line drawLineWithOrigin:&beg
                              End:&next];
        ++idx;
    }
}

@end
