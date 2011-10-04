//
//  AEntity.h
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AScene.h"

@interface AEntity : CCSprite
{
    AScene *scene;
}

@property (nonatomic) CGRect hitBox;

- (id)initWithFile:(NSString *)name rect:(CGRect)rect scene:(AScene *)screen;

- (void)update:(ccTime)dt;

@end
