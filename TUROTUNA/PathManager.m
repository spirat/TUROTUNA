//
//  PathManager.m
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PathManager.h"
#import "Player.h"

@implementation PathManager

- (id)init
{
    self = [super init];
    if (self) {
        _scene = NULL;
        _pathPoints = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id) initWithScene:(AScene*)scene Player:(Player*)owner
{
    self = [super init];
    if (self)
    {
        _scene = scene;
        _owner = owner;
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


- (void)setScene:(AScene *)scene
{
    if (_scene)
        [_scene removeChild:self 
                    cleanup:false];
    _scene = scene;
    if (_scene)
        [_scene addChild:self];
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

- (int) getSize
{
    return [_pathPoints count];
}

- (void) clear
{
    [_pathPoints removeAllObjects];
}

- (void) draw
{
    int idx = 1;
    int end = [_pathPoints count];
    
    if (end < 2)
        return;
    
    glEnable(GL_LINE_SMOOTH);
    glColor4f(1.f, 0.f, 0.f, 1.f);
    glLineWidth(5.f);
    
    CGPoint next = [(NSValue*)[_pathPoints objectAtIndex:0] CGPointValue];
    CGPoint beg;

    ccDrawLine(_owner.position, next);
    
    while (idx < end)
    {
        beg = next;
        next = [(NSValue*)[_pathPoints objectAtIndex:idx] CGPointValue];
        ccDrawLine(beg, next);
        ++idx;
    }
}

@end
