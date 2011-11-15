//
//  Level.m
//  TUROTUNA
//
//  Created by  on 11. 10. 6..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Obstacle.h"
#import "Neutral.h"
#import "Level.h"
#import "SplashScreen.h"

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
    //[self schedule:@selector(onEnd:) interval:5];
    return self;
}

// 64 x 64
// http://www.cocos2d-iphone.org/archives/61 RGBA8888 pixel format
- (void)LoadCollisionBox
{
    UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
    CGImageRef imageRef = [backgroundImage CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    int max = width * height * 4;
    uint byteIndex = 0;
    while (byteIndex < max)
    {
        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += 4;

        // Isoler un carre a chaque tour
        UIColor *bgPixColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        
        // foreach obstacle a la con
        // recuperer rawData
        // foreach byte
        // recuperer Uicolor
        // comparer avec bgPixColor (utiliser UIColor.CGColor.CGColorEqualToColor
    }
    free(rawData);
}

// Init level array, each time LoadContent finishes, increment the index
// like that each time LoadContent is called a new level is loaded
// We must clear the scene first
// OR we use static stuff and instance a new Level class each time
// that way we don't have to destroy/free/.. anything ourselves
- (void)LoadContentMap
{
    AEntity *entity;
    int type;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"level1" ofType:@"map"];
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];

    //[self LoadCollisionBox];
    for (NSString* line in lines) {
        if (line.length) {
            NSArray *entry = [line componentsSeparatedByString:@" "];
            type = [[entry objectAtIndex:0] intValue];
            entity = NULL;
            
            if (type == PLAYER_TYPE) {
                entity = [[Player alloc] initWithFile:@"Player.png" rect:CGRectMake(0, 0, 27, 40)];
                entity.position = ccp([[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue]);
            }
            else if (type == TARGET_TYPE) {
            }
            else if (type == ENEMY_TYPE) {
            }
            else if (type == OBSTACLE_TYPE) {
                //entity = [[Obstacle alloc] initWithFile:@"bushes.png" rect:CGRectMake(0, 0, 64, 64)];
                entity = [[Obstacle alloc] initWithFile:@"bushes.png"];
                entity.position = ccp([[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue]);
            }
            else if (type == NEUTRAL_TYPE)
            {
                //entity = [[Neutral alloc] initWithFile:@"background.png" rect:CGRectMake(0, 0, 1024, 768)];
                //entity.position = ccp([[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue]);
            }
            if (entity != NULL) {
                [self addEntity:entity];
            }
        }
    }
}

- (void)LoadContentGrid
{
    AEntity *entity;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"level1" ofType:@"grid"];
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];

    int lineNb = 0;

    for (NSString* line in lines) {
        if (line.length) {
            for (int i = 0; i < [line length] - 1; ++i) {
                entity = NULL;
                /*
                if ([line characterAtIndex:i] == GRID_WALL + '0') {
                    entity = [[Neutral alloc] initWithFile:@"littlebushes.png" rect:CGRectMake(0, 0, 32, 32)];
                    entity.position = ccp((i * 32) + 16, (lineNb * 32) + 16);                    
                }
                 */
                if (entity != NULL)
                    [self addEntity:entity];
            }
            lineNb++;
        }
    }

}

- (void)LoadContent
{
    [self LoadContentMap];
    [self LoadContentGrid];
}

- (void)onEnd:(ccTime)dt
{
    [[CCDirector sharedDirector] sendCleanupToScene];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[SplashScreen node]]];
}

@end
