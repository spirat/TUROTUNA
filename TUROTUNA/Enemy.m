//
//  Ennemy.m
//  TUROTUNA
//
//  Created by  on 11. 11. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

@synthesize pathList;

- (id)init
{
    self = [super init];
    if (self) {
        
        pListName = @"AnimEnemyList";
    }
    
    return self;
}

- (id)initWithScene:(AScene*)screen path:(NSArray *)path
{
    [super initWithFile:@"enemy.png" rect:CGRectMake(0, 0, 0, 0) scene:screen];
    pathList = [[NSArray alloc] initWithArray:path];
    
    return self;
}

- (void) update:(ccTime)dt
{
    [super update:dt];
}

- (void) dealloc
{
    [super dealloc];
    [pathList release];
}

@end
