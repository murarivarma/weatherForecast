//
//  ViewController.m
//  WeatherForecast
//
//  Created by Murari Varma on 18/02/15.
//  Copyright (c) 2015 murarivarma. All rights reserved.
//

#import "ViewController.h"
#import "DetailWeatherTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadingData];
     _cityNamesArray = [[NSMutableArray alloc]init];
    _weatherDataArray = [[NSMutableArray alloc]init];
    _supportingArray = [[NSMutableArray alloc]initWithObjects:@"Day 0", @"Day 1", @"Day 2", @"Day 3", @"Day 4", @"Day 5", @"Day 6", @"Day 7", @"Day 8", @"Day 9", @"Day 10", @"Day 11", @"Day 12", @"Day 13",nil];
    _forecastTableView.delegate = self;
    _forecastTableView.dataSource = self;
    

    [[WebServices sharedInstance]getData:^(NSArray *jsonDataArray, NSError *error) {
        //NSLog(@"Dictionary is %@",jsonDataDictionary);
    }];
    
}

/*- (void)loadingData {
    _cityNamesArray = [[NSMutableArray alloc]init];
    [_cityNamesArray addObject:@"Hyderabad"];
    _cityNameString = @"Delhi";
    _appDelegate = [[UIApplication sharedApplication]delegate];
    
    _appDelegate.cityNameString = _cityNameString;
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)jsonDataCall {
    NSDictionary * returnDictionary = [[NSDictionary alloc]init];
    [[WebServices sharedInstance]getData:^(NSArray *jsonDataArray, NSError *error) {
        //NSLog(@"Dictionary is %@",jsonDataDictionary);
    }];
    return returnDictionary;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //NSLog(@"NO of ROWS in TV ----- %lu",(unsigned long)[_cityNamesArray count]);
    return [_cityNamesArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *cityName;
    NSString *cityName1;
    NSString *cityName2;
    
    if ([_cityNamesArray count] != 0) {
        cityName= [[_cityNamesArray objectAtIndex:indexPath.row]lowercaseString];
        cityName1 = [[cityName substringWithRange:NSMakeRange(0, 1)]uppercaseString];
        cityName2 = [cityName substringWithRange:NSMakeRange(1, [cityName length]-1)];
    }
    
    
    UILabel *cityNameLabelInCell = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 170, 30)];
    [cell.contentView addSubview:cityNameLabelInCell];
    cityNameLabelInCell.text = [cityName1 stringByAppendingString:cityName2];
    cityNameLabelInCell.backgroundColor = [UIColor redColor];
    
    UILabel *weatherLabelInCell = [[UILabel alloc]initWithFrame:CGRectMake(180, 10, 170, 30)];
    [cell.contentView addSubview:weatherLabelInCell];
    weatherLabelInCell.backgroundColor = [UIColor greenColor];
    weatherLabelInCell.text = [[[[_weatherDataArray objectAtIndex:indexPath.row] objectAtIndex:0] objectForKey:@"Day 0"] objectAtIndex:0];
    
    
    return cell;
}


- (IBAction)addCityButtonAction:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc]
                           initWithTitle:@"Title"
                           message:nil
                           delegate:self
                           cancelButtonTitle:nil
                           otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    cityTextField = [alert textFieldAtIndex:0];
    cityTextField.placeholder =@"Title";
    [alert show];
    cityTextField.delegate = self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField becomeFirstResponder];
    self.title = cityTextField.text;
    [_forecastTableView reloadData];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    NSString *string  = [cityTextField.text lowercaseString];
    _appDelegate = [[UIApplication sharedApplication]delegate];
    
    _appDelegate.cityNameString = string;
    
    
    
    _activity = [[UIActivityIndicatorView alloc]init];
    _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _activity.color = [UIColor redColor];
    _activity.frame = CGRectMake(150, 300, 50, 50);
    [_activity startAnimating];
    [self.view addSubview:_activity];
    [[WebServices sharedInstance]getData:^(NSArray *jsonDataArray, NSError *error) {
        [_activity stopAnimating];
        //NSLog(@"Dictionary is -----------------------000000000000000000000000------------- %@",jsonDataArray);
        if (jsonDataArray == nil) {
        } else {
            [_cityNamesArray addObject:string];
            //NSLog(@"ARRAy -- --- %@",_cityNamesArray);
            //NSLog(@"ARRA-----here   -------- %@",[[[jsonDataArray objectAtIndex:0]objectForKey:@"temp"]objectForKey:@"min"]);
            NSMutableArray *theDataArray = [[NSMutableArray alloc]init];
            for (int i=0; i<[jsonDataArray count]; i++) {
                NSMutableArray *dayData = [[NSMutableArray alloc]init];
                NSString * minTemp = [[[jsonDataArray objectAtIndex:i]objectForKey:@"temp"]objectForKey:@"min"];
                NSString *maxTemp = [[[jsonDataArray objectAtIndex:i]objectForKey:@"temp"]objectForKey:@"max"];
                //NSLog(@"NNNNNNN --------------- string appending %@ | %@",minTemp, maxTemp);
                
                [dayData addObject:[NSString stringWithFormat:@"%@ | %@",minTemp,maxTemp]];
                NSDictionary * theData = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:dayData, nil] forKeys:[NSArray arrayWithObjects:[NSString stringWithFormat:@"Day %d",i], nil]];
                [theDataArray addObject:theData];
                
            }[_weatherDataArray addObject:theDataArray];
            [_forecastTableView reloadData];
            
        }
        
    }];
    
    [_forecastTableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailWeatherTableViewController * detailWeatherTVC  =[self.storyboard instantiateViewControllerWithIdentifier:@"detailWeatherData"];
    detailWeatherTVC.weatherDataArray = _weatherDataArray;
    detailWeatherTVC.supportKeysArray = _supportingArray;
    detailWeatherTVC.clickedIndex = indexPath.row;
    //[self.navigationController pushViewController:detailWeatherTVC animated:YES];
    [self showViewController:detailWeatherTVC sender:self];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger) buttonIndex
{
    if (buttonIndex == 0)
    {
        self.title = cityTextField.text;
        [_forecastTableView reloadData];
    }
}
@end
