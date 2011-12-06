//
//  Effect.m
//  TUROTUNA
//
//  Created by  on 11. 11. 24..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Effect.h"

@implementation Effect

- (id)initWithScene:(AScene*)screen effetName:(NSString *)name position:(CGPoint)pos
{
    pListName = [NSString stringWithFormat:@"Anim%@List", name];
    self = [super initWithFile:@"1x1pixel.png" scene:screen];
    self.depth = 1;
    self.position = pos;
	self.isCollisionable = FALSE;
    
    [self runAction:[[self actionList] objectAtIndex:0]];
    return self;
}

- (void)update:(ccTime)dt
{
    [super update:dt];
}



@end
