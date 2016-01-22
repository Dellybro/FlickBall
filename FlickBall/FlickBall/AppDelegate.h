//
//  AppDelegate.h
//  FlickBall
//
//  Created by Travis Delly on 9/27/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>
#import <CoreData/CoreData.h>

#import "Obstacle.h"

//Ball imports

#import "TimeBall.h"
#import "MovingBall.h"
#import "PoisonBall.h"
#import "FreezeBall.h"
#import "DoublePointBall.h"
#import "BigBonusBall.h"
#import "StickBall.h"
#import "ShrinkBall.h"


//Other Imports
#import "HTTPHelper.h"
#import "CustomGUI.h"
#import "Utilities.h"
#import "GameCenter.h"
#import "MainBall.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property NSManagedObject *currenUser;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//custom stuff

-(void)setupGameStuff;
-(void)checkForHigherScore:(double)newScore;
-(int)fetchNSUser;

@property int32_t candyBallCategory;
@property  int32_t mainBallCategory;
@property  int32_t wallCategory;
@property  int32_t obstacleCategory;

@property int ballChoice;
@property int backGroundChoice;

@property HTTPHelper *DatabaseReceiver;
@property CustomGUI *customGUI;

@property GameCenter *gameCenter;
@property Utilities *utils;


@property CGVector gameVelocity;
@property int time;
@property int levelCount;
@property NSDate *start;
@property int gameOver;
@property int score;
@property int count;
@property int multiplier;
@property int gamePaused;
@property int TimeBallsHit;
@property int FreezeBallsHit;
@property int BigBonusBallsHit;
@property int MovingBallsHit;
@property int PoisonBallsHit;
@property int DoublePointsHit;
@property int StickyBallsHit;
@property int ShrinkBallsHit;
@property int firstTime;

-(NSString*)scoreString;
-(NSString*)timerString;

@end

