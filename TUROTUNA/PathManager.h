//
//  PathManager.h
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "AScene.h"
#include "Line.h"

@interface PathManager : NSObject
{
    @private
    NSMutableArray  *_pathPoints;
    Line            *_line;
    AScene          *_scene;
}

- (id)initWithScene:(AScene*)scene;
- (void)dealloc;

- (void)pushNextPoint:(CGPoint*)point;
- (CGPoint)peekPoint;
- (CGPoint)popPoint;
- (void)drawPath;

@end
