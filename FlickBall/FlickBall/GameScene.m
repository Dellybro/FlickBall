//
//  GameScene.m
//  FlickBall
//
//  Created by Travis Delly on 9/27/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "GameScene.h"
#import "AppDelegate.h"
#import "Utilities.h"
#import "HomeScreen.h"
#import "Background.h"
#import "CustomTimer.h"

@interface GameScene()

@property SKNode *BallandObstacleIndefiniteHolder;
@property SKNode *pauseHolders;
@property SKNode *candyBalls;
@property SKNode *randomBalls;
@property SKNode *labelsDuringGame;
@property SKNode *gameOverHolder;
@property SKNode *bonusBalls;

@property NSMutableArray *TimerArray;

//timerExtras
@property SKLabelNode *timer;
@property SKLabelNode *score;


@end



@implementation GameScene{
    
    AppDelegate *sharedDelegate;
    CGPoint startLocation;
    Background *background;
}

/*Called when application is closed to pause all actions in gamescene*/
-(void)applicationDidEnterBackground:(UIApplication *)application{
    self.paused = YES;
}
-(void)applicationDidBecomeActive:(UIApplication *)application{
    self.paused = NO;
}

/*This is where background is created, maybe could use a better spot to instantiate the background.*/
-(instancetype)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        //ADD BACKGROUND [Could make background Animated]
        background = [[Background alloc] init];
        background.size = self.size;
        background.zPosition = 0;
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:background];
        
        //SETUP
        [self setup];
        
        
        self.physicsWorld.gravity = sharedDelegate.gameVelocity;
        
        [self makeCandy];
        
        
    }
    return self;
}

/*This is where most of the magic happens, makes bonus or random balls dependent on time*/
-(void)decreaseTime{
    if(sharedDelegate.time < 1){
        [self invalidateTimers];
        sharedDelegate.gameOver = 1;
        [sharedDelegate.utils setupGameOver:_gameOverHolder scene:self];
        
    } else {
        sharedDelegate.time--;
        sharedDelegate.time % 2 == 0 ? [self decideToMakeTimeBallorPoisionBall] : nil;
        sharedDelegate.time % 2 == 0 ? [self decideToMakeBonusBall] : nil;
        [_timer setText:[sharedDelegate timerString]];
    }
}

#pragma timers

/*This method could be replaced because the timers that were originally here are no longer used, instead the balls are made dependent on the time 
 */
-(void)startTimers{
    
    _TimerArray = [[NSMutableArray alloc] init];
    
    //Gametimers
    
    CustomTimer *gameTimer = [[CustomTimer alloc] init];
    gameTimer.thisTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decreaseTime) userInfo:nil repeats:YES];
    
    [_TimerArray addObject:gameTimer];
}
-(void)invalidateTimers{
    
    for (CustomTimer* timer in _TimerArray) {
        [timer.thisTimer invalidate];
    }
}

#pragma BallMake

/*Make candy after all candies have dissapeared*/
-(void)makeCandy{
        //MovingBallChoice
    
    for (int x = 0; x < 4*(sharedDelegate.count/2); x++) {
        
        int makeStick = arc4random() % 100;
        
        if(makeStick % 25 == 0){
            StickBall *stickBall = [[StickBall alloc] init];
            [_candyBalls addChild:stickBall];
        } else {
            MovingBall *movingBall = [[MovingBall alloc] init];
            [_candyBalls addChild:movingBall];
            [movingBall moveBall:[sharedDelegate.utils makeAPoint] :movingBall.position];
        }
    }
}

/*Iterates 3 times trying to make some sort of shrink(20) time(10) posion(9) or freeze ball(8)*/
-(void)decideToMakeTimeBallorPoisionBall{
    if(sharedDelegate.gameOver == 0){
        
        for (int x = 0; x < 3; x++) {
            
            int ballChoice = arc4random() % 100;
            
            if(ballChoice % 20 == 0){
                ShrinkBall *shrink = [[ShrinkBall alloc] init];
                [_randomBalls addChild:shrink];
                break;
            }else if(ballChoice % 10 == 0 && sharedDelegate.time < 30){
                //Timerball Choice
                TimeBall *timeBall = [[TimeBall alloc] init];
                [_randomBalls addChild:timeBall];
                break;
            }else if(ballChoice % 9 == 0){
                //PoisonBall Choice
                PoisonBall *pBall = [[PoisonBall alloc] init];
                [_randomBalls addChild:pBall];
                break;
            }else if(ballChoice % 8 == 0) {
                //FreezeBalls
                FreezeBall *freezeBall = [[FreezeBall alloc] init];
                [_randomBalls addChild:freezeBall];
                break;
            }
        }
    }
}
/*Same as last method, as long as game isn't over will continue to try to make double point of bigbonus ball, if the decision number is initially divisible by 10, a ball will be made, D*/
-(void)decideToMakeBonusBall{
    if(sharedDelegate.gameOver == 0){
        int decisionNumber = arc4random() % 100;
        if(decisionNumber % 10 == 0){
            if(decisionNumber % 3 == 0){
                
                DoublePointBall *dpb = [[DoublePointBall alloc] init];
                [_bonusBalls addChild:dpb];
            }else{
                
                BigBonusBall *bonusBall = [[BigBonusBall alloc] init];
                [_bonusBalls addChild:bonusBall];
            }
        }
        
    }
}


#pragma BallTouch
/* Utilies take care of most of this, but after utilities finishes, the game checks to see if the next level is
 * ready
 */
-(void)didBeginContact:(SKPhysicsContact *)contact{
    [sharedDelegate.utils gameBallContact:contact time:_timer score:_score mainball:_ball];
    
    if(_candyBalls.children.count == 0){
        
        
        
        sharedDelegate.levelCount++;
        sharedDelegate.count++;
        sharedDelegate.time+=3;
        _timer.text = [sharedDelegate timerString];;
        [_randomBalls removeAllChildren];
        
        [background changeBackground];
        
        sharedDelegate.utils.ArrayForMakeAPoint = [[NSMutableArray alloc] init];
        
        [self makeCandy];
    }
}
/* These methods are for swiping
 * There is a pan gesture for the movment of the ball, and than the tap gesture for pausing
 */
-(void)didMoveToView:(SKView *)view{
    UIPanGestureRecognizer *swipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:swipe];
    
    UITapGestureRecognizer *pause = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pause:)];
    pause.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:pause];
}
-(void)pause:(UITapGestureRecognizer*)sender{
    if(sharedDelegate.gameOver == 0 && sharedDelegate.gamePaused == 0){
        sharedDelegate.gamePaused = 1;
        self.physicsWorld.speed = 0;
        _BallandObstacleIndefiniteHolder.paused = YES;
        
        [sharedDelegate.utils setupPause:_pauseHolders];
        
        //[self invalidateTimers];
        for (CustomTimer* timer in _TimerArray) {
            [timer pauseTimer];
        }
    }
    
}
-(void)unpause{
    sharedDelegate.gamePaused = 0;
    self.physicsWorld.speed = 1;
    _BallandObstacleIndefiniteHolder.paused = NO;
    
    [_pauseHolders removeAllChildren];
    
//    [self startTimers];
    for (CustomTimer* timer in _TimerArray) {
        [timer resumeTimer];
    }
}

- (void)panGesture:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        startLocation = [sender locationInView:self.view];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint stopLocation = [sender locationInView:self.view];
        CGFloat dx = stopLocation.x - startLocation.x;
        CGFloat dy = stopLocation.y - startLocation.y;
        [_ball moveBall:dx :dy];
    }
}

/* These are mostly used for after game buttons but, the charged ball is stuck along in this method, because its
 * tap event
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch* touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        if([[self nodeAtPoint:location].name isEqualToString:@"ball"]){
            //Stop the Ball if touched.
            [_ball stopBall:_score];
            [[_candyBalls children] count] == 0 ? [self makeCandy] : nil;
            
        } else if ([[self nodeAtPoint:location].name isEqualToString:@"playAgain"]){
            [self reSetupGame];
            //Method Right underneath this one
        } else if ([[self nodeAtPoint:location].name  isEqualToString:@"goHome"]){
            [self goHome];
        } else if ([[self nodeAtPoint:location].name  isEqualToString:@"goHighscores"]){
            [self goHighscore];
        } else if ([[self nodeAtPoint:location].name  isEqualToString:@"unpause"]){
            [self unpause];
        }
    }
}

-(void)goHighscore{
    [sharedDelegate.gameCenter reportScore];
    [sharedDelegate.gameCenter showLeaderboardAndAchievements:YES view:self.view.window.rootViewController];
    //Or instantiate any controller from the storyboard with an indentifier
}

-(void)goHome{
    [self removeFromParent];
    HomeScreen *scene = [[HomeScreen alloc] initWithSize:self.size];
    
    [self.view presentScene:scene];
}


#pragma  Setups
//After game, ReSetup stuff
-(void)reSetupGame{

    [sharedDelegate setupGameStuff];
    background.texture = [background newBackground:sharedDelegate.backGroundChoice];
    
    
    [_candyBalls removeAllChildren];
    [_randomBalls removeAllChildren];
    
    
    [self makeCandy];
    
    [_ball resetBall:CGPointMake(self.size.width/2, self.size.height/2)];
    _ball.zPosition = 15;
    
    
    [_score setText:[sharedDelegate scoreString]];
    
    //Timers
    [_timer setText:[sharedDelegate scoreString]];
    
    [_gameOverHolder removeAllChildren];
    
    
    [self startTimers];
}

/*Initial game setup most stuff is done in sharedDelegate, because a lot of variables are coming from the Delegate*/
-(void)setup{
    
    [sharedDelegate setupGameStuff];
    
    //CSetupHolders
    _BallandObstacleIndefiniteHolder = [sharedDelegate.customGUI defaultNode:@"indefinite" z:5];
    
    _gameOverHolder = [sharedDelegate.customGUI defaultNode:@"gameOverHolder" z:15];
    _pauseHolders = [sharedDelegate.customGUI defaultNode:@"pauseHolder" z:15];
    _labelsDuringGame = [sharedDelegate.customGUI defaultNode:@"duringGameLabels" z:5];
    _candyBalls = [sharedDelegate.customGUI defaultNode:@"candy" z:3];
    _randomBalls = [sharedDelegate.customGUI defaultNode:@"random" z:2];
    _bonusBalls = [sharedDelegate.customGUI defaultNode:@"bonus" z:4];
    
    //Score and Timer
    _score = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    [_score setText:[sharedDelegate scoreString]];
    _score.position = CGPointMake(self.size.width/2+150, self.size.height/1.1);
    
    _timer = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    [_timer setText:[sharedDelegate timerString]];
    _timer.position = CGPointMake(self.size.width/2-150, self.size.height/1.1);
    
    [_labelsDuringGame addChild:_timer];
    [_labelsDuringGame addChild:_score];
    
    //Gametimers
    
    //Self frame and contactDelegate
    self.physicsWorld.contactDelegate = self;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = sharedDelegate.wallCategory;
    self.physicsBody.collisionBitMask = sharedDelegate.mainBallCategory;
    
    //Make Human Ball
    _ball = [[MainBall alloc] initWithPosition:CGPointMake(self.size.width/2, self.size.height/2)];
    
    
    //BonusBallTimer
    
    [_BallandObstacleIndefiniteHolder addChild:_bonusBalls];
    [_BallandObstacleIndefiniteHolder addChild:_randomBalls];
    [_BallandObstacleIndefiniteHolder addChild:_candyBalls];
    [_BallandObstacleIndefiniteHolder addChild:_ball];
    
    
    [self addChild:_pauseHolders];
    [self addChild:_gameOverHolder];
    [self addChild:_labelsDuringGame];
    [self addChild:_BallandObstacleIndefiniteHolder];
    
    
    [self startTimers];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
