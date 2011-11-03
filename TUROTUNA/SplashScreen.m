#import "SplashScreen.h"
#import "Player.h"
#import "Level.h"
#import "CCLayer.h"
#import "About.h"
#import "Help.h"

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
    self = [super initWithColor:ccc4(0, 0, 0, 0)];
	if( (self)) {
        CCMenuItem *menuItem1 = [CCMenuItemFont itemFromString:@"Play" target:self selector:@selector(onPlay:)];
        CCMenuItem *menuItem2 = [CCMenuItemFont itemFromString:@"Help" target:self selector:@selector(onHelp:)];
        CCMenuItem *menuItem3 = [CCMenuItemFont itemFromString:@"About" target:self selector:@selector(onAbout:)];	
        CCMenu *menu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
        [menu alignItemsVertically];
        [self addChild:menu];
    }
	return self;
}

- (void)onPlay:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[Level node]];
}

- (void)onHelp:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[Help node]];
}

- (void)onAbout:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[About node]];
}

- (void) touchPointMoved:(CGPoint *)point
{
    
}

- (void) newTouchBegan:(CGPoint *)point
{
    /*
    Player *projectile = [[Player alloc] initWithFile:@"Player.png"
                                                 rect:CGRectMake(0, 0, 27, 40) 
                                                scene:self];
    
    
    projectile.position = *point;
    [addEntityList addObject:projectile];
    
    [projectile runAction:[[projectile actionList] objectAtIndex:0]];
*/
}



- (void) dealloc
{
	[super dealloc];
}
@end
