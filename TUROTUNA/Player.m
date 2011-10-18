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
        playerPath = [[PathManager alloc] initWithScene:NULL];

        return self;
    }
    
    return self;
}

- (void) update:(ccTime)dt
{
    
}

-(void) drawEntity
{
    [playerPath drawPath];
}

- (PathManager*)getPath
{
    return playerPath;
}

- (void) dealloc
{
    [playerPath release];
    [super dealloc];
}

@end
