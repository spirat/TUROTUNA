//
//  PathManager.h
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AScene.h"
#import "Player.h"

@class Player;

@interface PathManager : CCNode
{
    @private
    NSMutableArray  *_pathPoints;
    AScene          *_scene;
    Player          *_owner;
}

- (id)initWithScene:(AScene*)scene Player:(Player*)owner;
- (void)dealloc;

- (void)setScene:(AScene*)scene;
- (void)pushNextPoint:(CGPoint*)point;
- (CGPoint)lastPointAdded;
- (CGPoint)peekPoint;
- (CGPoint)popPoint;
- (int)getSize;
- (void)clear;
- (void)draw;

@end
