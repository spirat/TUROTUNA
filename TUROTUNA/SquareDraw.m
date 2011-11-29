//
//  SquareDraw.m
//  TUROTUNA
//
//  Created by  on 11. 11. 24..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SquareDraw.h"

@implementation SquareDraw

- (id)initWithScene:(AScene*)scene
{
    self = [super init];
    NSLog(@"SHOULD NOT EXIST IN THE FINAL VERSION");
    if (self) {
        // Initialization code here.
    }
    [scene addChild:self z:1];
    return self;
}

-(void) setRect:(CGRect) r
{
    rect = r;
}

- (void) draw
{
    glEnable(GL_LINE_SMOOTH);
    glColor4f(1.f, 0.f, 0.f, 1.f);
    glLineWidth(5.f);
    
    CGPoint a,b,c,d;
    
    a = rect.origin;
    
    b.x = a.x + rect.size.width;
    b.y = a.y;
    
    c.x = b.x;
    c.y = b.y - rect.size.height;
    
    d.x = a.x;
    d.y = c.y;
    
    ccDrawLine(a,b);
    ccDrawLine(b,c);
    ccDrawLine(c,d);
    
}

@end
