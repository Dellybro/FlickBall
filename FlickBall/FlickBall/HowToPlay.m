//
//  HowToPlay.m
//  FlickBall
//
//  Created by Travis Delly on 11/2/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "HowToPlay.h"
#import "Background.h"
#import "AppDelegate.h"
#import "HomeScreen.h"

@implementation HowToPlay{
    AppDelegate *sharedDelegate;
    UILabel *text;
}

-(void)didMoveToView:(SKView *)view{
    text = [sharedDelegate.customGUI defaultLabel:@"Hello Welcome to\r\n Flick Ball! \r\n To Pause double tap the screen! \r\n We have 8 different different types \r\n of balls. \r\n 1. Point balls that add score \r\n 2. Time balls add time to the total time \r\n 3. Expanding balls which expands your ball! \r\n 4. Multiplier balls which gives you a point multiplier which stacks! \r\n 5. Poison balls which take two points and 2 seconds away from you \r\n 6. Sticky balls which makes you have to swipe again \r\n 7. Sticky balls which makes you have to swipe again \r\n 8. Freeze balls which freezes you into place! Changing the ball into the frozen play ball! \r\n\r\n Also after 40 successful Point balls you will have a super charged ball! Click it to see what happens!"];
    text.textColor = [UIColor whiteColor];
    text.font = [UIFont fontWithName:@"Chalkduster" size:12.5];
    text.adjustsFontSizeToFitWidth = YES;
    text.numberOfLines = 0;
    text.lineBreakMode = NSLineBreakByWordWrapping;
    
    text.frame = CGRectMake(self.size.width/4, 40, self.size.width/2, self.size.height-100);
    
    [view addSubview:text];
    
    
    if(sharedDelegate.firstTime == 0){
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome!" message:@"We noticed this is your first time playing Flicker Ball! Take a moment to read how to play!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Flicker Ball!" message:@"We noticed this is your first time! Take a minute to read how to play!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil];
        [alert show];
        sharedDelegate.firstTime = 1;
    }
}

-(instancetype)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if (self){
        
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        [self setup];
        
    }
    return self;
}

-(void)setup{
    
    Background *background = [[Background alloc] init];
    background.size = self.size;
    background.zPosition = 0;
    background.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:background];
    
    SKSpriteNode *blueball = [sharedDelegate.customGUI defaultSKSprite:@"blueBall" withPosition:CGPointMake(self.size.width-50, self.size.height/2+280) name:@"blue"];
    blueball.size = CGSizeMake(50, 50);
    SKLabelNode *bluetext = [sharedDelegate.customGUI defaultSKLabel:@"Point Ball" withPosition:CGPointMake(blueball.position.x, blueball.position.y-35)];
    bluetext.fontSize = 10;
    
    SKSpriteNode *timeball  = [sharedDelegate.customGUI defaultSKSprite:@"Timeball1" withPosition:CGPointMake(self.size.width-50, self.size.height/2+205) name:@"time"];
    timeball.size = CGSizeMake(50, 50);
    SKLabelNode *timeText = [sharedDelegate.customGUI defaultSKLabel:@"Time Ball" withPosition:CGPointMake(timeball.position.x, timeball.position.y-35)];
    timeText.fontSize = 10;
    
    SKSpriteNode *bigball = [sharedDelegate.customGUI defaultSKSprite:@"expandBall" withPosition:CGPointMake(self.size.width-50, self.size.height/2+130) name:@"big"];
    bigball.size = CGSizeMake(50, 50);
    SKLabelNode *bigText = [sharedDelegate.customGUI defaultSKLabel:@"Expanding Ball" withPosition:CGPointMake(bigball.position.x, bigball.position.y-35)];
    bigText.fontSize = 10;
    
    SKSpriteNode *doublepoints = [sharedDelegate.customGUI defaultSKSprite:@"RedBall" withPosition:CGPointMake(self.size.width-50, self.size.height/2+55) name:@"dp"];
    doublepoints.size = CGSizeMake(50, 50);
    SKLabelNode *doubleText = [sharedDelegate.customGUI defaultSKLabel:@"Multiplier Ball" withPosition:CGPointMake(doublepoints.position.x, doublepoints.position.y-35)];
    doubleText.fontSize = 10;
    
    SKSpriteNode *poisonBall = [sharedDelegate.customGUI defaultSKSprite:@"PoisonBall" withPosition:CGPointMake(self.size.width-50, self.size.height/2-20) name:@"pb"];
    poisonBall.size = CGSizeMake(50, 50);
    SKLabelNode *poisonText = [sharedDelegate.customGUI defaultSKLabel:@"Poison Ball" withPosition:CGPointMake(poisonBall.position.x, poisonBall.position.y-35)];
    poisonText.fontSize = 10;
    
    
    SKSpriteNode *shrinkBall = [sharedDelegate.customGUI defaultSKSprite:@"shrinkBall" withPosition:CGPointMake(self.size.width-50, self.size.height/2-95) name:@"shrink"];
    shrinkBall.size = CGSizeMake(50, 50);
    SKLabelNode *shrinkText = [sharedDelegate.customGUI defaultSKLabel:@"Shrinking Ball" withPosition:CGPointMake(shrinkBall.position.x, shrinkBall.position.y-35)];
    shrinkText.fontSize = 10;
    
    SKSpriteNode *stickyball = [sharedDelegate.customGUI defaultSKSprite:@"stickBall" withPosition:CGPointMake(self.size.width-50, self.size.height/2-170) name:@"stick"];
    stickyball.size = CGSizeMake(50, 50);
    SKLabelNode *stickText = [sharedDelegate.customGUI defaultSKLabel:@"Sticky Ball" withPosition:CGPointMake(stickyball.position.x, stickyball.position.y-35)];;
    stickText.fontSize = 10;
    
    SKSpriteNode *freezeball = [sharedDelegate.customGUI defaultSKSprite:@"Freezeball" withPosition:CGPointMake(self.size.width-50, self.size.height/2-245) name:@"freeze"];
    freezeball.size = CGSizeMake(50, 50);
    SKLabelNode *freezeText = [sharedDelegate.customGUI defaultSKLabel:@"Freeze Ball" withPosition:CGPointMake(freezeball.position.x, freezeball.position.y-35)];
    freezeText.fontSize = 10;
    
    SKTexture *texturey1 = [SKTexture textureWithImageNamed:@"Freezeball"];
    SKTexture *texturey2= [SKTexture textureWithImageNamed:@"Freezeball2"];
    SKTexture *texturey3= [SKTexture textureWithImageNamed:@"Freezeball3"];
    
    
    SKAction *rotateTexturesy = [SKAction animateWithTextures:@[texturey1, texturey2, texturey3] timePerFrame:.2];
    SKAction *repeatActiony = [SKAction repeatActionForever:rotateTexturesy];
    
    [freezeball runAction:repeatActiony];
    
    SKSpriteNode *mainFreeze = [sharedDelegate.customGUI defaultSKSprite:@"FrozenPlayball" withPosition:CGPointMake(50, self.size.height/2+50) name:@"mainfreeze"];
    mainFreeze.size = CGSizeMake(50, 50);
    SKLabelNode *mainFText = [sharedDelegate.customGUI defaultSKLabel:@"Frozen Play Ball" withPosition:CGPointMake(mainFreeze.position.x, mainFreeze.position.y+35)];
    mainFText.fontSize = 10;
    
    SKSpriteNode *main = [sharedDelegate.customGUI defaultSKSprite:@"MainBall1" withPosition:CGPointMake(50, self.size.height/2-100) name:@"main"];
    main.size = CGSizeMake(50, 50);
    SKLabelNode *mainText = [sharedDelegate.customGUI defaultSKLabel:@"Main Game Ball" withPosition:CGPointMake(main.position.x, main.position.y+35)];
    mainText.fontSize = 10;
    
    SKTexture *texture1 = [SKTexture textureWithImageNamed:@"MainBall1"];
    SKTexture *texture2 = [SKTexture textureWithImageNamed:@"MainBall3"];
    SKTexture *texture3 = [SKTexture textureWithImageNamed:@"MainBall2"];
    SKTexture *texture4 = [SKTexture textureWithImageNamed:@"MainBall5"];
    SKTexture *texture5 = [SKTexture textureWithImageNamed:@"MainBall4"];
    SKTexture *texture6 = [SKTexture textureWithImageNamed:@"MainBall6"];
    
    SKAction *rotateTextures = [SKAction animateWithTextures:@[texture1, texture2, texture3, texture4,texture5,texture6] timePerFrame:3];
    SKAction *repeatAction = [SKAction repeatActionForever:rotateTextures];
    
    [main runAction:repeatAction];
    
    
    SKSpriteNode *back = [sharedDelegate.customGUI defaultSKSprite:@"Back" withPosition:CGPointMake(100, 50) name:@"back"];
    
    SKNode *balls = [SKNode node];
    balls.zPosition = 15;
    SKNode *texts = [SKNode node];
    texts.zPosition = 5;
    
    [balls addChild:back];
    [balls addChild:blueball];
    [balls addChild:timeball];
    [balls addChild:bigball];
    [balls addChild:doublepoints];
    [balls addChild:poisonBall];
    [balls addChild:shrinkBall];
    [balls addChild:stickyball];
    [balls addChild:freezeball];
    [balls addChild:mainFreeze];
    [balls addChild:main];
    
    [texts addChild:bluetext];
    [texts addChild:timeText];
    [texts addChild:bigText];
    [texts addChild:doubleText];
    [texts addChild:poisonText];
    [texts addChild:shrinkText];
    [texts addChild:stickText];
    [texts addChild:freezeText];
    [texts addChild:mainFText];
    [texts addChild:mainText];
    
    [self addChild:texts];
    [self addChild:balls];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if([[self nodeAtPoint:location].name isEqualToString:@"back"]){
            HomeScreen *home = [[HomeScreen alloc]initWithSize:self.size];
            [self removeFromParent];
            [text removeFromSuperview];
            [self.view presentScene:home];
        }
        
        
    }
    

}

@end
