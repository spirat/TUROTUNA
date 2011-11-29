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

- (BOOL)checkSpriteCollision
{
    
}

// Compare un sprite d'obstacle donne avec un 64x64 du background
// Peut aussi gerer des comparaison de sub-rectangles (changer obstacleSize)
- (BOOL)checkCollision:(const uint8_t*)pixel path:(NSString*)obstaclePath size:(int)obstacleSize bytesPerPixel:(int)bytesPerPixel
{
    // generate raw data
    UIImage *obstacleImage = [UIImage imageNamed:obstaclePath];
    CGImageRef imageRef = [obstacleImage CGImage];
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bpr = CGImageGetBytesPerRow(imageRef);
    size_t bpp = CGImageGetBitsPerPixel(imageRef);
    size_t bpc = CGImageGetBitsPerComponent(imageRef);
    size_t bytes_per_pixel = bpp / bpc;
    
    CGDataProviderRef provider = CGImageGetDataProvider(imageRef);
    NSData* data = (id)CGDataProviderCopyData(provider);
    [data autorelease];
    const uint8_t* bytes = [data bytes];

    // compute subrect offset (don't use subrect for now, assume size 64)
    // TODO: integrate subrect
    //int offset = (64 - obstacleSize) / 2;
    
    // iterate subrect obstacle (just add x and y for the baseData)
    for (int y = 0; y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            const uint8_t* obsPixel = &bytes[y * bpr + x * bytes_per_pixel];
            const uint8_t* backPixel = &pixel[y * bpr + x * bytes_per_pixel];
            
            for (size_t x = 0; x < bytes_per_pixel; x++)
            {
                if (obsPixel[x] != backPixel[x]) {
                    NSLog(@"Pixel mismatch");
                    return false;
                }
            }
        }
    }
    NSLog(@"OBSTACLE MATCH");
    return true;
}

// Itere sur le background, par carre de 64x64 et compare avec 
// chaque sprite d'obstacle
// http://www.cocos2d-iphone.org/archives/61 RGBA8888 pixel format
- (void)LoadCollisionBox
{
    UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
    CGImageRef imageRef = [backgroundImage CGImage];
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bpr = CGImageGetBytesPerRow(imageRef);
    size_t bpp = CGImageGetBitsPerPixel(imageRef);
    size_t bpc = CGImageGetBitsPerComponent(imageRef);
    size_t bytes_per_pixel = bpp / bpc;

    CGDataProviderRef provider = CGImageGetDataProvider(imageRef);
    NSData* data = (id)CGDataProviderCopyData(provider);
    [data autorelease];
    const uint8_t* bytes = [data bytes];
    
    // tmp test TODO: faire une liste de NSString vers les obstacles ou un dico ou..
    NSString* obs = [[NSBundle mainBundle] pathForResource:@"grass" ofType:@"png"];
    
    for (int y = 0; y < height / 64; y += 64) {
        for (int x = 0; x < width / 64; x += 64) {
            const uint8_t* pixel = &bytes[y * bpr + x * bytes_per_pixel];
            // TODO iterer sur les obstacles foreach "obs" in obstaclesPaths
            [self checkCollision:pixel path:obs size:64 bytesPerPixel:bpp];
        }
    }
}

//// Init level array, each time LoadContent finishes, increment the index
//// like that each time LoadContent is called a new level is loaded
//// We must clear the scene first
//// OR we use static stuff and instance a new Level class each time
//// that way we don't have to destroy/free/.. anything ourselves
//- (void)LoadContentMap
//{
//    AEntity *entity;
//    int type;
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"level1" ofType:@"map"];
//    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
//    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
//
//    //[self LoadCollisionBox];
//    for (NSString* line in lines) {
//        if (line.length) {
//            NSArray *entry = [line componentsSeparatedByString:@" "];
//            type = [[entry objectAtIndex:0] intValue];
//            entity = NULL;
//            
//            if (type == PLAYER_TYPE) {
//                entity = [[Player alloc] initWithFile:@"Player.png" rect:CGRectMake(0, 0, 27, 40)];
//                entity.position = ccp([[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue]);
//            }
//            else if (type == TARGET_TYPE) {
//            }
//            else if (type == ENEMY_TYPE) {
//            }
//            else if (type == OBSTACLE_TYPE) {
//                //entity = [[Obstacle alloc] initWithFile:@"bushes.png" rect:CGRectMake(0, 0, 64, 64)];
//                entity = [[Obstacle alloc] initWithFile:@"bushes.png"];
//                entity.position = ccp([[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue]);
//            }
//            else if (type == NEUTRAL_TYPE)
//            {
//                //entity = [[Neutral alloc] initWithFile:@"background.png" rect:CGRectMake(0, 0, 1024, 768)];
//                //entity.position = ccp([[entry objectAtIndex:1] intValue], [[entry objectAtIndex:2] intValue]);
//            }
//            if (entity != NULL) {
//                [self addEntity:entity];
//            }
//        }
//    }
//}

- (void)LoadContentGrid
{
    AEntity *entity;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"level1" ofType:@"grid"];
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];

    int lineNb = 0;

    for (NSString* line in lines) {
        if (line.length) {
            for (int i = [line length] - 1; i >= 0; --i) {
                entity = NULL;
                if ([line characterAtIndex:i] == FLOOR)
                    entity = [[Neutral alloc] initWithFile:@"floor.png" rect:CGRectMake(0, 0, 64, 64)];
                else if ([line characterAtIndex:i] == GRASS)
                    entity = [[Neutral alloc] initWithFile:@"grass.png" rect:CGRectMake(0, 0, 64, 64)];
                else if ([line characterAtIndex:i] == FLOWERS)
                    entity = [[Neutral alloc] initWithFile:@"flowers.png" rect:CGRectMake(0, 0, 64, 64)];
                else if ([line characterAtIndex:i] == SWAMP)
                    entity = [[Neutral alloc] initWithFile:@"swamp.png" rect:CGRectMake(0, 0, 64, 64)];
                else if ([line characterAtIndex:i] == OBS_T)
                    entity = [[Obstacle alloc] initWithFile:@"hbushes3.png" rect:CGRectMake(0, 0, 64, 64)];
                else if ([line characterAtIndex:i] == OBS_M)
                    entity = [[Obstacle alloc] initWithFile:@"hbushes2.png" rect:CGRectMake(0, 0, 64, 64)];
                else if ([line characterAtIndex:i] == OBS_H)
                    entity = [[Obstacle alloc] initWithFile:@"hbushes1.png" rect:CGRectMake(0, 0, 64, 64)];
                
                if (entity != NULL)
                {
                    entity.depth = 0;
                    [self addEntity:entity];
                    entity.position = ccp(((/*15 -*/ i) * 64) + 32, ((11 - lineNb) * 64) + 32);
                }
            }
            lineNb++;
        }
    }

}

- (void)LoadContent
{
//    [self LoadContentMap];
    [self LoadContentGrid];
}

- (void)onEnd:(ccTime)dt
{
    [[CCDirector sharedDirector] sendCleanupToScene];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[SplashScreen node]]];
}

@end
