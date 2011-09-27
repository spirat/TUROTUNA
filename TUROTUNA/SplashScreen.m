#import "SplashScreen.h"

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
	if( (self=[super initWithColor:ccc4(100, 100, 100, 100)])) {

        self.isTouchEnabled = YES;

		CCLabelTTF *label = [CCLabelTTF labelWithString:@"TUROTUNA" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
        label.position =  ccp( size.width /2 , size.height/2 );
		[self addChild: label];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}
@end
