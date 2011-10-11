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
    CGPoint tail = [(NSValue*)[_pathPoints objectAtIndex:[_pathPoints count]] CGPointValue];
    if (point->x == tail.x && point->y == tail.y)
        return;
    [_pathPoints addObject:(id)[NSValue valueWithCGPoint:*point]];
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

- (void) draw
{
    int idx = 1;
    int end = [_pathPoints count];
    
    CGPoint beg = [(NSValue*)[_pathPoints objectAtIndex:0] CGPointValue];
    CGPoint next;
    
    while (idx < end)
    {
        next = [(NSValue*)[_pathPoints objectAtIndex:idx] CGPointValue];

        [_line drawLineWithOrigin:&beg 
                          End:&next];
        
        beg = next;
        ++idx;
    }
}

@end
