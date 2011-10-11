//
//  Level.m
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level.h"

@implementation Level

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    
	Level *level = [Level node];
    [scene addChild: level];
	
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    [self LoadContent];
    return self;
}

- (void)LoadContent
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"level1.map" ofType:@"txt"];
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    for (NSString* line in lines) {
        if (line.length) {
            NSLog(@"line: %@", line);
        }
    }
}

@end
