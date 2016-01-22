//
//  HTTPHelper.m
//  FlickBall
//
//  Created by Travis Delly on 10/9/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "HTTPHelper.h"
#import "AppDelegate.h"

@interface HTTPHelper()

@property NSString* baseURL;
@property NSString* testURL;

@end

@implementation HTTPHelper{
    AppDelegate *sharedDelegate;
}
//
//-(instancetype)init{
//    self = [super init];
//    if(self){
//    
//        
//        sharedDelegate = [[UIApplication sharedApplication] delegate];
//        _baseURL = @"https://safe-mountain-2898.herokuapp.com/api/v1/static";
//        _testURL = @"http://localhost:3000/api/v1/static";
//        
//    }
//    return self;
//}
//
//-(NSMutableDictionary*)postMethod:(NSString*)post updateKey:(NSString*)updateKey action:(NSString*)action{
//    NSString* finalURL;
//    
//    finalURL = [NSString stringWithFormat:@"%@/%@", _testURL, action];
//    
//    //setup request using mutableurlrequest
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:finalURL]];
//    
//    //setup postdata
//    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
//    
//    //set request
//    [request setHTTPMethod:@"POST"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPBody:postData];
//    
//    if(!(updateKey == nil)){
//        NSString *authValue = [NSString stringWithFormat:@"Token %@", updateKey];
//        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
//    }
//    
//    //Make REQUEST
//    
//    NSHTTPURLResponse * response = nil;
//    NSError * error = nil;
//    
//    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    //return status codes.
//    if(error == nil){
//        NSError *jsonError;
//        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data
//                                                                    options:NSJSONReadingMutableContainers
//                                                                      error:&jsonError];
//        
//    
//        NSLog(@"%@", json);
//        return json;
//    } else {
//        return 0;
//    }
//}
//-(id)getMethod:(NSString*)method action:(NSString*)action{
//    NSString *finalURL;
//    
//    finalURL = [NSString stringWithFormat:@"%@/%@", _testURL, method];
//    
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:finalURL]];
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    
//    
//    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
//    if(error == nil){
//        NSError *jsonError;
//        NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
//        return json;
//    }
//    
//    return nil;
//    
//}



@end
