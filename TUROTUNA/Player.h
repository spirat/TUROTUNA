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
#import "PathManager.h"



@interface Player : AEntity 
{
    @private
    float dieTime;
    PathManager *playerPath;
}

- (PathManager*) getPath;

- (void)update:(ccTime)dt;

@end
