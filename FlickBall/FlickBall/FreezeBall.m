//
//  FreezeBall.m
//  FlickBall
//
//  Created by Travis Delly on 10/2/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "FreezeBall.h"
#import "AppDelegate.h"
@implementation FreezeBall{
    AppDelegate *sharedDelegate;
}



-(instancetype)init{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"Freezeball"]];
    if(self) {
        
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        self.size = CGSizeMake(50, 50);
        self.position = sharedDelegate.utils.makeAPoint;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"PoisonBall";
        self.physicsBody.categoryBitMask = sharedDelegate.candyBallCategory;
        self.physicsBody.collisionBitMask = 0;
        [self.physicsBody applyTorque:1.5f];
        //Texuture
        SKTexture *texture1 = [SKTexture textureWithImageNamed:@"Freezeball"];
        SKTexture *texture2 = [SKTexture textureWithImageNamed:@"Freezeball2"];
        SKTexture *texture3 = [SKTexture textureWithImageNamed:@"Freezeball3"];
        
        SKAction *rotateSkins = [SKAction animateWithTextures:@[texture1, texture2,texture3] timePerFrame:.3];
        [self runAction:[SKAction repeatActionForever:rotateSkins]];
        
        self.physicsBody.dynamic = NO;
        
        
    }
    return self;
}

-(instancetype)initForSixtyMode{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"Freezeball"]];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        SKTexture *texture1 = [SKTexture textureWithImageNamed:@"Freezeball"];
        SKTexture *texture2 = [SKTexture textureWithImageNamed:@"Freezeball2"];
        SKTexture *texture3 = [SKTexture textureWithImageNamed:@"Freezeball3"];
        
        SKAction *rotateSkins = [SKAction animateWithTextures:@[texture1, texture2,texture3] timePerFrame:.3];
        [self runAction:[SKAction repeatActionForever:rotateSkins]];
        
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
    sharedDelegate.FreezeBallsHit+=1;
    [self removeFromParent];
}

@end
