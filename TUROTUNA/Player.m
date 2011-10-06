//
//  Player.m
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "AEntity.h"
#import "ActionGameComportment.h"
#import "MoveGameComportment.h"

@implementation Player


- (id)init
{
    self = [super init];
    if (self) {
        dieTime = 10;
        
        gameComportments = [[NSArray alloc] initWithObjects:[[MoveGameComportment alloc] init:scene player:self],                                                      [[ActionGameComportment alloc] init:scene player:self], nil];
        currentComportment = MOVE_COMPORTMENT;
        return self;
    }
    
    return self;
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
