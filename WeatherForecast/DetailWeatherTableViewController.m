//
//  DetailWeatherTableViewController.m
//  WeatherForecast
//
//  Created by Murari Varma on 25/03/15.
//  Copyright (c) 2015 murarivarma. All rights reserved.
//

#import "DetailWeatherTableViewController.h"

@interface DetailWeatherTableViewController ()

@end

@implementation DetailWeatherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _weatherArray = [[NSMutableArray alloc]init];
//    NSLog(@"ITS THE DETAIL ARRAY TIME :::: %@", _weatherDataArray);
//    NSLog(@"ITS THE DETAIL ARRAY TIME :::: %@", _supportKeysArray);
//    NSLog(@"dfgsfsjdfjdsfjsdjfgsdjgdsgjsgdjgdsjgh ----------- %@",[[[[_weatherDataArray objectAtIndex:_clickedIndex] objectAtIndex:13] objectForKey:_supportKeysArray[13]]objectAtIndex:0]);
//    NSString * hello = @"clear";
//    NSLog(@"dsvsdfbsdvbsbdvjs %@",hello);
    
    for (int i=0; i<14; i++) {
        [_weatherArray addObject:[[[_weatherDataArray objectAtIndex:_clickedIndex] objectAtIndex:i] objectForKey:[_supportKeysArray objectAtIndex:i]]];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 14;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    //cell.textLabel.text = [[[[_weatherDataArray objectAtIndex:_clickedIndex] objectAtIndex:indexPath.row] objectForKey:[_supportKeysArray objectAtIndex:indexPath.row]]objectAtIndex:0];
    
    UILabel * lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 70, 30)];
    lbl1.text = [_supportKeysArray objectAtIndex:indexPath.row];
    [cell.contentView addSubview:lbl1];
    
    UILabel * lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 190, 30)];
    lbl2.text = [[[[_weatherDataArray objectAtIndex:_clickedIndex] objectAtIndex:indexPath.row] objectForKey:[_supportKeysArray objectAtIndex:indexPath.row]]objectAtIndex:0];
    [cell.contentView addSubview:lbl2];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
