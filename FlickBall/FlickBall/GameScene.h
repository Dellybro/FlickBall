//
//  GameScene.h
//  FlickBall
//

//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MainBall.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate, UIApplicationDelegate>

-(instancetype)initWithSize:(CGSize)size;
@property MainBall *ball;

@end
