//
//  Shuriken.m
//  TUROTUNA
//
//  Created by  on 11. 11. 15..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Obstacle.h"
#import "Enemy.h"
#import "Shuriken.h"
#import "Neutral.h"

@implementation Shuriken

-(void)spriteMoveFinished:(id)sender {
    [scene delEntity:self];
}

- (void)TranslateTo:(ccTime)dt
{    
    self.position = CGPointMake(self.position.x + (direction.x * speed * dt)
                               ,self.position.y + (direction.y * speed * dt));
}

- (id)initWithScene:(AScene*)screen startingPos:(CGPoint)start endingPos:(CGPoint)end
{
    self = [super initWithFile:@"shuriken.png" scene:screen];
    winSize = [[CCDirector sharedDirector] winSize];

    self.position = start;
    self.scale = 1.5;
    self.depth = 1;
    
    speed = 600;
    direction = ccpNormalize(ccp(end.x - start.x, end.y - start.y));
    killable = NO;
    attack = 10;
    life = 10;

    [self runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:0.000005 angle:30]]];
    

    return self;
}

- (void)update:(ccTime)dt
{
    [super update:dt];
    [self TranslateTo:dt];
    
    if (self.position.x <= 0 || self.position.x >= winSize.width || self.position.y <= 0 || self.position.y >= winSize.height)
        [scene delEntity:self];
}

- (void)resultCollision:(AEntity *)entity
{
    if ([entity isKindOfClass:[Enemy class]])
        if (killable)
            life -= entity.attack;
    
    if ([entity isKindOfClass:[Obstacle class]])
    {
        if (killable)
            [scene delEntity:self];
        else
        {
            speed = 0;
            [self stopAllActions];
        }
    }
}

@end