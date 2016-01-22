//
//  PoisonBall.m
//  FlickBall
//
//  Created by Travis Delly on 9/28/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "PoisonBall.h"
#import "AppDelegate.h"

@implementation PoisonBall{
    AppDelegate *sharedDelegate;
}

-(instancetype)init{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"PoisonBall"]];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        
        self.size = CGSizeMake(50, 50);
        self.position = sharedDelegate.utils.makeAPoint;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"PoisonBall";
        self.physicsBody.categoryBitMask = sharedDelegate.candyBallCategory;
        
        self.physicsBody.dynamic = NO;
    }
    return self;
}

-(instancetype)initForSixtyMode{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"PoisonBall"]];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        
        self.zPosition = 10;
        self.size = CGSizeMake(50, 50);
        self.position = sharedDelegate.utils.makeAPointOffScreen;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"DoublePointsBall";
        self.physicsBody.categoryBitMask = sharedDelegate.candyBallCategory;
        self.physicsBody.collisionBitMask = sharedDelegate.obstacleCategory;
        self.physicsBody.friction = 0;
        self.physicsBody.density = 10;
        self.physicsBody.mass = 10;
        self.physicsBody.dynamic = YES;
        
        [sharedDelegate.utils pushBall:self];
    }
    return self;
}

-(void)ballHit{
    sharedDelegate.score -=2;
    sharedDelegate.time -=2;
    sharedDelegate.PoisonBallsHit+=1;
    [self removeFromParent];
}

@end
