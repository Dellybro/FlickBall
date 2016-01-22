//
//  StickBall.h
//  FlickBall
//
//  Created by Travis Delly on 11/2/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BaseBall.h"

@interface StickBall : BaseBall

-(void)moveBall:(CGPoint)position1 :(CGPoint)position2;

-(void)ballHit;
-(instancetype)initForSixtyMode;


@end
