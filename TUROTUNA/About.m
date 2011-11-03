#import "cocos2d.h"
#import "About.h"
#import "AScene.h"
#import "CCLabelTTF.h"

@implementation About

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    
	About *layer = [About node];
    [scene addChild: layer];
	
	return scene;
}

-(id) init
{
    self = [super initWithColor:ccc4(0, 0, 0, 0)];
	if( (self)) {
        // AFFICHER TEXTURE TEXT ABOUT TEAM TOUSSA
    }
	return self;
}

@end
