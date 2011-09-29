#import "SplashScreen.h"
#import "Player.h"

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
	if( (self=[super initWithColor:ccc4(100, 100, 100, 100)])) {

        self.isTouchEnabled = YES;

		CCLabelTTF *label = [CCLabelTTF labelWithString:@"TUROTUNA" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
        label.position =  ccp( size.width /2 , size.height/2 );
		[self addChild: label];
	}
	return self;
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Set up initial location of projectile
   // CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    
    
    Player *projectile = [[Player alloc] spriteWithFile:@"Player.png"
                                           rect:CGRectMake(0, 0, 27, 40) scene:self];
    
    
    projectile.position = location;
    [addEntityList addObject:projectile];
}

- (void) dealloc
{
	[super dealloc];
}
@end
