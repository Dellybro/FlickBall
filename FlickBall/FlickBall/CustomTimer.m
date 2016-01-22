//
//  CustomTimer.m
//  FlickBall
//
//  Created by Travis Delly on 11/4/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "CustomTimer.h"

@implementation CustomTimer

NSDate *pauseStart, *previousFireDate;


-(void) pauseTimer {
    
    
    
    pauseStart = [NSDate dateWithTimeIntervalSinceNow:0];
    
    previousFireDate = [_thisTimer fireDate];
    
    [_thisTimer setFireDate:[NSDate distantFuture]];
}


-(void) resumeTimer {
    
    float pauseTime = -1*[pauseStart timeIntervalSinceNow];
    
    [_thisTimer setFireDate:[previousFireDate initWithTimeInterval:pauseTime sinceDate:previousFireDate]];
    
}

@end
