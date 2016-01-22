//
//  GameCenter.h
//  FlickBall
//
//  Created by Travis Delly on 10/11/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
@interface GameCenter : NSObject <GKGameCenterControllerDelegate>

@property GKLocalPlayer *localPlayer;

-(void)reportScore;
-(void)authenticateLocalPlayer:(UIViewController*)highscoreView;
-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard view:(UIViewController*)theView;

@end
