//
//  ActionGameComportment.m
//  TUROTUNA
//
//  Created by  on 11. 10. 4..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActionGameComportment.h"
#import "Player.h"
#import "PathManager.h"

@implementation ActionGameComportment

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) init:(AScene *)scene player:(Player *)owner
{
    self = [super init:(AScene*) scene
                player:(Player*) owner];
    if (self)
    {
        
    }
    return self;
}

- (void)update:(ccTime)dt
{
    if ([[_owner getPath] getSize] != 0)
    {
        CGPoint current = [_owner getPosition];
        CGPoint next = [[_owner getPath] peekPoint];
        if (CGPOINTEQUALS(current, next))
        {
            [_owner moveTo:next inDuration:10];
            [[_owner getPath] popPoint];
        }
    }
}

- (void) touchPointMoved:(CGPoint *)point
{
    
}

- (void) newTouchBegan:(CGPoint *)point
{
    
}

@end
