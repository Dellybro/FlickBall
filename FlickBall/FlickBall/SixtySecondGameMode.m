//
//  SixtySecondGameMode.m
//  FlickBall
//
//  Created by Travis Delly on 10/30/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "SixtySecondGameMode.h"
#import "AppDelegate.h"
#import "HomeScreen.h"
#import "Background.h"

#import "CustomTimer.h"

@interface SixtySecondGameMode()

@property SKNode *pauseHolders;
@property SKNode *BallandObstacleIndefiniteHolder;
@property SKNode *obstacleHolders;
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

@implementation SixtySecondGameMode{
    AppDelegate *sharedDelegate;
    CGPoint startLocation;
}

/*If enter background move pause self, which pauses all processes*/
-(void)applicationDidEnterBackground:(UIApplication *)application{
    self.paused = YES;
}
-(void)applicationDidBecomeActive:(UIApplication *)application{
    self.paused = NO;
}

/*Add background and setup the game, and set the gravity = to sharedDelegate game velocity AFTER setup*/
-(instancetype)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    if(self){
        
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        //ADD BACKGROUND [Could make background Animated]
        Background *background = [[Background alloc] init];
        background.size = self.size;
        background.zPosition = 0;
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:background];
        
        //SETUP
        [self setup];
        
        
        self.physicsWorld.gravity = sharedDelegate.gameVelocity;
    }
    return self;
    
}

#pragma Make Candy and Obstacles

/*Make random ball dependent on a random number from 1-20, divisible by 9 shrink ball, 7 poison, 5 freeze*/
-(void)makeRandomBall{
    
    int decision = arc4random() % 20;
    if(decision % 9 == 0){
        ShrinkBall *shrink = [[ShrinkBall alloc] initForSixtyMode];
        [_randomBalls addChild:shrink];
    }else if(decision % 7 == 0){
        PoisonBall *poison = [[PoisonBall alloc] initForSixtyMode];
        [_randomBalls addChild:poison];
    } else if ( decision % 5 == 0){
        
        FreezeBall *freeze = [[FreezeBall alloc] initForSixtyMode];
        [_randomBalls addChild:freeze];
    }
    
}

/*Make bonus ball dependent on a random number from 1-20, divisible by 5 expanding ball, 4 multiplier ball*/
-(void)makeBonusBalls{
    int decision = arc4random() % 10;
    
    if(decision % 5){
        BigBonusBall *BigBall = [[BigBonusBall alloc] init];
        [_bonusBalls addChild:BigBall];
    } else if ( decision % 4){
        DoublePointBall *doubleball = [[DoublePointBall alloc] init];
        [_bonusBalls addChild:doubleball];
    }
}
/*If the time is divisible by 15, an obstacle will be made*/
-(void)makeObstacles{
    Obstacle *newObstacle = [[Obstacle alloc] init:CGPointMake(85, 133)];
    
    [_obstacleHolders addChild:newObstacle];
}
//Making candies
-(void)makeCandy{
    
    int decision = arc4random() % 100;
    
    int counter;
    if(decision % 4 == 0){
        counter = 5;
    }else if(decision % 3 == 0){
        counter = 4;
    }else if(decision % 2 == 0){
        counter = 3;
    } else {
        counter = 2;
    }
    
    if(decision % 5 == 3){
        if(decision % 4 == 0){
            PoisonBall *PB = [[PoisonBall alloc] initForSixtyMode];
            [_randomBalls addChild:PB];
        }else if(decision % 3 == 0){
            DoublePointBall *DPB = [[DoublePointBall alloc] init];
            [_bonusBalls addChild:DPB];
        }else{
            BigBonusBall *BBB = [[BigBonusBall alloc] init];
            [_bonusBalls addChild:BBB];
        }
    }
    for (int x = 0; x < counter; x++) {
        
        int makeStick = arc4random() % 100;
        
        if(makeStick % 25 == 0){
            StickBall *stickBall = [[StickBall alloc] initForSixtyMode];
            [_candyBalls addChild:stickBall];
        } else {
            MovingBall *mainPointsBall = [[MovingBall alloc] initForSixtyMode];
            [_candyBalls addChild:mainPointsBall];
        }
        
    }
}

#pragma timers
/*Start timers, this originally started mutliple timers, but i found a better way to do it with a single timer.
* Might be a good idea to get rid of the array, and just use gametimer, maybe even get rid of the methods 
* Invalidate timers goes with this method invalidaitng the timer.
*/
-(void)startTimers{
    
    _TimerArray = [[NSMutableArray alloc] init];
    
    CustomTimer* gameTimer = [[CustomTimer alloc] init];
    gameTimer.thisTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decreaseTime:) userInfo:nil repeats:YES];
    //Gametimers
    
    [_TimerArray addObject:gameTimer];
}
-(void)invalidateTimers{
    
    for (CustomTimer* timer in _TimerArray) {
        [timer.thisTimer invalidate];
    }
}

/* This method was rather obnoxious but basically if the game isnt over than the game is paused, speed set to 0
 * Pause all balls, and than pause the gametimer, unpause is basically the opposite of this method
 */
-(void)pause:(UITapGestureRecognizer*)sender{
    
    if(sharedDelegate.gameOver == 0 && sharedDelegate.gamePaused == 0){
        sharedDelegate.gamePaused = 1;
        
        self.physicsWorld.speed = 0;
        _BallandObstacleIndefiniteHolder.paused = YES;
        
        [sharedDelegate.utils setupPause:_pauseHolders];
        
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
    
    for (CustomTimer* timer in _TimerArray) {
        [timer resumeTimer];
    }
}


/*This is the method that does it all, makes the balls dependent on time*/
-(void)decreaseTime:(NSTimer*)sender{
    if(sharedDelegate.time < 1){
        [self invalidateTimers];
        sharedDelegate.gameOver = 1;
        [sharedDelegate.utils setupGameOver:_gameOverHolder scene:self];
        
    } else {
        sharedDelegate.time--;
        sharedDelegate.time % 15 == 0 ? [self makeObstacles] : nil;
        sharedDelegate.time % 10 == 0 ? [self makeBonusBalls] : nil;
        sharedDelegate.time % 5 == 0 ? [self makeRandomBall] : nil;
        sharedDelegate.time % 2 == 0 ? [self makeCandy] : nil;
        [_timer setText:[sharedDelegate timerString]];
    }
}

#pragma swipe
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

#pragma ballContacts

/*Utilities file has the code for this Make it easier to do more things after contact as been delegated*/
-(void)didBeginContact:(SKPhysicsContact *)contact{
    [sharedDelegate.utils gameBallContact:contact time:_timer score:_score mainball:_ball];
}

//setups


//Game resetup stuff
-(void)reSetupGame{
    
    [self startTimers];
    
    [sharedDelegate setupGameStuff];
    sharedDelegate.time = 60;
    
    [_candyBalls removeAllChildren];
    [_randomBalls removeAllChildren];
    [_obstacleHolders removeAllChildren];
    
    
    [_ball resetBall:CGPointMake(self.size.width/2, self.size.height/2)];
    _ball.zPosition = 15;
    
    
    [_score setText:[sharedDelegate scoreString]];
    
    //Timers
    [_timer setText:[sharedDelegate timerString]];
    
    
    [_gameOverHolder removeAllChildren];
}


//Game Initital setup
-(void)setup{
    
    //Shared Delegate stuff for Game
    [sharedDelegate setupGameStuff];
    sharedDelegate.time = 60;
    
    //CSetupHolders
    _BallandObstacleIndefiniteHolder = [sharedDelegate.customGUI defaultNode:@"indefinite" z:5];
    
    _obstacleHolders = [sharedDelegate.customGUI defaultNode:@"obstacle" z:5];
    _gameOverHolder = [sharedDelegate.customGUI defaultNode:@"gameOverHolder" z:15];
    _pauseHolders = [sharedDelegate.customGUI defaultNode:@"pauseHolder" z:15];
    _labelsDuringGame = [sharedDelegate.customGUI defaultNode:@"duringGameLabels" z:5];
    _candyBalls = [sharedDelegate.customGUI defaultNode:@"candy" z:3];
    _randomBalls = [sharedDelegate.customGUI defaultNode:@"random" z:2];
    _bonusBalls = [sharedDelegate.customGUI defaultNode:@"bonus" z:4];
    
    //Score and Timer Labels during game
    
    _score = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    [_score setText:[sharedDelegate scoreString]];
    _score.position = CGPointMake(self.size.width/2+150, self.size.height/1.1);
    
    _timer = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    [_timer setText:[sharedDelegate timerString]];
    _timer.position = CGPointMake(self.size.width/2-150, self.size.height/1.1);
    
    [_labelsDuringGame addChild:_timer];
    [_labelsDuringGame addChild:_score];
    
    //Self frame and contactDelegate
    self.physicsWorld.contactDelegate = self;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = sharedDelegate.wallCategory;
    self.physicsBody.collisionBitMask = sharedDelegate.mainBallCategory;
    
    //Make Human Ball
    _ball = [[MainBall alloc] initWithPosition:CGPointMake(self.size.width/2, self.size.height/2)];
    
    
    [self addChild:_pauseHolders];
    [self addChild:_labelsDuringGame];
    [self addChild:_gameOverHolder];
    
    [_BallandObstacleIndefiniteHolder addChild:_obstacleHolders];
    [_BallandObstacleIndefiniteHolder addChild:_bonusBalls];
    [_BallandObstacleIndefiniteHolder addChild:_randomBalls];
    [_BallandObstacleIndefiniteHolder addChild:_candyBalls];
    [_BallandObstacleIndefiniteHolder addChild:_ball];
    
    [self addChild:_BallandObstacleIndefiniteHolder];
    [self startTimers];
    
}

@end
