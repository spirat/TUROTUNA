//
//  Line.h
//  TUROTUNA
//
//  Created by  on 11. 10. 11..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface Line : CCLayer
{
}

- (void) drawLineWithOrigin:(CGPoint*)origin End:(CGPoint*)end;

@end
