//
//  TimeBall.m
//  FlickBall
//
//  Created by Travis Delly on 9/28/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "TimeBall.h"
#import "AppDelegate.h"

@implementation TimeBall{
    AppDelegate *sharedDelegate;
}

-(instancetype)init{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"Timeball1"]];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        SKTexture *texture1 = [SKTexture textureWithImageNamed:@"Timeball1"];
        SKTexture *texture2 = [SKTexture textureWithImageNamed:@"Timeball2"];
        SKTexture *texture3 = [SKTexture textureWithImageNamed:@"Timeball3"];
        SKTexture *texture4 = [SKTexture textureWithImageNamed:@"Timeball4"];
        
        SKAction *textures = [SKAction animateWithTextures:@[texture1, texture2, texture3, texture4] timePerFrame:.2];
        [self runAction:[SKAction repeatActionForever:textures]];
        
        self.zPosition = 10;
        self.size = CGSizeMake(50, 50);
        self.position = sharedDelegate.utils.makeAPoint;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"timeBall";
        self.physicsBody.categoryBitMask = sharedDelegate.candyBallCategory;
        self.physicsBody.dynamic = NO;
        
    }
    return self;
}

-(instancetype)initForSixtyMode{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"Timeball1"]];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        SKTexture *texture1 = [SKTexture textureWithImageNamed:@"Timeball1"];
        SKTexture *texture2 = [SKTexture textureWithImageNamed:@"Timeball2"];
        SKTexture *texture3 = [SKTexture textureWithImageNamed:@"Timeball3"];
        SKTexture *texture4 = [SKTexture textureWithImageNamed:@"Timeball4"];
        
        SKAction *rotateSkins = [SKAction animateWithTextures:@[texture1, texture2,texture3, texture4] timePerFrame:.3];
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
    sharedDelegate.time += 5;
    sharedDelegate.TimeBallsHit+=1;
    
    [self removeFromParent];
}

@end
