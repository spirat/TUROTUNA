//
//  Player.m
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "ActionGameComportment.h"
#import "MoveGameComportment.h"

@implementation Player


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (Player *)spriteWithFile:(NSString *)name rect:(CGRect)rect scene:(AScene *)screen
{
    self = [CCSprite spriteWithFile:name rect:rect];
    
    scene = screen;
    gameComportments = [[NSArray alloc] initWithObjects:[[MoveGameComportment alloc] init:(AScene*)scene
                                                                                   player:(Player*)self],
                                                        [[ActionGameComportment alloc] init:(AScene *)scene
                                                                                     player:(Player *)self], 
                                                        nil];
    currentComportment = MOVE_COMPORTMENT;
    return self;
}

- (void)update
{
    [[gameComportments objectAtIndex:currentComportment] update];
}

- (void) switchGameComportment
{
    currentComportment = !currentComportment;
}

@end
