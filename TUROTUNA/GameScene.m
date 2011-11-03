//
//  GameScene.m
//  TUROTUNA
//
//  Created by  on 11. 10. 11..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "Player.h"
#import "Level.h"
#import "ActionGameComportment.h"
#import "MoveGameComportment.h"
#import "Enemy.h"
#import "CCLabelTTF.h"

@implementation GameScene

+ (CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    GameScene *layer = [GameScene node];
    [scene addChild:layer];
    
    return scene;
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        _player = [[Player alloc] initWithFile:@"Player.png" 
                                          rect:CGRectMake(0, 0, 27, 40)
                                         scene:self];
        [_player setEntityPosition:CGPointMake(300, 300)];
        gameComportments = [[NSArray alloc] initWithObjects:[[MoveGameComportment alloc] init:self
                                                                                       player:_player],
                            [[ActionGameComportment alloc] init:self 
                                                         player:_player], nil];
        [self addEntity:_player];
        currentComportment = MOVE_COMPORTMENT;
        _bPlayerFocused = false;
        NSArray *coord = [NSArray arrayWithObjects:@"0 100 100", @"1 100 400", @"2 400 400", @"3 100 400", nil];
        Enemy *toto = [[Enemy alloc] initWithScene:self path:coord];
        [self addEntity:toto];
        [toto doSquare];
    }
    return self;
}
 
- (void) newTouchBegan:(CGPoint *)point
{
    if ([_player contains:*point])
        _bPlayerFocused = true;
    [[gameComportments objectAtIndex:currentComportment] newTouchBegan:point];
}

- (void) touchPointMoved:(CGPoint *)point
{
    if (_bPlayerFocused == true)
        [[gameComportments objectAtIndex:currentComportment] touchPointMoved:point];
}

- (void) touchEnded:(UITouch *)touch atLocation:(CGPoint)location
{
    _bPlayerFocused = false;
    [[gameComportments objectAtIndex:currentComportment] touchEnded:touch
                                                         atLocation:location];
    [self switchGameComportment];
}

- (int) getCurrentComportment
{
    return currentComportment;
}

- (void)update:(ccTime)dt
{
    [super update:dt];
    [[gameComportments objectAtIndex:currentComportment] update:dt];
}

- (void) switchGameComportment
{
    [[gameComportments objectAtIndex:currentComportment] onComportmentSwitchedOff];
    currentComportment = !currentComportment;
    [[gameComportments objectAtIndex:currentComportment] onComportmentSwitchedOn];
}

-(bool)isPlayerFocused
{
    return _bPlayerFocused;
}

@end
