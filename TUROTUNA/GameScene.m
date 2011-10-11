//
//  GameScene.m
//  TUROTUNA
//
//  Created by  on 11. 10. 11..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (id) init
{
    self = [super init];
    
    if (self)
    {
        _player = [[Player alloc] init];
        gameComportments = [[NSArray alloc] initWithObjects:[[MoveGameComportment alloc] init:self player:_player],                                                      [[ActionGameComportment alloc] init:self player:_player], nil];
        currentComportment = MOVE_COMPORTMENT;
    }
    return self;
}

- (void) newTouchBegan:(CGPoint *)point
{
    [[gameComportments objectAtIndex:currentComportment] newTouchBegan:point];
}

- (void) touchPointMoved:(CGPoint *)point
{
    [[gameComportments objectAtIndex:currentComportment] touchPointMoved:point];
}

- (int) getCurrentComportment
{
    return currentComportment;
}

- (void)update:(ccTime)dt
{
    [[gameComportments objectAtIndex:currentComportment] update:dt];
}

- (void) switchGameComportment
{
    currentComportment = !currentComportment;
}

@end
