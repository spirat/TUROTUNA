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
        _player.position = CGPointMake(50, 50);
        
        gameComportments = [[NSArray alloc] initWithObjects:[[MoveGameComportment alloc] init:self
                                                                                       player:_player],
                            [[ActionGameComportment alloc] init:self 
                                                         player:_player], nil];
        currentComportment = MOVE_COMPORTMENT;
         
        [self addEntity:_player];
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
    [super update:dt];
    [[gameComportments objectAtIndex:currentComportment] update:dt];
}

- (void) switchGameComportment
{
    currentComportment = !currentComportment;
}


@end
