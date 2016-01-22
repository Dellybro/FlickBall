//
//  Utilities.m
//  FlickBall
//
//  Created by Travis Delly on 9/28/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "Utilities.h"
#import "AppDelegate.h"

@implementation Utilities{
    AppDelegate *sharedDelegate;
}

-(instancetype)init{
    self = [super init];
    if(self) {
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        _ArrayForMakeAPoint = [[NSMutableArray alloc] init];
    }
    return self;
}

-(CGPoint)makeAPointOffScreen{
    
    int decisionNumber = arc4random() % 2;
    if(decisionNumber % 2 == 0){
        return CGPointMake(-20, ((arc4random() % 450) + 200));
    } else {
        return CGPointMake(400, ((arc4random() % 450) + 200));
    }
    
}


-(void)pushBall:(SKSpriteNode*)ball{
    
    
    CGFloat changeX;
    CGFloat changeY;
    
    int decision = arc4random() * 10;
    if(decision % 3){
        changeX = 300.00f;
        changeY = 150;
        
    } else if( decision % 2){
        changeX = 200;
        changeY = 175;
        
    } else {
        changeX = 250;
        changeY = 125;
        
    }
    
    if(ball.position.x > 200){
        
        ball.physicsBody.velocity = CGVectorMake(-changeX, changeY);
        
    }else{
        ball.physicsBody.velocity = CGVectorMake(changeX, changeY);
        
    }
    
    SKAction *wait = [SKAction waitForDuration:10];
    SKAction *remove = [SKAction removeFromParent];
    
    SKAction *sequence = [SKAction sequence:@[wait, remove]];
    
    [ball runAction:sequence];
    
}

-(CGPoint)makeAPoint{
    CGPoint positionToReturn;
    int tryAgain = 1;
    while(tryAgain == 1){
        tryAgain = 0;
        
        int x = arc4random() % 295;
        x+=40;
        int y = arc4random() % 575;
        y+=50;
        
        positionToReturn = CGPointMake(x, y);
        NSValue *valueOfReturn = [NSValue valueWithCGPoint:positionToReturn];
        
        for (int x = 0; x < [_ArrayForMakeAPoint count]; x++) {
            
            if(valueOfReturn == [_ArrayForMakeAPoint objectAtIndex:x]){
                tryAgain = 1;
            }
        }
        if(tryAgain != 1){
            [_ArrayForMakeAPoint addObject:valueOfReturn];
        }
        
    }
    
    return positionToReturn;
}

-(void)gameBallContact:(SKPhysicsContact *)contact time:(SKLabelNode*)timer score:(SKLabelNode*)score mainball:(MainBall*)mainBall{
    //BodyB will always be CandyBallCategory.
    if(contact.bodyB.categoryBitMask == sharedDelegate.candyBallCategory && sharedDelegate.gameOver == 0){
        
        
        //This is where I am able to figure out the class
        if([contact.bodyB.node class] == [TimeBall class]){
            
            //Ball hit
            TimeBall *TB = (TimeBall*)contact.bodyB.node;
            [TB ballHit];
            
            [timer setText:[sharedDelegate timerString]];
            
        }else if([contact.bodyB.node class] == [PoisonBall class]){
            //Ball hit
            PoisonBall *PB = (PoisonBall*)contact.bodyB.node;
            [PB ballHit];
            
            //Set GUI
            [score setText:[sharedDelegate scoreString]];
            [timer setText:[sharedDelegate timerString]];
            
        } else if([contact.bodyB.node class] == [MovingBall class]){
            
            //Ball Hit
            MovingBall *MB = (MovingBall*)contact.bodyB.node;
            [MB ballHit];
            
            //Set GUI
            [score setText:[sharedDelegate scoreString]];
            
            //Check for super
            int makeSuperBall = sharedDelegate.MovingBallsHit;
            
            if(sharedDelegate.levelCount > 9){
                if(makeSuperBall % 15*sharedDelegate.levelCount*2 == 0){
                    mainBall.superMode = 1;
                    [mainBall mainBallChargeTexture];
                }
            } else {
                if(makeSuperBall % 40 == 0){
                    mainBall.superMode = 1;
                    [mainBall mainBallChargeTexture];
                }
            }
            
        } else if([contact.bodyB.node class] == [FreezeBall class]){
            //Ball hit
            FreezeBall *FB = (FreezeBall*)contact.bodyB.node;
            [FB ballHit];
            
            //Make Ball do something
            [mainBall freezeBall];
        } else if([contact.bodyB.node class] == [DoublePointBall class]){
            
            //Ball hit
            DoublePointBall *DPB = (DoublePointBall*)contact.bodyB.node;
            [DPB ballHit];
            
            //Make ball do something
            [mainBall multiplier];
        } else if([contact.bodyB.node class] == [BigBonusBall class]){
            
            //Ball hit
            BigBonusBall *BBB = (BigBonusBall*)contact.bodyB.node;
            [BBB ballHit];
            
            //Make Ball do something
            [mainBall growBall];
        }else if([contact.bodyB.node class] == [StickBall class]){
            
            //Ball hit
            StickBall *SB = (StickBall*)contact.bodyB.node;
            [SB ballHit];
            
            //Set GUI
            [score setText:[sharedDelegate scoreString]];
            
            //Make Ball do something
            mainBall.physicsBody.velocity = CGVectorMake(0, 0);
        }else if([contact.bodyB.node class] == [ShrinkBall class]){
            
            //Ball hit
            ShrinkBall *SB = (ShrinkBall*)contact.bodyB.node;
            [SB ballHit];
            
            //Make Ball do something
            [mainBall shrinkBall];
        }
    }

}


//Setup views
-(void)setupPause:(SKNode*)pauseHolder{
    //Check again make sure shareddelegate game isnt true
    if(sharedDelegate.gameOver == 0){
        //Unpause and Go Home
        //If unpause is clicked, will unpause the game, if go home is clicked will go to main Screen
        SKLabelNode *unpause = [sharedDelegate.customGUI defaultSKLabel:@"Unpause Game" withPosition:CGPointMake(pauseHolder.parent.scene.size.width/2, pauseHolder.parent.scene.size.height/2+30)];
        unpause.name = @"unpause";
        
        SKLabelNode *goHome = [sharedDelegate.customGUI defaultSKLabel:@"Go to Main Screen" withPosition:CGPointMake(pauseHolder.parent.scene.size.width/2, pauseHolder.parent.scene.size.height/2-30)];
        goHome.name = @"goHome";
        
        [pauseHolder addChild:goHome];
        [pauseHolder addChild:unpause];
    }
}

-(void)setupGameOver:(SKNode*)gameOverHolder scene:(SKScene*)gameScene{
    
    SKNode* rightBalls = [SKNode node];
    SKNode* leftBalls = [SKNode node];
    SKNode* fadeInGroup = [SKNode node];
    
    
    SKSpriteNode *gameOverBackground = [sharedDelegate.customGUI defaultSKSprite:@"GameOverbackground" withPosition:CGPointMake(gameScene.size.width/2, gameScene.size.height/2-20) name:@"gameOverBackGround"];
    gameOverBackground.zPosition = 3;
    gameOverBackground.size = CGSizeMake(320, 600);
    
    //Title
    SKLabelNode *gameOverLabel = [sharedDelegate.customGUI defaultSKLabel:@"Game Over" withPosition:CGPointMake(gameScene.size.width/2, gameScene.size.height/2+280)];
    
    //Button
    SKSpriteNode *playAgain = [sharedDelegate.customGUI defaultSKSprite:@"reset" withPosition:CGPointMake(gameScene.size.width/2+50, gameScene.size.height/2-150) name:@"playAgain"];
    playAgain.size = CGSizeMake(56, 56);
    
    SKSpriteNode *goHome = [sharedDelegate.customGUI defaultSKSprite:@"Back" withPosition:CGPointMake(gameScene.size.width/2-50, gameScene.size.height/2-150) name:@"goHome"];
    
    SKSpriteNode *goHighscores = [sharedDelegate.customGUI defaultSKSprite:@"SubmitScore" withPosition:CGPointMake(gameScene.size.width/2, gameScene.size.height/2+150) name:@"goHighscores"];
    
    //BallTextures Left Column
    SKSpriteNode *blueBall = [sharedDelegate.customGUI defaultSKSprite:@"blueBall" withPosition:CGPointMake(-100, gameScene.size.height/2-25) name:@"blue"];
    blueBall.size = CGSizeMake(30, 30);
    SKLabelNode *blueBallCount = [sharedDelegate.customGUI defaultSKLabel:[NSString stringWithFormat:@"x %i", sharedDelegate.MovingBallsHit] withPosition:CGPointMake(-50, gameScene.size.height/2-50)];
    
    SKSpriteNode *bigBonusBall = [sharedDelegate.customGUI defaultSKSprite:@"expandBall" withPosition:CGPointMake(-100, gameScene.size.height/2+75) name:@"big"];
    bigBonusBall.size = CGSizeMake(30, 30);
    SKLabelNode *bigBonusBallCount = [sharedDelegate.customGUI defaultSKLabel:[NSString stringWithFormat:@"x %i", sharedDelegate.BigBonusBallsHit] withPosition:CGPointMake(-50, gameScene.size.height/2+50)];
    
    SKSpriteNode *stickBall = [sharedDelegate.customGUI defaultSKSprite:@"stickBall" withPosition:CGPointMake(-100, gameScene.size.height/2-75) name:@"stick"];
    stickBall.size = CGSizeMake(30, 30);
    SKLabelNode *stickBallCount = [sharedDelegate.customGUI defaultSKLabel:[NSString stringWithFormat:@"x %i", sharedDelegate.StickyBallsHit] withPosition:CGPointMake(-50, gameScene.size.height/2-100)];
    
    SKSpriteNode *poisonBall =[sharedDelegate.customGUI defaultSKSprite:@"PoisonBall" withPosition:CGPointMake(-100, gameScene.size.height/2+25) name:@"poison"];
    poisonBall.size = CGSizeMake(30, 30);
    SKLabelNode *poisonBallCount = [sharedDelegate.customGUI defaultSKLabel:[NSString stringWithFormat:@"x %i", sharedDelegate.PoisonBallsHit] withPosition:CGPointMake(-50, gameScene.size.height/2)];
    
    //Right Side
    SKSpriteNode *timeBall = [sharedDelegate.customGUI defaultSKSprite:@"Timeball2" withPosition:CGPointMake(gameScene.size.width+100, gameScene.size.height/2-25) name:@"time"];
    timeBall.size = CGSizeMake(30, 30);
    SKLabelNode *TimeBallCount = [sharedDelegate.customGUI defaultSKLabel:[NSString stringWithFormat:@"%i x", sharedDelegate.TimeBallsHit] withPosition:CGPointMake(gameScene.size.width+50, gameScene.size.height/2-50)];
    SKSpriteNode *freezeBall = [sharedDelegate.customGUI defaultSKSprite:@"Freezeball" withPosition:CGPointMake(gameScene.size.width+100, gameScene.size.height/2+25) name:@"freeze"];
    freezeBall.size = CGSizeMake(30, 30);
    SKLabelNode *freezeBallCount = [sharedDelegate.customGUI defaultSKLabel:[NSString stringWithFormat:@"%i x", sharedDelegate.FreezeBallsHit] withPosition:CGPointMake(gameScene.size.width+50, gameScene.size.height/2)];
    SKSpriteNode *DoublePointsBall = [sharedDelegate.customGUI defaultSKSprite:@"RedBall" withPosition:CGPointMake(gameScene.size.width+100, gameScene.size.height/2+75) name:@"double"];
    DoublePointsBall.size = CGSizeMake(30, 30);
    SKLabelNode *DoublePointsCount = [sharedDelegate.customGUI defaultSKLabel:[NSString stringWithFormat:@"%i x", sharedDelegate.DoublePointsHit] withPosition:CGPointMake(gameScene.size.width+50, gameScene.size.height/2 + 50)];
    
    SKSpriteNode *shrinkBall = [sharedDelegate.customGUI defaultSKSprite:@"shrinkBall" withPosition:CGPointMake(gameScene.size.width+100, gameScene.size.height/2-75) name:@"shrink"];
    shrinkBall.size = CGSizeMake(30, 30);
    
    SKLabelNode *shrinkBallCount = [sharedDelegate.customGUI defaultSKLabel:[NSString stringWithFormat:@"%i x", sharedDelegate.ShrinkBallsHit] withPosition:CGPointMake(gameScene.size.width+50, gameScene.size.height/2-100)];
    
    
    //Add leftColumn
    [leftBalls addChild:blueBall];
    [leftBalls addChild:blueBallCount];
    [leftBalls addChild:bigBonusBall];
    [leftBalls addChild:bigBonusBallCount];
    [leftBalls addChild:stickBall];
    [leftBalls addChild:stickBallCount];
    [leftBalls addChild:poisonBall];
    [leftBalls addChild:poisonBallCount];
    
    //Add RightColumn
    [rightBalls addChild:timeBall];
    [rightBalls addChild:TimeBallCount];
    [rightBalls addChild:freezeBall];
    [rightBalls addChild:freezeBallCount];
    [rightBalls addChild:DoublePointsBall];
    [rightBalls addChild:DoublePointsCount];
    [rightBalls addChild:shrinkBall];
    [rightBalls addChild:shrinkBallCount];
    
    //Add Fade group
    [fadeInGroup addChild:goHighscores];
    [fadeInGroup addChild:goHome];
    [fadeInGroup addChild:gameOverBackground];
    [fadeInGroup addChild:playAgain];
    [fadeInGroup addChild:gameOverLabel];
    
    //Left and Right Ball actions
    SKAction *bringOutFromLeft = [SKAction moveByX:180 y:0 duration:.5];
    SKAction *bringOutFromRight = [SKAction moveByX:-180 y:0 duration:.5];
    
    for (int x = 0; x < 8; x++) {
        SKAction *wait = [SKAction waitForDuration:.2*x];
        
        [[[leftBalls children] objectAtIndex:x] runAction:[SKAction sequence:@[wait, bringOutFromLeft]]];
        [[[rightBalls children] objectAtIndex:x] runAction:[SKAction sequence:@[wait, bringOutFromRight]]];
    }
    
    
    //Fade in Actions
    fadeInGroup.alpha = 0.0;
    SKAction *changeAlpha = [SKAction fadeAlphaTo:1.0 duration:1];
    [fadeInGroup runAction:changeAlpha];
    
    [gameOverHolder addChild:rightBalls];
    [gameOverHolder addChild:leftBalls];
    [gameOverHolder addChild:fadeInGroup];
    
}

@end
