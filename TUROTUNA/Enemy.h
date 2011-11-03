//
//  Ennemy.h
//  TUROTUNA
//
//  Created by  on 11. 11. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEntity.h"

@interface Enemy : AEntity
{
    NSMutableArray *pathList;
}

@property (nonatomic, retain) NSMutableArray *pathList;

- (id)initWithScene:(AScene*)screen path:(NSArray *)path;
- (void)update:(ccTime)dt;
- (void)doSquare;

@end
