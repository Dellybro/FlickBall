//
//  GameViewController.m
//  FlickBall
//
//  Created by Travis Delly on 9/27/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "HomeScreen.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}

-(void)toggleBanner{
    if(bannerIsVisible == true){
        bannerIsVisible = false;
        [adView removeFromSuperview];
        
    }else{
        bannerIsVisible = true;
        [self.view addSubview:adView];
    }
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"failed");
}
-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Loaded");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 320, 50)];
    adView.delegate = self;
    bannerIsVisible = false;
    
    NSTimer *bannerTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(toggleBanner) userInfo:nil repeats:YES];
    NSLog(@"%@", bannerTimer);
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    HomeScreen *scene = [HomeScreen unarchiveFromFile:@"HomeScreen"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
