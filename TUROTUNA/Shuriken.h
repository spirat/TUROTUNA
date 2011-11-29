//
//  Shuriken.h
//  TUROTUNA
//
//  Created by  on 11. 11. 15..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEntity.h"

@interface Shuriken : AEntity
{
    CGPoint direction;
    float timeDead;
    float speed;
    CGSize winSize;
    
}

- (id)initWithScene:(AScene*)screen startingPos:(CGPoint)start endingPos:(CGPoint)end;



@end
