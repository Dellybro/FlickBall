//
//  CustomGUI.m
//  FlickBall
//
//  Created by Travis Delly on 10/9/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "CustomGUI.h"
#import "AppDelegate.h"

@implementation CustomGUI{
    AppDelegate *sharedDelegate;
}

-(SKSpriteNode*)defaultSKSprite:(NSString*)textureName withPosition:(CGPoint)position name:(NSString*)name{
    SKSpriteNode *skSprite = [SKSpriteNode spriteNodeWithImageNamed:textureName];
    skSprite.position = position;
    skSprite.name = name;
    skSprite.zPosition = 5;
    
    return skSprite;
}

-(SKNode*)defaultNode:(NSString*)name z:(int)position{
    SKNode *newNode = [SKNode node];
    newNode.name = name;
    newNode.zPosition = position;
    
    return newNode;
}

-(SKLabelNode*)defaultSKLabel:(NSString*)text withPosition:(CGPoint)position{
    SKLabelNode *LabelToReturn = [[SKLabelNode alloc] initWithFontNamed:@"Copperplate-Bold"];
    LabelToReturn.text = text;
    LabelToReturn.fontColor = [SKColor whiteColor];
    LabelToReturn.position = position;
    LabelToReturn.zPosition = 5;
    return LabelToReturn;
}
-(id)init{
    self = [super init];
    if (self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
    }
    return self;
}
-(UITextField*)defaultTextField:(NSString*)placeHolder{
    UITextField* textField = [[UITextField alloc] init];
    textField.layer.borderWidth = 1.0f;
    textField.layer.cornerRadius = 5.0f;
    textField.backgroundColor = [UIColor whiteColor];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.layer.masksToBounds = YES;
    textField.placeholder = placeHolder;
    
    
    return textField;
}

-(UILabel*)defaultLabel:(NSString*)text{
    
    UILabel *labelView = [[UILabel alloc] init];
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.font = [UIFont fontWithName:@"Copperplate-Bold" size:24];
    labelView.textColor = [UIColor blackColor];
    labelView.text = text;
    return labelView;
}
-(UIButton*)defaultButton:(NSString*)text{
    UIButton *defaultB = [[UIButton alloc] init];
    defaultB.layer.cornerRadius = 8.530f;
    defaultB.layer.masksToBounds = YES;
    defaultB.layer.borderWidth = 1.0f;
    
    [defaultB setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [defaultB setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateHighlighted];
    
    [defaultB setTitle:text forState:UIControlStateNormal];
    defaultB.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:18];
    return defaultB;
}

@end
