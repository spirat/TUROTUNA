#import "SplashScreen.h"
#import "Player.h"
#import "Level.h"

// HelloWorldLayer implementation
@implementation SplashScreen

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];

	SplashScreen *layer = [SplashScreen node];
    [scene addChild: layer];
	
	return scene;
}

-(id) init
{
    [super init];
	if( (self)) {

/*
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"TUROTUNA" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
        label.position =  ccp( size.width /2 , size.height/2 );
		[self addChild: label];
        */
	}
	return self;
}

- (void) touchPointMoved:(CGPoint *)point
{
    
}

- (void) newTouchBegan:(CGPoint *)point
{
    Player *projectile = [[Player alloc] initWithFile:@"Player.png"
                                                 rect:CGRectMake(0, 0, 27, 40) 
                                                scene:self];
    
    
    projectile.position = *point;
    [addEntityList addObject:projectile];
    
    [projectile runAction:[[projectile actionList] objectAtIndex:0]];
    // TEMP, ne pas mettre ca dans l'init, appelle la scene du Level (1)
    //[[CCDirector sharedDirector] replaceScene: [Level scene]];
}



- (void) dealloc
{
	[super dealloc];
}
@end
