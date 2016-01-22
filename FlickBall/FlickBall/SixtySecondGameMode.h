//
//  SixtySecondGameMode.h
//  FlickBall
//
//  Created by Travis Delly on 10/30/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MainBall.h"

@interface SixtySecondGameMode : SKScene <SKPhysicsContactDelegate, UIApplicationDelegate>


@property MainBall *ball;

-(void)unpause;
-(void)pause:(UITapGestureRecognizer*)sender;

@end
