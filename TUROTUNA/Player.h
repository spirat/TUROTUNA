//
//  Player.h
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AEntity.h"
#import "AScene.h"

@interface Player : AEntity
{
    AScene *scene;
}

- (Player *)spriteWithFile:(NSString *)name rect:(CGRect)rect scene:(AScene *)scene;


@end
