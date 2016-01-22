//
//  GameCenter.m
//  FlickBall
//
//  Created by Travis Delly on 10/11/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "GameCenter.h"
#import "AppDelegate.h"

@interface GameCenter ()

@property bool gameCenterEnabled;
@property NSString *leaderboardIdentifier;

@end

@implementation GameCenter{
    AppDelegate *sharedDelegate;
}

-(id)init{
    self = [super init];
    if (self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

-(void)reportScore{
    
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:_leaderboardIdentifier];
    score.value = sharedDelegate.score;
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            [self updateAchievements];
        }
    }];
}

-(void)resetAchievements{
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

-(void)addObjectToAchievements:(NSMutableArray*)achieveArray achievementID:(NSString*)identifier{
    GKAchievement *achievementA_1 = [[GKAchievement alloc]initWithIdentifier:identifier player:_localPlayer];
    achievementA_1.percentComplete = 100;
    
    [achieveArray addObject:achievementA_1];
}

-(void)updateAchievements{
    
    NSMutableArray *achievements = [[NSMutableArray alloc] init];
    
    sharedDelegate.score >= 8000 ? [self addObjectToAchievements:achievements achievementID:@"A_8"] : nil;
    sharedDelegate.score >= 5000 ? [self addObjectToAchievements:achievements achievementID:@"A_7"] : nil;
    sharedDelegate.score >= 2000 ? [self addObjectToAchievements:achievements achievementID:@"A_6"] : nil;
    sharedDelegate.score >= 1500 ? [self addObjectToAchievements:achievements achievementID:@"A_5"] : nil;
    sharedDelegate.score >= 1000 ? [self addObjectToAchievements:achievements achievementID:@"A_4"] : nil;
    sharedDelegate.score >= 500 ? [self addObjectToAchievements:achievements achievementID:@"A_3"] : nil;
    sharedDelegate.score >= 100 ? [self addObjectToAchievements:achievements achievementID:@"A_2"] : nil;
    sharedDelegate.score >= 50 ? [self addObjectToAchievements:achievements achievementID:@"A_1"] : nil;
    sharedDelegate.TimeBallsHit >= 10 ? [self addObjectToAchievements:achievements achievementID:@"B_1"] : nil;
    sharedDelegate.DoublePointsHit >= 5 ? [self addObjectToAchievements:achievements achievementID:@"B_2"] : nil;
    
    
    [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            NSLog(@"Achievements: %@", achievements);
        }
    }];
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard view:(UIViewController*)theView{
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = _leaderboardIdentifier;
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [theView presentViewController:gcViewController animated:YES completion:nil];
}


-(void)authenticateLocalPlayer:(UIViewController*)highscoreView{
    _localPlayer = [GKLocalPlayer localPlayer];
    
    _localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [highscoreView presentViewController:viewController animated:YES completion:nil];
        }else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                _gameCenterEnabled = YES;
                
                // Get the default leaderboard identifier.
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        _leaderboardIdentifier = leaderboardIdentifier;
                    }
                }];
            }else{
                _gameCenterEnabled = NO;
            }
        }
    };
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
