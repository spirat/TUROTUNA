//
//  ActionGameComportment.h
//  TUROTUNA
//
//  Created by  on 11. 10. 4..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AGameComportment.h"

@interface ActionGameComportment : AGameComportment
{
}

- (id)init:(GameScene *)scene player:(Player *)owner;
- (void)update:(ccTime)dt;

- (void) touchPointMoved:(CGPoint *)point;
- (void) newTouchBegan:(CGPoint *)point;
- (void) touchEnded:(UITouch *)touch atLocation:(CGPoint)location;

@end
