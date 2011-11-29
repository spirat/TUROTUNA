//
//  Effect.h
//  TUROTUNA
//
//  Created by  on 11. 11. 24..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AEntity.h"
#import "AScene.h"

@interface Effect : AEntity
{
}

- (id)initWithScene:(AScene*)screen effetName:(NSString *)name position:(CGPoint)pos;

@end
