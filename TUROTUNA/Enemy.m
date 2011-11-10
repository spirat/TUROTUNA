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
        
        //pListName = @"AnimEnemyList";
    }
    
    return self;
}

- (void)doSquare
{    
    NSMutableArray *actions = [[[NSMutableArray alloc] init] autorelease];
    
    for (int i = 0; i < [pathList count]; i++)
        [actions addObject:[CCMoveTo actionWithDuration:2 position:[[pathList objectAtIndex:i] CGPointValue]]];
    
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:[CCSequence actionsWithArray:actions]];
    [self runAction:repeat];
    
}

- (id)initWithScene:(AScene*)screen path:(NSArray *)path
{    
    self = [super initWithFile:@"animationtest.png" rect:CGRectMake(0, 0, 39, 62) scene:screen];

    pathList = [[NSArray alloc] initWithArray:path];
    /*
    for (NSString* line in path) {
        if (line.length) {
            NSArray *entry = [line componentsSeparatedByString:@" "];

            NSValue *coord = [NSValue valueWithCGPoint:ccp([[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue])];
            [pathList addObject:coord];
            [coord release];
        }
    }
    */
    self.position = [[pathList objectAtIndex:0] CGPointValue];
    
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
