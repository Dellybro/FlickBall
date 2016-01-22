//
//  CustomGUI.h
//  FlickBall
//
//  Created by Travis Delly on 10/9/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface CustomGUI : NSObject

-(UITextField*)defaultTextField:(NSString*)placeHolder;
-(SKNode*)defaultNode:(NSString*)name z:(int)position;
-(UIButton*)defaultButton:(NSString*)text;
-(UILabel*)defaultLabel:(NSString*)text;

-(SKLabelNode*)defaultSKLabel:(NSString*)text withPosition:(CGPoint)position;
-(SKSpriteNode*)defaultSKSprite:(NSString*)textureName withPosition:(CGPoint)position name:(NSString*)name;

@end
