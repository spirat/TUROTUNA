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
    self = [super initWithFile:[NSString stringWithFormat:@"%@.png", name] scene:screen];
    
    self.depth = 1;
    self.position = pos;
     
    return self;
}

@end
