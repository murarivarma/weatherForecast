//
//  DetailWeatherTableViewController.h
//  WeatherForecast
//
//  Created by Murari Varma on 25/03/15.
//  Copyright (c) 2015 murarivarma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailWeatherTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray * weatherDataArray;
@property (nonatomic, strong) NSMutableArray * supportKeysArray;
@property int clickedIndex;
@property (nonatomic,strong) NSMutableArray *weatherArray;

@end
