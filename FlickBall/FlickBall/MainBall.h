//
//  MainBall.h
//  FlickBall
//
//  Created by Travis Delly on 9/27/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MainBall : SKSpriteNode

-(instancetype)initWithPosition:(CGPoint)position;
-(void)moveBall:(CGFloat)Dx :(CGFloat)Dy;
-(void)resetBody;
-(void)freezeBall;
-(void)multiplier;
-(void)growBall;
-(void)stopBall:(SKLabelNode*)scoreLabel;
-(void)shrinkBall;
-(void)resetBall:(CGPoint)position;
@property int movement;

-(void)mainBallChargeTexture;

@property int superMode;

@end
