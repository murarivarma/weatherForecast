//
//  ViewController.h
//  WeatherForecast
//
//  Created by Murari Varma on 18/02/15.
//  Copyright (c) 2015 murarivarma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate> {
    UITextField *cityTextField;
}

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) AppDelegate *appDelegate;

@property (strong, nonatomic) IBOutlet UILabel *cityNameLabel;

@property (strong, nonatomic) IBOutlet UITableView *forecastTableView;
- (IBAction)addCityButtonAction:(id)sender;

@property (strong, nonatomic) NSMutableArray *cityNamesArray;
@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong, nonatomic) NSMutableArray *weatherDataArray;
@property (strong, nonatomic) NSMutableArray *supportingArray;

@end

