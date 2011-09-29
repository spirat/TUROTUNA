//
//  Player.m
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@implementation Player

/*
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
*/

- (Player *)spriteWithFile:(NSString *)name rect:(CGRect)rect scene:(AScene *)screen
{
    self = [CCSprite spriteWithFile:name rect:rect];
    
    scene = screen;
    return self;
}

- (void)update
{    
}

@end
