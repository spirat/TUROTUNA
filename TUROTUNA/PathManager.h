//
//  PathManager.h
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathManager : NSObject
{
    @private
    NSMutableArray  *_pathPoints;
}

- (void)pushNextPoint:(CGPoint)point;
- (CGPoint)peekPoint;
- (CGPoint)popPoint;


@end
