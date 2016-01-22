//
//  ShrinkBall.h
//  FlickBall
//
//  Created by Travis Delly on 11/2/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BaseBall.h"

@interface ShrinkBall : BaseBall

-(instancetype)init;

-(void)ballHit;
-(instancetype)initForSixtyMode;

@end
