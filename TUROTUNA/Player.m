//
//  Player.m
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "AEntity.h"

@implementation Player
/*
- (id)initWithFile:(NSString *)name rect:(CGRect)rect scene:(AScene *)screen
{
    [super initWithFile:name rect:rect scene:screen];
    return self;
}
*/

- (id)init
{
    self = [super init];
    if (self) {
        dieTime = 10;
    }
    
    return self;
}

- (void)update:(ccTime)dt
{    
    [super update:dt];
    dieTime -= dt;
    if (dieTime <= 0)
        [scene delEntity:self];
}

@end
