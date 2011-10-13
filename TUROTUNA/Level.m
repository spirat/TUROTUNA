//
//  Level.m
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Obstacle.h"
#import "Level.h"

@implementation Level

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    
	Level *level = [Level node];
    [scene addChild: level];
	
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    [self LoadContent];
    return self;
}

// Init level array, each time LoadContent finishes, increment the index
// like that each time LoadContent is called a new level is loaded
// We must clear the scene first
// OR we use static stuff and instance a new Level class each time
// that way we don't have to destroy/free/.. anything ourselves
- (void)LoadContent
{
    AEntity *entity;
    int playerType;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"level1" ofType:@"map"];
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    
    for (NSString* line in lines) {
        if (line.length) {
            NSArray *entry = [line componentsSeparatedByString:@" "];
            playerType = [[entry objectAtIndex:0] intValue];
            entity = NULL;
            
            if (playerType == PLAYER_TYPE) {
                entity = [[Player alloc] initWithFile:@"Player.png" rect:CGRectMake(0, 0, 27, 40)];
                entity.position = ccp([[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue]);
            }
            else if (playerType == TARGET_TYPE) {
            }
            else if (playerType == ENEMY_TYPE) {
            }
            else if (playerType == OBSTACLE_TYPE) {
                entity = [[Obstacle alloc] initWithFile:@"Obstacle.png" rect:CGRectMake(0, 0, 27, 40)];
                entity.position = ccp([[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue]);
            }
            
            if (entity != NULL) {
                [self addEntity:entity];
            }
        }
    }
}

@end
