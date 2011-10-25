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
    pListName = @"AnimPlayerList";
    self = [super init];
    if (self) {
        playerPath = [[PathManager alloc] init];
    }
    
    return self;
}

- (id)initWithFile:(NSString *)filename rect:(CGRect)rect scene:(AScene*)screen
{
    self = [super initWithFile:filename rect:rect scene:screen];
    if (self)
    {
        playerPath = [[PathManager alloc]initWithScene:scene];
        [self setPosition:CGPointMake(0, 0)];
    }
    return self;
}

- (void) update:(ccTime)dt
{
    
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
