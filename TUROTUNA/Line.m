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
    glEnable(GL_LINE_SMOOTH);
    glColor4f(1.0f, 0.0f, 0.0f, 0.0f);
    glLineWidth(6.0f);
    ccDrawLine(*origin, *end);
}

@end
