//
//  Line.m
//  TUROTUNA
//
//  Created by  on 11. 10. 11..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Line.h"

@implementation Line

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) drawLineWithOrigin:(CGPoint *)origin End:(CGPoint *)end
{
    glColor4f(1.0f, 0.0f, 0.0f, 0.0f);
    ccDrawLine(*origin, *end);
}

@end
