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
    id moveAction0 = [CCMoveTo actionWithDuration:2 position:[[pathList objectAtIndex:0] CGPointValue]];
    id moveAction1 = [CCMoveTo actionWithDuration:2 position:[[pathList objectAtIndex:1] CGPointValue]];
    id moveAction2 = [CCMoveTo actionWithDuration:2 position:[[pathList objectAtIndex:2] CGPointValue]];
    id moveAction3 = [CCMoveTo actionWithDuration:2 position:[[pathList objectAtIndex:3] CGPointValue]];
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:[CCSequence actions:moveAction0, moveAction1, moveAction2, moveAction3, nil]];
    [self runAction:repeat];
    
}

- (id)initWithScene:(AScene*)screen path:(NSArray *)path
{    
    [super initWithFile:@"animationtest.png" rect:CGRectMake(0, 0, 39, 62) scene:screen];

    pathList = [[NSMutableArray alloc] init];
    for (NSString* line in path) {
        if (line.length) {
            NSArray *entry = [line componentsSeparatedByString:@" "];
            NSValue *coord = [NSValue valueWithCGPoint:ccp([[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue])];
            [pathList addObject:coord];
            NSLog(@"%d %d", [[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue]);
            [coord release];
        }
    }
    self.position = [[pathList objectAtIndex:3] CGPointValue];
    
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
