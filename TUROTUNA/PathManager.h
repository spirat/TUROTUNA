//
//  PathManager.h
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#include "AScene.h"

@interface PathManager : CCNode
{
    @private
    NSMutableArray  *_pathPoints;
    AScene          *_scene;
}

- (id)initWithScene:(AScene*)scene;
- (void)dealloc;

- (void)setScene:(AScene*)scene;
- (void)pushNextPoint:(CGPoint*)point;
- (CGPoint)peekPoint;
- (CGPoint)popPoint;
- (void)clear;
- (void)draw;

@end
