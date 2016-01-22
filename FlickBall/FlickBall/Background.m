//
//  Background.m
//  FlickBall
//
//  Created by Travis Delly on 10/30/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "Background.h"
#import "AppDelegate.h"

@implementation Background{
    AppDelegate *sharedDelegate;
}


-(instancetype)init{
    self = [super init];
    if(self){
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        if(sharedDelegate.backGroundChoice == 1){
            self.texture = [SKTexture textureWithImageNamed:@"background1"];
        }else if(sharedDelegate.backGroundChoice == 2){
            self.texture = [SKTexture textureWithImageNamed:@"background2"];
        }else if(sharedDelegate.backGroundChoice == 3){
            self.texture = [SKTexture textureWithImageNamed:@"background3"];
        }else if(sharedDelegate.backGroundChoice == 4){
            self.texture = [SKTexture textureWithImageNamed:@"background4"];
        }else if(sharedDelegate.backGroundChoice == 5){
            self.texture = [SKTexture textureWithImageNamed:@"background5"];
        }else if(sharedDelegate.backGroundChoice == 6){
            self.texture = [SKTexture textureWithImageNamed:@"background6"];
        }
        
        self.zPosition = 0;
    }
    return self;
}

-(void)changeBackground{
    int random = arc4random() % 6;
    
    SKTexture *newTexture = [self newBackground:random];
    
    
    if(random == 0 || newTexture == self.texture){
        [self changeBackground];
    }
    
    self.texture = [self newBackground:random];
}

-(SKTexture*)newBackground:(int)option{
    if(option == 1){
        return [SKTexture textureWithImageNamed:@"background1"];
    }else if(option == 2){
        return [SKTexture textureWithImageNamed:@"background2"];
    }else if(option == 3){
        return [SKTexture textureWithImageNamed:@"background3"];
    }else if(option == 4){
        return [SKTexture textureWithImageNamed:@"background4"];
    }else if(option == 5){
        return [SKTexture textureWithImageNamed:@"background5"];
    }else if(option == 6){
        return [SKTexture textureWithImageNamed:@"background6"];
    } else {
        return self.texture;
    }
}

@end
