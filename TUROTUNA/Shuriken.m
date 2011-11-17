//
//  Shuriken.m
//  TUROTUNA
//
//  Created by  on 11. 11. 15..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Shuriken.h"

@implementation Shuriken

- (id)initWithScene:(AScene*)screen startingPos:(CGPoint)start endingPos:(CGPoint)end
{
    self = [super initWithFile:@"axe.png" scene:screen];
    self.position = start;
    self.scale = 1;
    self.depth = 1;
    [self moveTo:end inDuration:1.0f];
    [self runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:0.025 angle:30]]];
    
    return self;
}

@end