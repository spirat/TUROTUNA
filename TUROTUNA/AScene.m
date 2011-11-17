//
//  AScene.m
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AScene.h"
#import "AEntity.h"

@implementation AScene

@synthesize entityList;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    
	AScene *layer = [AScene node];
    [scene addChild: layer];
	
	return scene;
}

- (id)init
{
    self = [super init];
    self = [super initWithColor:ccc4(255, 255, 255, 255)];
    if (self) {
        // Initialization code here.
        entityList = [[NSMutableArray alloc] init];
        delEntityList = [[NSMutableArray alloc] init];
        addEntityList = [[NSMutableArray alloc] init];
        self.isTouchEnabled = true;
        [self schedule:@selector(update:)];    
    }
    
    return self;
}

//   [self removeChild:sprite cleanup:YES];

- (void)touchPointMoved:(CGPoint *)point
{
}

- (void)newTouchBegan:(CGPoint *)point
{
}

- (void)touchEnded:(UITouch *)touch atLocation:(CGPoint)location
{
}

- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
	
    [self touchPointMoved:&location];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    // Set up initial location of projectile
    // CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    //AEntity *projectile = [[AEntity alloc] spriteWithFile:@"Player.png"
    //                                       rect:CGRectMake(0, 0, 27, 40) scene:self];
    NSLog(@"New touch began : %f %f\n", location.x, location.y);
    [self newTouchBegan:&location];
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    [self touchEnded:touch atLocation:location];
}


-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self ccTouchesEnded:touches withEvent:event];
}

- (void)addEntity:(AEntity *)entity
{
    [addEntityList addObject:entity];
}

- (void)delEntity:(AEntity *)entity
{
    [delEntityList addObject:entity];
}

- (void)update:(ccTime)dt
{
    
    for(AEntity *toAdd in addEntityList)
    {
        [entityList addObject:toAdd];
        [self addChild:toAdd z:toAdd.depth];
    }
   [addEntityList removeAllObjects];
    
        
    for(AEntity *toUpdate in entityList)
    {
        [toUpdate update:dt];
    }
    
    for(AEntity *toDel in delEntityList)
    {
        [entityList removeObject:toDel];
        [self removeChild:toDel cleanup:YES];
    }
    [delEntityList removeAllObjects];
}

- (NSMutableArray *) getEntities
{
    return entityList;
}

- (void)dealloc
{
    [super dealloc];
    [entityList release];
    [delEntityList release];
    [addEntityList release];
}

@end
