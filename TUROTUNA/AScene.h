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
}

@property (nonatomic, retain) NSMutableArray *entityList;

/* Must be overridden in each scene */
- (void)touchPointMoved:(CGPoint *)point;
- (void)newTouchBegan:(CGPoint *)point;
- (void)touchEnded:(UITouch*)touch atLocation:(CGPoint)location;

- (void)multipleTouchesBegan:(NSSet *)touches;
- (void)multipleTouchesMoved:(NSSet *)touches;

- (void)addEntity:(CCSprite *) entity;
- (void)delEntity:(CCSprite *) entity;
- (void)update:(ccTime) dt;

- (NSMutableArray *) getEntities;

+(CCScene *) scene;

@end
