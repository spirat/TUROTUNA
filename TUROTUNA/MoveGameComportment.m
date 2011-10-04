//
//  MoveGameComportment.m
//  TUROTUNA
//
//  Created by  on 11. 10. 4..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoveGameComportment.h"

@implementation MoveGameComportment

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
    self = [super init:scene player:owner];
    if (self)
    {
    }
    return self;
}

- (void) update
{
}

@end
