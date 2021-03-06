//
//  GameScene.m
//  TUROTUNA
//
//  Created by  on 11. 10. 11..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "Player.h"
#import "Level.h"
#import "ActionGameComportment.h"
#import "MoveGameComportment.h"
#import "Enemy.h"
#import "Shuriken.h"
#import "MathUtils.h"
#import "CCLabelTTF.h"

@implementation GameScene

+ (CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    GameScene *layer = [GameScene node];
    [scene addChild:layer];
    
    return scene;
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        _player = [[Player alloc] initWithFile:@"Player.png" 
                                          rect:CGRectMake(0, 0, 27, 40)
                                         scene:self];
        [_player setEntityPosition:CGPointMake(10, 10)];
        gameComportments = [[NSArray alloc] initWithObjects:[[[MoveGameComportment alloc] init:self
                                                                                       player:_player] autorelease],
                            [[[ActionGameComportment alloc] init:self 
                                                         player:_player] autorelease], nil];
        [self addEntity:_player];
        currentComportment = MOVE_COMPORTMENT;
        _bPlayerFocused = false;
        
        NSString *pListPath = [[NSBundle mainBundle] pathForResource:@"enemyPath1" ofType:@"plist"];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:pListPath];
        
        NSArray *enemies = [dictionary objectForKey:@"enemies"];
        
        for (NSArray *enemyCoord in enemies)
        {
            NSMutableArray *coord = [[NSMutableArray alloc] init];

            Enemy *enemy = [[Enemy alloc] initWithScene:self path:enemyCoord];
            [addEntityList addObject:enemy];
            [coord release];
            [enemy release];
        }
        
        [dictionary release];
         
    }
    return self;
}

- (void)multipleTouchesBegan:(NSSet *)touches
{
	CGPoint pointView1;
	CGPoint pointView2;
	bool i = FALSE;
    for (UITouch *touch in touches)
	{
		if (i == FALSE)
		{
			pointView1 = [touch locationInView:[touch window]];
			pointView1 = [[CCDirector sharedDirector] convertToGL:pointView1];
			i = TRUE;
		}
		else
		{
			pointView2 = [touch locationInView:[touch window]];
			pointView2 = [[CCDirector sharedDirector] convertToGL:pointView2];
		}
	}
	
	[_player setSpeedByPercent:ccpDistance(pointView1, pointView2)];
}

- (void)multipleTouchesMoved:(NSSet *)touches
{
	CGPoint pointView1;
	CGPoint pointView2;
	bool i = FALSE;
    for (UITouch *touch in touches)
	{
		if (i == FALSE)
		{
			pointView1 = [touch locationInView:[touch window]];
			pointView1 = [[CCDirector sharedDirector] convertToGL:pointView1];
			i = TRUE;
		}
		else
		{
			pointView2 = [touch locationInView:[touch window]];
			pointView2 = [[CCDirector sharedDirector] convertToGL:pointView2];
		}
	}
	[_player setSpeedByPercent:ccpDistance(pointView1, pointView2)];

}

- (void)multipleTouchesEnded:(NSSet *)touches
{
	CGPoint pointView1;
	CGPoint pointView2;
	bool i = FALSE;
    for (UITouch *touch in touches)
	{
		if (i == FALSE)
		{
			pointView1 = [touch locationInView:[touch window]];
			pointView1 = [[CCDirector sharedDirector] convertToGL:pointView1];
			i = TRUE;
		}
		else
		{
			pointView2 = [touch locationInView:[touch window]];
			pointView2 = [[CCDirector sharedDirector] convertToGL:pointView2];
		}
	}
	[_player setSpeedByPercent:ccpDistance(pointView1, pointView2)];
}

 
- (void) newTouchBegan:(CGPoint *)point
{
    if ([_player contains:*point])
        _bPlayerFocused = true;
    [[gameComportments objectAtIndex:currentComportment] newTouchBegan:point];
}

- (void) touchPointMoved:(CGPoint *)point
{
    if (_bPlayerFocused == true)
        [[gameComportments objectAtIndex:currentComportment] touchPointMoved:point];
}

- (void) touchEnded:(UITouch *)touch atLocation:(CGPoint)location
{
    if (_bPlayerFocused != true)
    {   
        Shuriken *shuriTmp = [[Shuriken alloc] initWithScene:self startingPos:_player.position endingPos:location];
        [addEntityList addObject:shuriTmp];
        [shuriTmp release];
    }
	else {
		
		
		[self switchGameComportment];
		_bPlayerFocused = false;
		[[gameComportments objectAtIndex:currentComportment] touchEnded:touch
															 atLocation:location];
	}

	
}

- (int) getCurrentComportment
{
    return currentComportment;
}

- (void)setCurrentComportment:(int)comporment
{
    currentComportment = comporment;
}

- (void)update:(ccTime)dt
{
    [super update:dt];
    [[gameComportments objectAtIndex:currentComportment] update:dt];
}

- (void) switchGameComportment
{
    [[gameComportments objectAtIndex:currentComportment] onComportmentSwitchedOff];
    currentComportment = !currentComportment;
    [[gameComportments objectAtIndex:currentComportment] onComportmentSwitchedOn];
}

-(bool)isPlayerFocused
{
    return _bPlayerFocused;
}

- (id)getPlayer
{
    return _player;
}

- (void)gameOver
{
    [self setCurrentComportment:MOVE_COMPORTMENT];
    
}

@end
