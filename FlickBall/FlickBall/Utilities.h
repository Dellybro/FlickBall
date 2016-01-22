//
//  Utilities.h
//  FlickBall
//
//  Created by Travis Delly on 9/28/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "MainBall.h"

@interface Utilities : NSObject

-(CGPoint)makeAPoint;
-(CGPoint)makeAPointOffScreen;
@property NSMutableArray *ArrayForMakeAPoint;
-(void)setupGameOver:(SKNode*)gameOverHolder scene:(SKScene*)gameScene;
-(void)gameBallContact:(SKPhysicsContact *)contact time:(SKLabelNode*)timer score:(SKLabelNode*)score mainball:(MainBall*)mainBall;

-(void)pushBall:(SKSpriteNode*)ball;

-(void)setupPause:(SKNode*)pauseHolder;

@end
