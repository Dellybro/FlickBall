//
//  MainBall.m
//  FlickBall
//
//  Created by Travis Delly on 9/27/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "MainBall.h"
#import "AppDelegate.h"
@implementation MainBall{
    
    AppDelegate *sharedDelegate;
    NSTimer *multiplierTimer;
    NSTimer *resetBodyTimer;
    
    float scale;
    NSTimer *growBallTimer;
    NSTimer *shrinkBallTimer;
    
}

-(void)resetBody{
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
}

-(void)ballTexture{
    
    self.texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"MainBall%i", sharedDelegate.ballChoice]];
}

-(void)mainBallChargeTexture{
    SKTexture *texture1 = [SKTexture textureWithImageNamed:@"MainBall1"];
    SKTexture *texture2 = [SKTexture textureWithImageNamed:@"MainBall3"];
    SKTexture *texture3 = [SKTexture textureWithImageNamed:@"MainBall2"];
    SKTexture *texture4 = [SKTexture textureWithImageNamed:@"MainBall5"];
    SKTexture *texture5 = [SKTexture textureWithImageNamed:@"MainBall4"];
    SKTexture *texture6 = [SKTexture textureWithImageNamed:@"MainBall6"];
    
    SKAction *rotateTextures = [SKAction animateWithTextures:@[texture1, texture2, texture3, texture4,texture5,texture6] timePerFrame:.2];
    SKAction *repeatAction = [SKAction repeatActionForever:rotateTextures];
    
    [self runAction:repeatAction];
    
}

-(instancetype)initWithPosition:(CGPoint)position{
    
    self = [super init];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        [self ballTexture];
        
        _movement = 1;
        scale = 0;
        
        _superMode = 0;
        
        self.zPosition = 10;
        
        
        self.size = CGSizeMake(50, 50);
        self.position = CGPointMake(position.x, position.y);
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.physicsBody.friction = 0;
        self.physicsBody.restitution = .6f;
        self.physicsBody.linearDamping = .2f;
        self.name = @"ball";
        self.physicsBody.categoryBitMask = sharedDelegate.mainBallCategory;
        self.physicsBody.contactTestBitMask = sharedDelegate.candyBallCategory;
        self.physicsBody.collisionBitMask = sharedDelegate.wallCategory | sharedDelegate.obstacleCategory;;
        
    }
    return self;
}

-(void)moveBall:(CGFloat)Dx :(CGFloat)Dy{
    
    if(self.position.x > self.scene.size.width || self.position.x < 0 || self.position.y > self.scene.size.height || self.position.y < 0){
        self.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
    }
    
    if(_movement == 1 && sharedDelegate.gameOver == 0){
        
        [self.physicsBody applyImpulse:CGVectorMake(Dx, -Dy)];
        
        [self.physicsBody applyTorque:.2];
    }
}
//ChargedBall;
-(void)stopBall:(SKLabelNode*)scoreLabel{
    self.physicsBody.velocity = CGVectorMake(0, 0);
    if(_superMode == 1 && sharedDelegate.gamePaused == 0){
        
        
        SKSpriteNode *fadeBack = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed: @"supercharge"]];
        fadeBack.position = CGPointMake(self.parent.scene.size.width/2, self.parent.scene.size.height/2);
        fadeBack.size = CGSizeMake(self.parent.scene.size.width, self.parent.scene.size.height);
        fadeBack.zPosition = 5;
        
        SKAction *fadeAction = [SKAction fadeAlphaTo:0.0 duration:1];
        SKAction *remove = [SKAction removeFromParent];
        
        [self.parent addChild:fadeBack];
        
        [fadeBack runAction:[SKAction sequence:@[fadeAction, remove]]];
        
        
        
        for (SKNode *nodes in [[self parent] children]) {
            if([nodes.name isEqualToString:@"candy"] || [nodes.name isEqualToString:@"bonus"] || [nodes.name isEqualToString:@"random"] || [nodes.name isEqualToString:@"obstacle"]){
    
                int addCount = (int)[nodes.children count];
                
                [nodes removeAllChildren];
                
                sharedDelegate.score += addCount;
                
            }
        }
        
        scoreLabel.text = [sharedDelegate scoreString];
        _superMode = 0;
        [self removeAllActions];
        [self ballTexture];
    }
}


-(void)shrinkBall{
    
    
    if(!(scale > 0)){
        scale += .5f;
        SKAction *changeSize = [SKAction scaleBy:.5f duration:1];
        [self runAction:changeSize];
        shrinkBallTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(growBallBack) userInfo:nil repeats:NO];
    }
}
-(void)growBallBack{
    SKAction *changeSize = [SKAction scaleBy:(1.0f/scale) duration:.2];
    [self runAction:changeSize];
    scale = 0;
}
-(void)growBall{
    
    if(!(scale > 0)){
        scale += 2.0f;
        SKAction *changeSize = [SKAction scaleBy:2.0f duration:1];
        [self runAction:changeSize];
        growBallTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(shrinkBallBack) userInfo:nil repeats:NO];
    }
}
-(void)shrinkBallBack{
    SKAction *changeSize = [SKAction scaleBy:(1.0f/scale) duration:.2];
    [self runAction:changeSize];
     scale = 0.0f;
}

-(void)multiplier{
    sharedDelegate.multiplier+=1;
    sharedDelegate.multiplier > 1 ?  [multiplierTimer invalidate] : nil;
    multiplierTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(cancelMultiplier) userInfo:nil repeats:NO];
}
-(void)cancelMultiplier{
    sharedDelegate.multiplier=1;
}

-(void)freezeBall{
    [self.physicsBody setVelocity:CGVectorMake(0, 0)];
    
    if(_movement == 0){
        [resetBodyTimer invalidate];
    }
    
    _movement = 0;
    self.texture = [SKTexture textureWithImageNamed:@"FrozenPlayball"];
    resetBodyTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(unfreezeBall) userInfo:nil repeats:NO];
}
-(void)unfreezeBall{
    _movement = 1;
    [self ballTexture];
}
-(void)resetBall:(CGPoint)position{
    
    self.position = position;
    
    [growBallTimer invalidate];
    [resetBodyTimer invalidate];
    
    self.physicsBody.velocity = CGVectorMake(0, 0);
    [self unfreezeBall];
    [self cancelMultiplier];
    self.size = CGSizeMake(50, 50);
}

@end
