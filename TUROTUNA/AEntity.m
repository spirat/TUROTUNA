//
//  AEntity.m
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AEntity.h"

@implementation AEntity

@synthesize hitBox, actionList;

- (id)initWithFile:(NSString *)name rect:(CGRect)rect scene:(AScene *)screen
{
    [super initWithFile:name rect:rect];
    scene = screen;
    return self;
}

- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect scene:(AScene *)screen
{
    [super initWithTexture:texture rect:rect];
    scene = screen;
    return self;
}

- (id)init
{
    [super init];
    if (self) {
        actionList = [[NSMutableArray alloc] init];
        NSString *pListPath = [[NSBundle mainBundle] pathForResource:pListName ofType:@"plist"];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:pListPath];
        
        for (NSString *key in dictionary)
        {
            NSDictionary *info = [dictionary objectForKey:key];
            CCSpriteBatchNode *node = [CCSpriteBatchNode batchNodeWithFile:[info objectForKey:@"file"]];
            
            if (node != nil)
            {
                NSMutableArray *tmp = [[NSMutableArray alloc] init];
                NSArray *animList = [info objectForKey:@"rectList"];
                for (int i = 0; i < [animList count]; i++)
                {
                    NSDictionary *animRect = [animList objectAtIndex:i];
                    [tmp addObject:[CCSpriteFrame frameWithTexture:node.texture rect:CGRectMake(                                                                                                [[animRect objectForKey:@"x"] intValue],[[animRect objectForKey:@"y"] intValue], [[animRect objectForKey:@"width"] intValue], [[animRect objectForKey:@"height"] intValue])]];
                }
                
                CCAnimation *animation = [CCAnimation animationWithFrames:tmp delay:0.1];
                CCAnimate *anim = [CCAnimate actionWithAnimation:animation];
                
                CCRepeatForever *action = [CCRepeatForever actionWithAction:anim];
                [actionList addObject:action];
            }
        }
    }
    
    return self;
}

- (void)update:(ccTime)dt
{
    hitBox = CGRectMake(self.position.x - (self.contentSize.width / 2),
                        self.position.y - (self.contentSize.height / 2),
                        self.contentSize.width, self.contentSize.height);
}

- (void)dealloc
{
    [super dealloc];
    [actionList release];
}

@end
