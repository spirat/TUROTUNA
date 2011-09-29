//
//  AScene.m
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AScene.h"

@implementation AScene

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
    if (self) {
        // Initialization code here.
        entityList = [[NSMutableArray alloc] init];
        delEntityList = [[NSMutableArray alloc] init];
        addEntityList = [[NSMutableArray alloc] init];
        
        [self schedule:@selector(update:)];    
    }
    
    return self;
}

//   [self removeChild:sprite cleanup:YES];

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
        [self addChild:toAdd];
    }
    //[addEntityList removeAllObjects];
    
        
    for(AEntity *toUpdate in entityList)
    {
        [toUpdate update];
    }
    
    for(AEntity *toDel in delEntityList)
    {
        [entityList removeObject:toDel];
        [self removeChild:toDel cleanup:YES];
    }
    [delEntityList removeAllObjects];
}

- (void)dealloc
{
    [super dealloc];
    [entityList release];
    [delEntityList release];
    [addEntityList release];
}

@end
