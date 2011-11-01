//
//  Ennemy.h
//  TUROTUNA
//
//  Created by  on 11. 11. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEntity.h"

@interface Ennemy : AEntity
{
    NSArray *pathList;
}

@property (nonatomic, retain) NSArray *pathList;

- (id)initWithScene:(AScene*)screen path:(NSArray *)path;
- (void)update:(ccTime)dt;

@end
