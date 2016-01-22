//
//  SettingsView.m
//  FlickBall
//
//  Created by Travis Delly on 10/14/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "SettingsView.h"
#import "AppDelegate.h"
#import "HomeScreen.h"
#import "BackgroundSelection.h"
#import "BallSelection.h"
#import "Background.h"

@interface SettingsView()

@property ADBannerView *adView;

@end

@implementation SettingsView{
    SKSpriteNode *highscoresButton;
    SKSpriteNode *ballSelectionButton;
    SKSpriteNode *backgroundSelectionButton;
    SKSpriteNode *backButton;
    
    SKNode *spriteHolder;
    
    AppDelegate *sharedDelegate;
    BOOL bannerIsVisible;
    
}

-(void)didMoveToView:(SKView *)view{
    bannerIsVisible = true;
    _adView = [[ADBannerView alloc] initWithFrame:CGRectMake(self.size.height, self.view.frame.size.height - 50, 320, 50)];
    [view addSubview:_adView];
}

-(instancetype)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        Background *background = [[Background alloc] init];
        background.size = self.size;
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:background];
        
        [self setup];
        
        
    }
    return self;
}


-(void)setup{
    
    spriteHolder = [SKNode node];
    spriteHolder.zPosition = 5;
    
    highscoresButton = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"highscores"]];
    highscoresButton.position = CGPointMake(self.size.width/2, self.size.height/2+150);
    highscoresButton.name = @"highscoreButton";
    
    ballSelectionButton = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"ballSelectionB"]];
    ballSelectionButton.position = CGPointMake(self.size.width/2, self.size.height/2-50);
    ballSelectionButton.name = @"ballSelect";
    
    backgroundSelectionButton = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"backgroundB"]];
    backgroundSelectionButton.position = CGPointMake(self.size.width/2, self.size.height/2+50);
    backgroundSelectionButton.name = @"backgroundSelect";
    
    backButton = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"Back"]];;
    backButton.position = CGPointMake(self.size.width/2, self.size.height/2-150);
    backButton.name = @"backButton";
    
    [spriteHolder addChild:ballSelectionButton];
    [spriteHolder addChild:backButton];
    [spriteHolder addChild:backgroundSelectionButton];
    [spriteHolder addChild:highscoresButton];
    
    [self addChild:spriteHolder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint Location = [touch locationInNode:self];
        if([[self nodeAtPoint:Location].name isEqualToString:@"highscoreButton"]){
                        
            [sharedDelegate.gameCenter showLeaderboardAndAchievements:YES view:self.view.window.rootViewController];
            
        }else if([[self nodeAtPoint:Location].name isEqualToString:@"backButton"]){
            
            HomeScreen *home = [[HomeScreen alloc] initWithSize:self.size];
            [self.view presentScene:home];
            
        }else if([[self nodeAtPoint:Location].name isEqualToString:@"ballSelect"]){
            
            BallSelection *ballMenu = [[BallSelection alloc] initWithSize:self.size];
            [self.view presentScene:ballMenu];
            
        }else if([[self nodeAtPoint:Location].name isEqualToString:@"backgroundSelect"]){
            
            BackgroundSelection *backMenu = [[BackgroundSelection alloc] initWithSize:self.size];
            [self.view presentScene:backMenu];
        }
    }
}

@end
