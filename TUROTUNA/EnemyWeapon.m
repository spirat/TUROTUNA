//
//  Shuriken.m
//  TUROTUNA
//
//  Created by  on 11. 11. 15..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Obstacle.h"
#import "Enemy.h"
#import "EnemyWeapon.h"
#import "Neutral.h"
#import "Effect.h"
#import "Player.h"

@implementation EnemyWeapon

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
    self = [super initWithFile:@"axe.png" scene:screen];
    winSize = [[CCDirector sharedDirector] winSize];

    self.position = start;
    self.scale = 1.5;
    self.depth = 1;
    
    speed = 600;
    timeDead = 2.0f;
    direction = ccpNormalize(ccp(end.x - start.x, end.y - start.y));
    killable = NO;
    attack = 1000;
    life = 1000;

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
    if ([entity isKindOfClass:[Player class]])
    {
        speed = 0;
        [self stopAllActions];
    }
}

@end