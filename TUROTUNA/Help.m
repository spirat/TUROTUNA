//
//  Help.m
//  TUROTUNA
//
//  Created by  on 11. 11. 3..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Help.h"

@implementation Help

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    
	Help *layer = [Help node];
    [scene addChild: layer];
	
	return scene;
}

-(id) init
{
    self = [super initWithColor:ccc4(0, 0, 0, 0)];
	if( (self)) {
        // AFFICHER TEXTURE HELP HOW TO PLAY TOUSSA
    }
	return self;
}

@end
