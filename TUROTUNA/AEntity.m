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
    self = [super initWithFile:name rect:rect];
    scene = screen;
    return self;
}

- (id)initWithFile:(NSString *)name scene:(AScene *)screen
{
    self = [super initWithFile:name];
    scene = screen;
    return self;
}

- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect scene:(AScene *)screen
{
    self = [super initWithTexture:texture rect:rect];
    scene = screen;
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        actionList = [[NSMutableArray alloc] init];
        if (pListName)
        {
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
    /*    hitBox = CGRectMake(self.position.x - (self.contentSize.width / 2),
                            self.position.y - (self.contentSize.height / 2),
                            self.contentSize.width, self.contentSize.height);
     */
        hitBox = CGRectMake(self.position.x, self.position.y, 
                            self.contentSize.width, self.contentSize.height);
     }
    
    return self;
}

- (void)update:(ccTime)dt
{
/*    hitBox = CGRectMake(self.position.x - (self.contentSize.width / 2),
                        self.position.y - (self.contentSize.height / 2),
                        self.contentSize.width, self.contentSize.height);
*/
    hitBox = CGRectMake(self.position.x, self.position.y, 
                        self.contentSize.width, self.contentSize.height);
}

- (void)moveTo:(CGPoint)destination inDuration:(ccTime)dur
{
    id action = [CCMoveTo actionWithDuration:dur
                                    position:destination];
    [self runAction:action];
}

- (bool)contains:(CGPoint)target
{
    NSLog(@"Position : %f %f\n", self.position.x, self.position.y);
    if (target.x > hitBox.origin.x - hitBox.size.width / 2 && target.x < hitBox.origin.x + hitBox.size.width / 2
        && target.y > hitBox.origin.y - hitBox.size.height / 2 && target.y < hitBox.origin.y + hitBox.size.height / 2)
        return true;
    return false;
}

- (void)setEntityPosition:(CGPoint)position
{
    self.position = position;
/*
    hitBox = CGRectMake(self.position.x - (self.contentSize.width / 2),
                        self.position.y - (self.contentSize.height / 2),
                        self.contentSize.width, self.contentSize.height);
*/
    hitBox = CGRectMake(self.position.x, self.position.y, 
                        self.contentSize.width, self.contentSize.height);
 }

- (CGRect)getHitbox
{
    return hitBox;
}

- (void)dealloc
{
    [super dealloc];
    [actionList release];
}

@end
