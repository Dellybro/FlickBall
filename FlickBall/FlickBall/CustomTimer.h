//
//  CustomTimer.h
//  FlickBall
//
//  Created by Travis Delly on 11/4/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomTimer : NSObject


@property NSTimer* thisTimer;

-(void) pauseTimer;
-(void) resumeTimer;

@end

