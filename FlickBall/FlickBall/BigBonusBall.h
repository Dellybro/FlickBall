//
//  BigBonusBall.h
//  FlickBall
//
//  Created by Travis Delly on 10/3/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BaseBall.h"

@interface BigBonusBall : BaseBall

-(instancetype)initForTutorial:(CGPoint)position;
-(instancetype)init;



-(void)ballHit;

@end
