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
- (void)newSingleBeginning:(NSValue *)point;

- (void) addEntity:(CCSprite *) entity;
- (void) delEntity:(CCSprite *) entity;

+(CCScene *) scene;

@end
