//
//  BigBonusBall.m
//  FlickBall
//
//  Created by Travis Delly on 10/3/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "BigBonusBall.h"
#import "AppDelegate.h"

@implementation BigBonusBall{
    AppDelegate *sharedDelegate;
}


-(instancetype)initForTutorial:(CGPoint)position{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"expandBall"]];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        self.zPosition = 10;
        self.size = CGSizeMake(50, 50);
        
        self.position = position;
        
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"MainBall2";
        self.physicsBody.categoryBitMask = sharedDelegate.candyBallCategory;
        self.physicsBody.collisionBitMask = sharedDelegate.obstacleCategory;
        self.physicsBody.friction = 0;
        self.physicsBody.density = 10;
        self.physicsBody.mass = 10;
        self.physicsBody.dynamic = YES;
        
    }
    return self;
}

-(instancetype)init{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"expandBall"]];
    if(self){
        
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        self.zPosition = 10;
        self.size = CGSizeMake(50, 50);
        
        self.position = sharedDelegate.utils.makeAPointOffScreen;
        
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"MainBall2";
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
    sharedDelegate.BigBonusBallsHit+=1;
    [self removeFromParent];
}

@end
