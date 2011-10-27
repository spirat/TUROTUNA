//
//  AGameComportment.m
//  TUROTUNA
//
//  Created by  on 11. 10. 4..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AGameComportment.h"
#import "Player.h"

@implementation AGameComportment

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) init:(AScene*)scene player:(Player *)owner
{
    self = [super init];
    if (self)
    {
        _scene = scene;
        _owner = owner;
    }
    return self;
}

- (void)update:(ccTime)dt
{
}

- (void) touchPointMoved:(CGPoint *)point
{
    
}

- (void) newTouchBegan:(CGPoint *)point
{
    
}

@end
