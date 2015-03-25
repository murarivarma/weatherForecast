//
//  WebServices.m
//  WeatherForecast
//
//  Created by Murari Varma on 18/02/15.
//  Copyright (c) 2015 murarivarma. All rights reserved.
//

#import "WebServices.h"



@implementation WebServices

+ (instancetype)sharedInstance {
    static WebServices *instance = nil;
    static dispatch_once_t MYToken;
    dispatch_once(&MYToken, ^{
        instance = [[WebServices alloc]init];
    });
    return instance;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        
        
        _manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://api.openweathermap.org/"]];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (void)getData:(void (^)(NSArray *jsonDataArray, NSError *))complete {
    _appDelegate = [[UIApplication sharedApplication]delegate];
    //NSString *path = @"data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=14";
    NSString *hello = [NSString stringWithFormat:@"data/2.5/forecast/daily?q=%@&mode=json&units=metric&cnt=14",_appDelegate.cityNameString];
    //NSLog(@"dhjgfjhbdfjhbhsdsh ---------%@",_appDelegate.cityNameString);
    [self.manager GET:hello parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complete) {
            complete(responseObject[@"list"],nil);
            //NSLog(@"response obj -- %@",responseObject);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (complete) {
            complete(nil,error);
        }
    }];
}

@end

