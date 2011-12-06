//
//  AEntity.m
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Neutral.h"
#import "AEntity.h"
#import "Shuriken.h"

@implementation AEntity

@synthesize hitBox, actionList, depth, life, attack, killable, isCollisionable;

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

- (void)deleteSelf
{
    [scene delEntity:self];
}

- (id)init
{
    self = [super init];
    if (self) {
		isCollisionable = TRUE;
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
                
                    bool loop = [[info objectForKey:@"loop"] boolValue];
                    if (loop == YES)
                    {               
                        CCRepeatForever *action = [CCRepeatForever actionWithAction:anim];
                        [actionList addObject:action];
                    }
                    else
                    {   
                        bool autodel = [[info objectForKey:@"autodel"] boolValue];
                        if (autodel == YES)
                            [actionList addObject:[CCSequence actions:anim, [CCCallFunc actionWithTarget:self selector:@selector(deleteSelf)], nil]];
                        else
                            [actionList addObject:anim];
                        
                    }
                }
            }
        }
        //self.position : bottom left of hitbox but center of sprite
        hitBox = CGRectMake(self.position.x - (self.contentSize.width / 2),
                            self.position.y - (self.contentSize.height / 2),
                            self.contentSize.width, self.contentSize.height);
        
       // hitBox = CGRectMake(self.position.x, self.position.y, 
       //                     self.contentSize.width, self.contentSize.height);
     }
    
    return self;
}

- (bool) checkCollisionBetween:(AEntity*)e1 and:(AEntity*)e2
{
        BOOL isCollision = NO;
        CGRect intersection = CGRectIntersection([e1 hitBox], [e2 hitBox]);

        if (!CGRectIsEmpty(intersection))
        {
            unsigned int x = intersection.origin.x;
            unsigned int y = intersection.origin.y;
            unsigned int w = intersection.size.width;
            unsigned int h = intersection.size.height;
            unsigned int numPixels = w * h;
            
            [scene.rt beginWithClear:0 g:0 b:0 a:0];

            glColorMask(1, 0, 0, 1);
            [e1 visit];
            glColorMask(0, 1, 0, 1);
            [e2 visit];
            glColorMask(1, 1, 1, 1);

            ccColor4B *buffer = malloc( sizeof(ccColor4B) * numPixels );
            glReadPixels(x, y, w, h, GL_RGBA, GL_UNSIGNED_BYTE, buffer);

            [scene.rt end];

            unsigned int step = 1;
            for(unsigned int i=0; i<numPixels; i+=step)
            {
                ccColor4B color = buffer[i];
                
                if (color.r > 0 && color.g > 0)
                {
                    isCollision = YES;
                    break;
                }
            }
            
            free(buffer);
        }
        
        return isCollision;
}

- (void)update:(ccTime)dt
{
    hitBox = CGRectMake(self.position.x - (self.contentSize.width / 2),
                        self.position.y - (self.contentSize.height / 2),
                        self.contentSize.width, self.contentSize.height);
//    hitBox = CGRectMake(self.position.x, self.position.y, 
//                        self.contentSize.width, self.contentSize.height);

	if (isCollisionable)
	{
	
    int entityCount = [[scene getEntities] count];
	
    for (int i = 0; i < entityCount; i++)
    {
        AEntity *e = [[scene getEntities] objectAtIndex:i];
        
        //if ([e isKindOfClass:[Shuriken class]])
             //{
                 if (![e isKindOfClass:[Neutral class]] &&
                     e != self && e.isCollisionable)
                 {
                     if (//CGRectIntersectsRect(hitBox, e.hitBox)
                         [self checkCollisionBetween:self and:e])
                     {
                         [self resultCollision:e];
                         [e resultCollision:self];
                     }
                 }
             //}
    }
	}
    
    if (killable && life <= 0)
        [scene delEntity:self];
}

- (void)moveTo:(CGPoint)destination inDuration:(ccTime)dur
{
    id action = [CCMoveTo actionWithDuration:dur
                                    position:destination];
    [self runAction:action];
}

- (void)resultCollision:(AEntity *)entity
{
}

- (bool)contains:(CGPoint)target
{
    NSLog(@"Position : %f %f\n", self.position.x, self.position.y);
    if (target.x > hitBox.origin.x  && target.x < hitBox.origin.x + hitBox.size.width
        && target.y > hitBox.origin.y && target.y < hitBox.origin.y + hitBox.size.height)
        return true;
    return false;
}

- (void)setEntityPosition:(CGPoint)position
{
    self.position = position;

    hitBox = CGRectMake(self.position.x - (self.contentSize.width / 2),
                        self.position.y - (self.contentSize.height / 2),
                        self.contentSize.width, self.contentSize.height);

    /*hitBox = CGRectMake(self.position.x, self.position.y, 
                        self.contentSize.width, self.contentSize.height);*/
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
