//
//  Background.h
//  FlickBall
//
//  Created by Travis Delly on 10/30/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Background : SKSpriteNode

-(SKTexture*)newBackground:(int)option;
-(void)changeBackground;

@end
