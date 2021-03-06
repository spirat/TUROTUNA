//
//  AEntity.h
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AScene.h"

#define CGPOINTEQUALS(lh, rh) lh.x == rh.x && lh.y == rh.y

@interface AEntity : CCSprite
{
    float depth;
    AScene *scene;
    NSString *pListName;
    NSMutableArray *actionList;
    CGRect hitBox;
    bool killable;
    int life;
    int attack;
	bool isCollisionable;
}

@property float depth;
@property int life;
@property bool killable;
@property bool isCollisionable;
@property int attack;
@property (nonatomic) CGRect hitBox;
@property (nonatomic, retain) NSMutableArray *actionList;

- (id)initWithFile:(NSString *)name scene:(AScene *)screen;
- (id)initWithFile:(NSString *)name rect:(CGRect)rect scene:(AScene *)screen;
- (id)initWithFile:(NSString *)filename scene:(AScene*)screen;
- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect scene:(AScene *)screen;

- (void)update:(ccTime)dt;
- (void)moveTo:(CGPoint)destination inDuration:(ccTime)dur;
- (void)resultCollision:(AEntity *)entity;

- (bool)contains:(CGPoint)target;
- (void)setEntityPosition:(CGPoint)position;

- (CGRect)getHitbox;

@end
