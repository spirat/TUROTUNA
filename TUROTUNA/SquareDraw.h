//
//  SquareDraw.h
//  TUROTUNA
//
//  Created by  on 11. 11. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AScene.h"

@interface SquareDraw : CCNode
{
    @private
    CGRect rect;
}

- (id) initWithScene:(AScene*)scene;
- (void) setRect:(CGRect)r;
- (void) draw;

@end
