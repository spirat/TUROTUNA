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
	if( (self=[super initWithColor:ccc4(255, 255, 255, 255)])) {

        self.isTouchEnabled = YES;
/*
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"TUROTUNA" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
        label.position =  ccp( size.width /2 , size.height/2 );
		[self addChild: label];
        */
	}
    //[[CCDirector sharedDirector] pushScene: [Level scene]];
	return self;
}

- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    [self touchPointMoved:&location];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Set up initial location of projectile
   // CGSize winSize = [[CCDirector sharedDirector] winSize];
   
    
    //AEntity *projectile = [[AEntity alloc] spriteWithFile:@"Player.png"
    //                                       rect:CGRectMake(0, 0, 27, 40) scene:self];
    
    Player *projectile = [[Player alloc] initWithFile:@"Player.png"
                                                 rect:CGRectMake(0, 0, 27, 40) scene:self];
    
    
    projectile.position = location;
    
    [self newTouchBegan:&location];
    
    [addEntityList addObject:projectile];
}

- (void) dealloc
{
	[super dealloc];
}
@end
