//
//  Shuriken.m
//  TUROTUNA
//
//  Created by  on 11. 11. 15..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Shuriken.h"

@implementation Shuriken

-(void)spriteMoveFinished:(id)sender {
    [scene delEntity:self];
}

- (void)TranslateTo
{
    
    self.position = CGPointMake(self.position.x + (direction.x * speed)
                               ,self.position.y + (direction.y * speed));
}

- (id)initWithScene:(AScene*)screen startingPos:(CGPoint)start endingPos:(CGPoint)end
{
    self = [super initWithFile:@"shuriken.png" scene:screen];
    self.position = start;
    self.scale = 1.5;
    self.depth = 1;
    
    speed = 26;
    direction = ccpNormalize(ccp(end.x - start.x, end.y - start.y));

    [self runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:0.0005 angle:60]]];
    
    return self;
}

- (void)update:(ccTime)dt
{
    [self TranslateTo];
}

@end