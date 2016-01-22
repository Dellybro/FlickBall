//
//  FreezeBall.h
//  FlickBall
//
//  Created by Travis Delly on 10/2/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BaseBall.h"

@interface FreezeBall : BaseBall

-(instancetype)init;

-(void)ballHit;
-(instancetype)initForSixtyMode;
@end
