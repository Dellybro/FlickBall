//
//  TimeBall.h
//  FlickBall
//
//  Created by Travis Delly on 9/28/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BaseBall.h"

@interface TimeBall : BaseBall

-(instancetype)init;

-(void)ballHit;
-(instancetype)initForSixtyMode;

@end
