//
//  ShrinkBall.m
//  FlickBall
//
//  Created by Travis Delly on 11/2/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "ShrinkBall.h"
#import "AppDelegate.h"

@implementation ShrinkBall{
    AppDelegate *sharedDelegate;
}



-(instancetype)init{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"shrinkBall"]];
    if(self) {
        
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        self.size = CGSizeMake(50, 50);
        self.position = sharedDelegate.utils.makeAPoint;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"ShrinkBall";
        self.physicsBody.categoryBitMask = sharedDelegate.candyBallCategory;
        self.physicsBody.collisionBitMask = 0;
        [self.physicsBody applyTorque:1.5f];
        //Texuture
        
        self.physicsBody.dynamic = NO;
        
        
    }
    return self;
}

-(instancetype)initForSixtyMode{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"shrinkBall"]];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        self.zPosition = 10;
        self.size = CGSizeMake(50, 50);
        self.position = sharedDelegate.utils.makeAPointOffScreen;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"ShrinkBall";
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
    sharedDelegate.ShrinkBallsHit+=1;
    [self removeFromParent];
}

@end
