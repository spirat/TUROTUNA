//
//  AScene.h
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface AScene : CCLayerColor
{
    NSMutableArray *entityList;
    NSMutableArray *addEntityList;
    NSMutableArray *delEntityList;
    CCRenderTexture *rt;
}

@property (nonatomic, retain) CCRenderTexture *rt;
@property (nonatomic, retain) NSMutableArray *entityList;

/* Must be overridden in each scene */
- (void)touchPointMoved:(CGPoint *)point;
- (void)newTouchBegan:(CGPoint *)point;
- (void)touchEnded:(UITouch*)touch atLocation:(CGPoint)location;

- (void)addEntity:(CCSprite *) entity;
- (void)delEntity:(CCSprite *) entity;
- (void)update:(ccTime) dt;

- (NSMutableArray *) getEntities;

+(CCScene *) scene;

@end
