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

- (void) touchPointMoved:(CGPoint *)point
{
    if ([_scene isPlayerFocused])
        [[_owner getPath] pushNextPoint:point];
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
