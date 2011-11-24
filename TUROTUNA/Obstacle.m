//

//  Obstacle.m
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Obstacle.h"

@implementation Obstacle

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithFile:(NSString *)filename scene:(AScene *)screen
{
    self = [super initWithFile:filename scene:scene];
    
    life = 1;
    killable = NO;
    attack = 0;
    
    return self;
}

- (void) checkPosition
{
    int x = self.position.x;
    int y = self.position.y;
}

- (void) update:(ccTime)dt
{
    [super update:dt];
    [self checkPosition];
}

@end
