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

- (void)checkCollision:(unsigned char*)baseData x:(int)x y:(int)y path:(NSString*)obstaclePath size:(int)obstacleSize bytesPerPixel:(int)bytesPerPixel
{
    // compute subrect offset
    int offset = (64 - obstacleSize) / 2;
    
    // generate rawData for obstacle
    UIImage *obstacleImg = [UIImage imageNamed:obstaclePath];
    CGImageRef imageRef = [obstacleImg CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    unsigned char *obsData = malloc(height * width * 4);

    // iterate subrect obstacle (just add x and y for the baseData
    for (int h = offset; h < obstacleSize + offset; ++h) {
        for (int w = offset; w < obstacleSize + offset; ++w) {
            CGFloat redObs   = (obsData[(w * bytesPerPixel) + (h * width)]     * 1.0) / 255.0;
            CGFloat greenObs = (obsData[(w * bytesPerPixel) + (h * width) + 1] * 1.0) / 255.0;
            CGFloat blueObs  = (obsData[(w * bytesPerPixel) + (h * width) + 2] * 1.0) / 255.0;
            CGFloat alphaObs = (obsData[(w * bytesPerPixel) + (h * width) + 3] * 1.0) / 255.0;
            //comparer avec bgPixColor (utiliser UIColor.CGColor.CGColorEqualToColor
        }
    }
    free(obsData);
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
    
    NSString *obstaclePath = [[NSBundle mainBundle] pathForResource:@"Plant" ofType:@"png"];
    int obstacleSize = 16;
    
    for (int y = 0; y < height / 64; y += 64) {
        for (int x = 0; x < width / 64; x += 64) {
            // foreach obstacle sprite path
            [self checkCollision:rawData x:x y:y path:obstaclePath size:obstacleSize bytesPerPixel:bytesPerPixel];
        }
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
