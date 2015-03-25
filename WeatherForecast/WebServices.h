//
//  WebServices.h
//  WeatherForecast
//
//  Created by Murari Varma on 18/02/15.
//  Copyright (c) 2015 murarivarma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AFNetworking.h"

@interface WebServices : NSObject


@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) AppDelegate *appDelegate;
+ (instancetype)sharedInstance;
- (void)getData:(void(^)(NSArray *jsonDataArray, NSError *error))complete;

@property (strong, nonatomic) NSString *cityNameInWebService;
@end
