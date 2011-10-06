//
//  PathManager.m
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PathManager.h"

@implementation PathManager

- (id)init
{
    self = [super init];
    if (self) {
        _pathPoints = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)pushNextPoint:(CGPoint)point
{
    CGPoint tail = [(NSValue*)[_pathPoints objectAtIndex:[_pathPoints count]] CGPointValue];
    if (point.x == tail.x && point.y == tail.y)
        return;
    [_pathPoints addObject:(id)[NSValue valueWithCGPoint:point]];
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

@end
