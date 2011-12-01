//
//  Ennemy.m
//  TUROTUNA
//
//  Created by  on 11. 11. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "Shuriken.h"

@implementation Enemy

@synthesize pathList;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.depth = 1;
        killable = YES;
        life = 10;
        attack = 100;
        //pListName = @"AnimEnemyList";
    }
    
    return self;
}

- (void)saveRotation:(NSNumber *)rot
{
    rotation = [rot intValue];
}

- (void)doSquare
{    
    NSMutableArray *actions = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSArray *pos in pathList)
    {
        NSInteger rotate = [[pos objectAtIndex:2] intValue];
        [actions addObject:[CCRotateTo actionWithDuration:0 angle:rotate]];

        [actions addObject:[CCCallFuncO actionWithTarget:self selector:@selector(saveRotation:) object:[NSNumber numberWithInt:rotate]]];
        [actions addObject:[CCMoveTo actionWithDuration:2 position:ccp([[pos objectAtIndex:0] intValue], [[pos objectAtIndex:1] intValue])]];
    }
    
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:[CCSequence actionsWithArray:actions]];
    [self runAction:repeat];
    
}

- (id)initWithScene:(AScene*)screen path:(NSArray *)path
{    
    self = [super initWithFile:@"animationtest.png" rect:CGRectMake(0, 0, 39, 62) scene:screen];

    pathList = [[NSArray alloc] initWithArray:path];
    NSArray *tmpPos = [pathList objectAtIndex:[pathList count] - 1];
    self.position = ccp([[tmpPos objectAtIndex:0] intValue], [[tmpPos objectAtIndex:1] intValue]);
 
    [self doSquare];

    return self;
}

- (void) update:(ccTime)dt
{
    [super update:dt];
}

- (void)resultCollision:(AEntity *)entity
{
    if ([entity isKindOfClass:[Shuriken class]])
        life -= entity.attack;
}

- (void) dealloc
{
    [super dealloc];
    [pathList release];
}

@end
