//
//  BallSelection.m
//  FlickBall
//
//  Created by Travis Delly on 10/15/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "BallSelection.h"
#import "AppDelegate.h"
#import "MainBall.h"
#import "SettingsView.h"
#import "Background.h"

@implementation BallSelection{
    AppDelegate *sharedDelegate;
    
    SKSpriteNode *ball1;
    SKSpriteNode *ball2;
    SKSpriteNode *ball3;
    SKSpriteNode *ball4;
    SKSpriteNode *ball5;
    SKSpriteNode *ball6;
    SKSpriteNode *back;
    
    SKLabelNode *pageTitle;
    
    SKNode *spriteHolder;
    
    SKSpriteNode *selection;
}


-(instancetype)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if(self) {
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        Background *background = [[Background alloc] init];
        background.size = self.size;
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:background];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    
    spriteHolder = [SKNode node];
    spriteHolder.zPosition = 5;
    
    
    pageTitle = [sharedDelegate.customGUI defaultSKLabel:@"Ball Selection" withPosition:CGPointMake(self.size.width/2, 600)];
    [self addChild:pageTitle];
    
    ball1 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"MainBall1"]];
    ball1.name = @"ball1";
    ball1.position = CGPointMake(75, 500);
    ball1.size = CGSizeMake(75, 75);
    
    
    ball2 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"MainBall2"]];
    ball2.name = @"ball2";
    ball2.position = CGPointMake(75, 375);
    ball2.size = CGSizeMake(75, 75);
    
    ball3 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"MainBall3"]];
    ball3.name = @"ball3";
    ball3.position = CGPointMake(175, 500);
    ball3.size = CGSizeMake(75, 75);
    
    
    ball4 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"MainBall4"]];
    ball4.name = @"ball4";
    ball4.position = CGPointMake(275, 500);
    ball4.size = CGSizeMake(75, 75);
    
    ball5 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"MainBall5"]];
    ball5.name = @"ball5";
    ball5.position = CGPointMake(275, 375);
    ball5.size = CGSizeMake(75, 75);
    
    ball6 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"MainBall6"]];
    ball6.name = @"ball6";
    ball6.position = CGPointMake(175, 375);
    ball6.size = CGSizeMake(75, 75);
    
    selection = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"selection"]];
    selection.name = @"select";
    selection.position = ball1.position;
    selection.size = CGSizeMake(85, 85);
    
    back = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"Back"]];
    back.name = @"back";
    back.position = CGPointMake(self.size.width/2, 275);
    back.size = CGSizeMake(self.size.width/3, 50);
    
    
    [spriteHolder addChild:back];
    [spriteHolder addChild:selection];
    [spriteHolder addChild:ball1];
    [spriteHolder addChild:ball2];
    [spriteHolder addChild:ball3];
    [spriteHolder addChild:ball4];
    [spriteHolder addChild:ball5];
    [spriteHolder addChild:ball6];
    
    [self addChild:spriteHolder];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if([[self nodeAtPoint:location].name isEqualToString:@"ball1"]){
            SKAction *action = [SKAction moveTo:ball1.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.ballChoice = 1;
            
        }else if([[self nodeAtPoint:location].name isEqualToString:@"ball2"]){
            SKAction *action = [SKAction moveTo:ball2.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.ballChoice = 2;
        }else if([[self nodeAtPoint:location].name isEqualToString:@"ball3"]){
            SKAction *action = [SKAction moveTo:ball3.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.ballChoice = 3;
        }else if([[self nodeAtPoint:location].name isEqualToString:@"ball4"]){
            SKAction *action = [SKAction moveTo:ball4.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.ballChoice = 4;
        }else if([[self nodeAtPoint:location].name isEqualToString:@"ball5"]){
            SKAction *action = [SKAction moveTo:ball5.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.ballChoice = 5;
        }else if([[self nodeAtPoint:location].name isEqualToString:@"ball6"]){
            SKAction *action = [SKAction moveTo:ball6.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.ballChoice = 6;
        } else if([[self nodeAtPoint:location].name isEqualToString:@"back"]){
            SettingsView *home = [[SettingsView alloc] initWithSize:self.size];
            [self removeFromParent];
            [self.view presentScene:home];
            
        }
    }
}

@end
