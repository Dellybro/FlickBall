//
//  StickBall.m
//  FlickBall
//
//  Created by Travis Delly on 11/2/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "StickBall.h"
#import "AppDelegate.h"

@implementation StickBall{
    AppDelegate *sharedDelegate;
}



-(instancetype)init{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"stickBall"]];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        self.size = CGSizeMake(50, 50);
        self.position = sharedDelegate.utils.makeAPoint;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"stickBall";
        self.physicsBody.categoryBitMask = sharedDelegate.candyBallCategory;
        
        
        
        self.physicsBody.dynamic = NO;
    }
    return self;
}

-(instancetype)initForSixtyMode{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"stickBall"]];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        self.zPosition = 10;
        self.size = CGSizeMake(50, 50);
        self.position = sharedDelegate.utils.makeAPointOffScreen;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"stickBall";
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
    sharedDelegate.score = 1*sharedDelegate.multiplier+sharedDelegate.score;
    sharedDelegate.StickyBallsHit+=1;
    [self removeFromParent];
}
-(void)moveBall:(CGPoint)position1 :(CGPoint)position2{
    
    
    
    SKAction* action1 = [SKAction moveTo:position1 duration:2];
    SKAction* action2 = [SKAction moveTo:position2 duration:2];
    
    SKAction* finalAction = [SKAction sequence:@[action1, action2]];
    
    [self runAction:[SKAction repeatActionForever:finalAction]];
    
}

@end
