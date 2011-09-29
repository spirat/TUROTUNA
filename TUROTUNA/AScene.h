//
//  AScene.h
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AEntity.h"

@interface AScene : CCLayerColor
{
    NSMutableArray *entityList;
    NSMutableArray *addEntityList;
    NSMutableArray *delEntityList;
}

- (void) addEntity:(CCSprite *) entity;
- (void) delEntity:(CCSprite *) entity;

+(CCScene *) scene;

@end
