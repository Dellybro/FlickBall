//
//  BaseBall.m
//  FlickBall
//
//  Created by Travis Delly on 11/2/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "BaseBall.h"

@implementation BaseBall

-(instancetype)initWithTexture:(SKTexture *)texture{
    self = [super initWithTexture:texture];
    if(self){
        _count = 1;
    }
    return self;
}

@end
