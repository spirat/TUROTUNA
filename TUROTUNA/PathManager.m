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
        glEnable(GL_LINE_SMOOTH);
        glLineWidth(5.f);
    }
    
    return self;
}

- (id) initWithScene:(AScene*)scene
{
    self = [super init];
    if (self)
    {
        _scene = scene;
        _pathPoints = [[NSMutableArray alloc]init];
        [scene addChild:self];
    }
    return self;
}

- (void) dealloc
{
    [_pathPoints release];
    [_scene removeChild:self cleanup:false];
    [super dealloc];
}

- (void)pushNextPoint:(CGPoint*)point
{
    // verifier une distance minimale entre deux points
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

- (void) draw
{
    int idx = 1;
    int end = [_pathPoints count];
    
    if (end < 2)
        return;
    
    CGPoint next = [(NSValue*)[_pathPoints objectAtIndex:0] CGPointValue];
    CGPoint beg;
    
    glEnable(GL_LINE_SMOOTH);
    glColor4f(1.f, 0.f, 0.f, 1.f);
    glLineWidth(5.f);
    
    while (idx < end)
    {
        beg = next;
        next = [(NSValue*)[_pathPoints objectAtIndex:idx] CGPointValue];
        ccDrawLine(beg, next);
        ++idx;
    }
}

@end
