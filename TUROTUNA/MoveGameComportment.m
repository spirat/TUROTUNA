//
//  MoveGameComportment.m
//  TUROTUNA
//
//  Created by  on 11. 10. 4..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoveGameComportment.h"

@implementation MoveGameComportment

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)init:(AScene *)scene player:(Player *)owner
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

- (void) touchPointMoved:(CGPoint *)point
{
    [[_owner getPath] pushNextPoint:point];
}

- (void) newTouchBegan:(CGPoint *)point
{
    if ([_owner contains:*point] && [[_owner getPath] getSize] == 0)
        *point = _owner.position;
    [[_owner getPath] pushNextPoint:point];
}

-(void) touchEnded:(UITouch *)touch atLocation:(CGPoint)location
{
}

@end
