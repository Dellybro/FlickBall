//
//  Obstacle.m
//  FlickBall
//
//  Created by Travis Delly on 10/30/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "Obstacle.h"
#import "AppDelegate.h"

@implementation Obstacle{
    AppDelegate *sharedDelegate;
}

-(instancetype)init:(CGPoint)position{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"Obstacle1"]];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        
        self.size = CGSizeMake(100, 100);
        self.position = position;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.name = @"obstacle";
        self.physicsBody.categoryBitMask = sharedDelegate.obstacleCategory;
        self.physicsBody.dynamic = false;
        
        
        [self moveObstacle];
        
    }
    return self;
}


-(void)moveObstacle{
    SKAction *moveRight = [SKAction moveByX:200 y:0 duration:3];
    SKAction *moveUp = [SKAction moveByX:0 y:400 duration:3];
    SKAction *moveLeft = [SKAction moveByX:-200 y:0 duration:3];
    SKAction *moveDown = [SKAction moveByX:0 y:-400 duration:3];
    
    SKAction *sequence = [SKAction sequence:@[moveRight, moveUp, moveLeft, moveDown]];
    SKAction *repeat = [SKAction repeatActionForever:sequence];
    
    [self runAction:repeat];
}


@end
