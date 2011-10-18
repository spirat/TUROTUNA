//
//  AEntity.m
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AEntity.h"

@implementation AEntity

@synthesize hitBox;

- (id)initWithScene:(AScene *)screen
{
    [super init];
    scene = screen;
    return self;
}

- (id)initWithFile:(NSString *)name rect:(CGRect)rect scene:(AScene *)screen
{
    [super initWithFile:name rect:rect];
    scene = screen;
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)update:(ccTime)dt
{
    hitBox = CGRectMake(self.position.x - (self.contentSize.width / 2),
                        self.position.y - (self.contentSize.height / 2),
                        self.contentSize.width, self.contentSize.height);
}

@end
