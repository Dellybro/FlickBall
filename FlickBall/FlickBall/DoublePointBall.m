//
//  DoublePointBall.m
//  FlickBall
//
//  Created by Travis Delly on 10/2/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "DoublePointBall.h"
#import "AppDelegate.h"

@implementation DoublePointBall{
    AppDelegate *sharedDelegate;
}

-(instancetype)init{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"RedBall"]];
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
    
    sharedDelegate.DoublePointsHit+=1;
    [self removeFromParent];
}

-(void)pushBall{
    if(self.position.x > 200){
        self.physicsBody.velocity = CGVectorMake(-200, 150);
        
    }else{
        self.physicsBody.velocity = CGVectorMake(200, 150);
        
    }
    SKAction *wait = [SKAction waitForDuration:5];
    SKAction *remove = [SKAction removeFromParent];
    
    SKAction *sequence = [SKAction sequence:@[wait, remove]];
    
    [self runAction:sequence];
    
}

@end
