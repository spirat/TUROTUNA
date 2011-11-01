//
//  Ennemy.m
//  TUROTUNA
//
//  Created by  on 11. 11. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ennemy.h"

@implementation Ennemy

@synthesize pathList;

- (id)init
{
    self = [super init];
    if (self) {
        
        pListName = @"AnimEnnemyList";
    }
    
    return self;
}

- (id)initWithScene:(AScene*)screen path:(NSArray *)path
{
    [super initWithFile:@"ennemy.png" rect:CGRectMake(0, 0, 0, 0) scene:screen];
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
