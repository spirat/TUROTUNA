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

// Pixel collision (run sprite collision test before as an optimization)
- (BOOL)checkSpriteCollision:(AEntity*)entity1 entity2:(AEntity*)entity2 
{
    NSLog(@"Pixel collision test begins");
    CGRect  hitbox1 = entity1.hitBox;
    CGRect  hitbox2 = entity2.hitBox;
    bool    ret = false;
    
    int     diffX = hitbox2.origin.x - hitbox1.origin.x;
    int     diffY = hitbox2.origin.y - hitbox1.origin.y;
    int     diffXX = (hitbox2.origin.x + hitbox2.size.width) - (hitbox1.origin.x + hitbox1.size.width);
    int     diffYY = (hitbox2.origin.y + hitbox2.size.height) - (hitbox1.origin.y + hitbox1.size.height);
    
    off_t   x, x1, x2, y, y1, y2;
    size_t  width, height;
    
    size_t  size1 = hitbox1.size.width * hitbox1.size.height * 4;
    size_t  size2 = hitbox2.size.width * hitbox2.size.height * 4;
    
    // intersection rect position
    x = (diffX > 0) ? hitbox2.origin.x:hitbox1.origin.x;
    y = (diffY > 0) ? hitbox2.origin.y:hitbox1.origin.y;
    
    // intersection rect size
    width = (hitbox2.size.width < hitbox1.size.width) ? hitbox2.size.width:hitbox1.size.width;
    if (diffX < 0)
        width -= abs(diffX);
    if (diffXX > 0)
        width -= abs(diffXX);
    height = (hitbox2.size.height < hitbox1.size.height) ? hitbox2.size.height:hitbox1.size.height;
    if (diffY < 0)
        height -= abs(diffY);
    if (diffYY > 0)
        height -= abs(diffYY);
    
    // get relative offset
    x1 = x - hitbox1.origin.x;
    y1 = y - hitbox1.origin.y;
    x2 = x - hitbox2.origin.x;
    y2 = y - hitbox2.origin.y;
    
    // get pixel data
    uint8_t*   pixels1 = malloc(size1);
    uint8_t*   pixels2 = malloc(size2);
    
    if (!pixels1 || !pixels2)
        goto cleanup;
    bzero(pixels1, size1);
    bzero(pixels2, size2);
    glReadPixels(hitbox1.origin.x, hitbox1.origin.y, hitbox1.size.width, hitbox1.size.height, GL_RGBA, GL_UNSIGNED_BYTE, pixels1);
    glReadPixels(hitbox2.origin.x, hitbox2.origin.y, hitbox2.size.width, hitbox2.size.height, GL_RGBA, GL_UNSIGNED_BYTE, pixels2);

    // pixel collision in the intersection
    off_t idx1, idx2; 
    uint alpha1, alpha2;
    
    for (int i = 0; i < height; ++i) {
        for (int j = 0; j < width; ++j) {
            
            idx1 = x * 4 + y * hitbox1.size.width * 4;
            idx1 += j * 4 + i * hitbox1.size.width * 4;
            alpha1 = pixels1[idx1];
            idx2 = x * 4 + y * hitbox2.size.width * 4;
            idx2 += j * 4 + i * hitbox2.size.width * 4;
            alpha2 = pixels2[idx2];
            if (alpha1 != 0 && alpha2 != 0) {
                NSLog(@"Collision detected: Rect1:%@ Rect2:%@", hitbox1, hitbox2);
                ret = true;
                goto cleanup;
            }
        }
    }

cleanup:
    free(pixels1);
    free(pixels2);
    NSLog(@"DEBUG: Collision test done, result: %@", ret);
    return ret;
}

// Compare un sprite d'obstacle donne avec un 64x64 du background
- (BOOL)compareSpriteWithBg:(const uint8_t*)pixel path:(NSString*)obstaclePath bytesPerPixel:(int)bytesPerPixel
{
    UIImage *obstacleImage = [UIImage imageNamed:obstaclePath];
    CGImageRef imageRef = [obstacleImage CGImage];
    
    size_t bpr = CGImageGetBytesPerRow(imageRef);
    size_t bpp = CGImageGetBitsPerPixel(imageRef);
    size_t bpc = CGImageGetBitsPerComponent(imageRef);
    size_t bytes_per_pixel = bpp / bpc;
    
    CGDataProviderRef provider = CGImageGetDataProvider(imageRef);
    NSData* data = (id)CGDataProviderCopyData(provider);
    [data autorelease];
    const uint8_t* bytes = [data bytes];

    for (int y = 0; y < 64; ++y) {
        for (int x = 0; x < 64; ++x) {
            const uint8_t* obsPixel = &bytes[y * bpr + x * bytes_per_pixel];
            const uint8_t* backPixel = &pixel[y * bpr + x * bytes_per_pixel];

            for (size_t x = 0; x < bytes_per_pixel; x++)
            {
                if (obsPixel[x] != backPixel[x]) {
                    NSLog(@"No match =(");
                    return false;
                }
            }
        }
    }
    NSLog(@"Sprite & Bg MATCH =)");
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
            [self compareSpriteWithBg:pixel path:obs bytesPerPixel:bytes_per_pixel];
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
                    if ([entity isKindOfClass:[Obstacle class]])
                        [self addEntity:entity];
                    else
                        [self addChild:entity];
                    /*
                    entity.position = ccp((i * 64) + 32, (lineNb * 64) + 32);

                    [self addEntity:entity];
                    */
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
