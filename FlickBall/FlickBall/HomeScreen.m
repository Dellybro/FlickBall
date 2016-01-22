//
//  HomeScreen.m
//  FlickBall
//
//  Created by Travis Delly on 9/27/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "HomeScreen.h"
#import "MainBall.h"
#import "AppDelegate.h"
#import "GameScene.h"
#import "HTTPHelper.h"
#import <UIKit/UIKit.h>
#import "SettingsView.h"
#import "Background.h"
#import "HowToPlay.h"
#import "SixtySecondGameMode.h"

@interface HomeScreen()

@property SKLabelNode *changeImagesLabel;
@property SKLabelNode *homeLabel;
@property SKSpriteNode *sixtySecondMode;
@property MainBall *bouncingBall;
@property SKNode *bouncingBallGround;
@property SKNode *bouncingBallCieling;
@property SKSpriteNode *NormalModeButton;
@property SKSpriteNode *SettingsButton;
@property SKSpriteNode *HowToPlay;

@property SKSpriteNode *panel1;
@property SKSpriteNode *panel2;
@property SKSpriteNode *panelHeader;

@property SKNode *panelNode;
@property SKNode *buttonNode;

@property ADBannerView *adView;

@end

@implementation HomeScreen{
    AppDelegate *sharedDelegate;
    BOOL bannerIsVisible;
}

-(void)didMoveToView:(SKView *)view{
    //[self detectOrientation];
    sharedDelegate = [[UIApplication sharedApplication] delegate];
    
    if(sharedDelegate.firstTime == 1){
        [self setup];
        [self setupPortraitView];
    }else{
        HowToPlay *firstPlay = [[HowToPlay alloc] initWithSize:self.size];
        [self.view presentScene:firstPlay];
    }
}


-(instancetype)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if(self) {
        
    }
    return self;
}


-(void) detectOrientation {
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) ||
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
    }
}
-(void)setupPortraitView{
    
    Background *background = [[Background alloc] init];
    background.size = self.size;
    background.zPosition = 0;
    background.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:background];
    
    //Portrait View Bouncing Ball
    _bouncingBallCieling.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 450) toPoint:CGPointMake(self.size.width+50, 450)];
    _bouncingBallGround.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 100) toPoint:CGPointMake(self.size.width+50, 100)];
    _homeLabel.position = CGPointMake(self.size.width/2, self.size.height-120);
    
    //Buttons
    _sixtySecondMode.position = CGPointMake(80, self.size.height/2-50);
    _sixtySecondMode.size = CGSizeMake(120, 50);
    
    _NormalModeButton.size = CGSizeMake(120, 50);
    _NormalModeButton.position = CGPointMake(80, self.size.height/2+50);
    
    _SettingsButton.position = CGPointMake(80, self.size.height/2-150);
    _SettingsButton.size = CGSizeMake(120, 50);
    
    _HowToPlay.position = CGPointMake(80, self.size.height/2-250);
    _HowToPlay.size = CGSizeMake(120, 50);
    
    //Panels
    _panel1.position = CGPointMake(0, self.size.height/2-100);
    _panel1.size = CGSizeMake(self.size.width/2.3, self.size.height/1.6675);
    
    _panel2.position = CGPointMake(self.size.width, self.size.height/2-100);
    _panel2.size = CGSizeMake(self.size.width/2.3, self.size.height/1.6675);
    
    _panelHeader.position = CGPointMake(self.size.width/2, self.size.height);
    
    //animate Panels into scene
    [_panel1 runAction:[SKAction moveByX:_panel1.size.width/2 y:0 duration:1]];
    [_panel2 runAction:[SKAction moveByX:-_panel2.size.width/2 y:0 duration:1]];
    [_panelHeader runAction:[SKAction moveByX:0 y:-80 duration:1]];
}
-(void)setup{
    //[sharedDelegate.DatabaseReceiver getMethod:@"index" action:nil];
    
    _bouncingBall = [[MainBall alloc] initWithPosition:CGPointMake(self.size.width-80, self.size.height/2+40)];
    _bouncingBall.size = CGSizeMake(75, 75);
    _bouncingBall.physicsBody.restitution = 1.0f;
    _bouncingBall.physicsBody.linearDamping = 0;
    _bouncingBall.physicsBody.allowsRotation = YES;
    
    _bouncingBallGround = [SKNode node];
    _bouncingBallGround.physicsBody.categoryBitMask =  sharedDelegate.wallCategory;
    
    _bouncingBallCieling = [SKNode node];
    _bouncingBallCieling.physicsBody.categoryBitMask =  sharedDelegate.wallCategory;
    
    _homeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    [_homeLabel setText:@"Flick Ball"];
    
    
    _sixtySecondMode = [SKSpriteNode spriteNodeWithImageNamed:@"NGM1"];
    _sixtySecondMode.name = @"sixtySecondMode";
    
    _NormalModeButton = [SKSpriteNode spriteNodeWithImageNamed:@"NBGM1"];
    _NormalModeButton.name = @"NormalMode";
    
    _SettingsButton = [SKSpriteNode spriteNodeWithImageNamed:@"setting1"];
    _SettingsButton.name = @"Setting";
    
    _HowToPlay = [SKSpriteNode spriteNodeWithImageNamed:@"HTP1"];
    _HowToPlay.name = @"HTP";
    
    _changeImagesLabel = [sharedDelegate.customGUI defaultSKLabel:@"New Balls and Backgrounds avaiable, click Settings!" withPosition:CGPointMake(self.size.width/2, 20)];
     _changeImagesLabel.fontSize = 12.5;
    
    _panel1 = [SKSpriteNode spriteNodeWithImageNamed:@"panel1"];
    _panel2 = [SKSpriteNode spriteNodeWithImageNamed:@"panel2"];
    _panelHeader = [SKSpriteNode spriteNodeWithImageNamed:@"panelHeader"];
    
    _panelNode = [SKNode node];
    _panelNode.zPosition = 1;
    _buttonNode = [SKNode node];
    _buttonNode.zPosition = 2;
    
    [self addChild:_panelNode];
    [_panelNode addChild:_panelHeader];
    [_panelNode addChild:_panel1];
    [_panelNode addChild:_panel2];
    
    [self addChild:_buttonNode];
    [_buttonNode addChild:_HowToPlay];
    [_buttonNode addChild:_changeImagesLabel];
    [_buttonNode addChild:_SettingsButton];
    [_buttonNode addChild:_bouncingBallCieling];
    [_buttonNode addChild:_NormalModeButton];
    [_buttonNode addChild:_bouncingBallGround];
    [_buttonNode addChild:_bouncingBall];
    [_buttonNode addChild:_homeLabel];
    [_buttonNode addChild:_sixtySecondMode];

    
    //Notify change
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(detectOrientation)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _sixtySecondMode.texture = [SKTexture textureWithImageNamed:@"NGM1"];
    _NormalModeButton.texture = [SKTexture textureWithImageNamed:@"NBGM1"];
    _SettingsButton.texture = [SKTexture textureWithImageNamed:@"setting1"];
    _HowToPlay.texture = [SKTexture textureWithImageNamed:@"HTP1"];
    
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if([[self nodeAtPoint:location].name isEqualToString:@"sixtySecondMode"]){
            
            SixtySecondGameMode *sixtySecondMode = [[SixtySecondGameMode alloc] initWithSize:self.size];
            [self removeFromParent];
            [self.view presentScene:sixtySecondMode];
            sixtySecondMode.ball.physicsBody.affectedByGravity = NO;
        } else if([[self nodeAtPoint:location].name isEqualToString:@"NormalMode"]){
            
            GameScene *normalMode = [[GameScene alloc]initWithSize:self.size];
            [self removeFromParent];
            [self.view presentScene:normalMode];
            normalMode.ball.physicsBody.affectedByGravity = NO;
        }else if([[self nodeAtPoint:location].name isEqualToString:@"Setting"]){
            
            SettingsView *setting = [[SettingsView alloc] initWithSize:self.size];
            [self removeFromParent];
            [self.view presentScene:setting];
        }else if([[self nodeAtPoint:location].name isEqualToString:@"HTP"]){
            
            HowToPlay *HTP = [[HowToPlay alloc] initWithSize:self.size];
            [self removeFromParent];
            [self.view presentScene:HTP];
        }
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if([[self nodeAtPoint:location].name isEqualToString:@"sixtySecondMode"]){
            _sixtySecondMode.texture = [SKTexture textureWithImageNamed:@"NGM2"];
        } else if([[self nodeAtPoint:location].name isEqualToString:@"NormalMode"]){
            _NormalModeButton.texture = [SKTexture textureWithImageNamed:@"NBGM2"];
        }else if([[self nodeAtPoint:location].name isEqualToString:@"Setting"]){
            _SettingsButton.texture = [SKTexture textureWithImageNamed:@"setting2"];
        }else if([[self nodeAtPoint:location].name isEqualToString:@"HTP"]){
            _HowToPlay.texture = [SKTexture textureWithImageNamed:@"HTP2"];
        }
    }
}

@end
