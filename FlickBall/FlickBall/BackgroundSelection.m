//
//  BackgroundSelection.m
//  FlickBall
//
//  Created by Travis Delly on 10/15/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "BackgroundSelection.h"
#import "AppDelegate.h"
#import "MainBall.h"
#import "Background.h"
#import "SettingsView.h"

@implementation BackgroundSelection{
    AppDelegate *sharedDelegate;
    
    SKSpriteNode *background1;
    SKSpriteNode *background2;
    SKSpriteNode *background3;
    SKSpriteNode *background4;
    SKSpriteNode *background5;
    SKSpriteNode *background6;
    SKSpriteNode *backButton;
    
    
    SKLabelNode *pageTitle;
    SKNode *holder;
    
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
    
    holder = [SKNode node];
    holder.zPosition = 5;
    
    
    pageTitle = [sharedDelegate.customGUI defaultSKLabel:@"Background Selection" withPosition:CGPointMake(self.size.width/2, 600)];
    [self addChild:pageTitle];
    
    background1 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background1"]];
    background1.name = @"background1";
    background1.position = CGPointMake(90, 500);
    background1.size = CGSizeMake(80, 100);
    
    
    background2 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background2"]];
    background2.name = @"background2";
    background2.position = CGPointMake(82, 350);
    background2.size = CGSizeMake(80, 100);
    
    background3 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background3"]];
    background3.name = @"background3";
    background3.position = CGPointMake(182, 350);
    background3.size = CGSizeMake(80, 100);
    
    background4 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background4"]];
    background4.name = @"background4";
    background4.position = CGPointMake(182, 500);
    background4.size = CGSizeMake(80, 100);
    
    background5 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background5"]];
    background5.name = @"background5";
    background5.position = CGPointMake(282, 350);
    background5.size = CGSizeMake(80, 100);
    
    background6 = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background6"]];
    background6.name = @"background6";
    background6.position = CGPointMake(282, 500);
    background6.size = CGSizeMake(80, 100);
    
    selection = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"selection"]];
    selection.name = @"select";
    selection.position = background1.position;
    selection.size = CGSizeMake(95, 115);
    
    backButton = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"Back"]];
    backButton.name = @"back";
    backButton.position = CGPointMake(self.size.width/2, 250);
    backButton.size = CGSizeMake(self.size.width/3, 50);
    
    
    
    [holder addChild:backButton];
    [holder addChild:selection];
    [holder addChild:background1];
    [holder addChild:background2];
    [holder addChild:background3];
    [holder addChild:background4];
    [holder addChild:background5];
    [holder addChild:background6];
    
    [self addChild:holder];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if([[self nodeAtPoint:location].name isEqualToString:@"background1"]){
            SKAction *action = [SKAction moveTo:background1.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.backGroundChoice = 1;
            
        }else if([[self nodeAtPoint:location].name isEqualToString:@"background2"]){
            SKAction *action = [SKAction moveTo:background2.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.backGroundChoice = 2;
        } else if([[self nodeAtPoint:location].name isEqualToString:@"background3"]){
            SKAction *action = [SKAction moveTo:background3.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.backGroundChoice = 3;
        }else if([[self nodeAtPoint:location].name isEqualToString:@"background4"]){
            SKAction *action = [SKAction moveTo:background4.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.backGroundChoice = 4;
        }else if([[self nodeAtPoint:location].name isEqualToString:@"background5"]){
            SKAction *action = [SKAction moveTo:background5.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.backGroundChoice = 5;
        }else if([[self nodeAtPoint:location].name isEqualToString:@"background6"]){
            SKAction *action = [SKAction moveTo:background6.position duration:.3];
            [selection runAction:action];
            
            sharedDelegate.backGroundChoice = 6;
        }else if([[self nodeAtPoint:location].name isEqualToString:@"back"]){
            SettingsView *home = [[SettingsView alloc] initWithSize:self.size];
            [self removeFromParent];
            [self.view presentScene:home];
            
        }
    }
}

@end
