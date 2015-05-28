//
//  WeatherListViewController.m
//  SunShine
//
//  Created by udhaykanthd on 5/27/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherListViewController.h"
#import "WeatherTableViewCell.h"

#define kCellHeight 65


@interface WeatherListViewController ()
@property(nonatomic,strong) UIImageView *backgroundImageView;
@property(nonatomic,strong) UIView *containerView;
@property (nonatomic, assign) CGFloat screenHeight;


@end

@implementation WeatherListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");

    [self configureHeaderView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Super class methods
-(void)viewWillLayoutSubviews
{
    NSLog(@"viewWillLayoutSubviews");

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear,topheight:%f", self.topLayoutGuide.length
);
 

}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kCellHeight;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"WeatherTableViewCell";
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
         cell = [[WeatherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    // Configure the cell...
    
    
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

#pragma mark - Custom Methods
-(void)configureHeaderView
{
    
    _backgroundImageView = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"Sky"]];
    [self.backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.tableView setBackgroundView:self.backgroundImageView];
    
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat topHeight = self.topLayoutGuide.length;
    
    NSLog(@"screen bounds:%@ \n topheight:%f",NSStringFromCGRect([UIScreen mainScreen].bounds),topHeight);
    
    _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _screenHeight *0.40)];
    NSLog(@"_containerView:%@",NSStringFromCGRect(_containerView.frame));
    // heights of the labels
    int todayLabelYCoordinate = 44;
    int maxTemperatureLabelYCoordinate = todayLabelYCoordinate+todayLabelYCoordinate;
    int minTemperatureLabelYCoordinate = maxTemperatureLabelYCoordinate+todayLabelYCoordinate*3;
    
    //create todays label
    
    UILabel *todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, todayLabelYCoordinate, _containerView.bounds.size.width*0.50, todayLabelYCoordinate)];
    [todayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30]];
    // [todayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30]];
    [todayLabel setText:@"Today,May 27"];
    [todayLabel setTextAlignment:NSTextAlignmentCenter];
    [todayLabel setTextColor:[UIColor whiteColor]];
    //[todayLabel setBackgroundColor:[UIColor blackColor]];
    [todayLabel setBackgroundColor:[UIColor clearColor]];
    
    [_containerView addSubview:todayLabel];
    
    
    //create max temperature label
    UILabel *maxTemperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,maxTemperatureLabelYCoordinate , _containerView.bounds.size.width*0.50, todayLabelYCoordinate*3)];
    [maxTemperatureLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:80]];

 
    [maxTemperatureLabel setText:@"80°"];//shift+option+8,40°C
    [maxTemperatureLabel setTextAlignment:NSTextAlignmentCenter];
    [maxTemperatureLabel setTextColor:[UIColor whiteColor]];
    //[maxTemperatureLabel setBackgroundColor:[UIColor greenColor]];
    [maxTemperatureLabel setBackgroundColor:[UIColor clearColor]];
    
    [_containerView addSubview:maxTemperatureLabel];
    
    //create min temperature label
    UILabel *minTemperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,minTemperatureLabelYCoordinate , _containerView.bounds.size.width*0.50, todayLabelYCoordinate)];
    [minTemperatureLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40]];
    
    
    [minTemperatureLabel setText:@"40°"];//shift+option+8,40°C
    [minTemperatureLabel setTextAlignment:NSTextAlignmentCenter];
    [minTemperatureLabel setTextColor:[UIColor whiteColor]];
    //[minTemperatureLabel setBackgroundColor:[UIColor redColor]];
    [minTemperatureLabel setBackgroundColor:[UIColor clearColor]];
    
    [_containerView addSubview:minTemperatureLabel];
    
    //create temperature status image left of the screen
    UIImageView* temperatureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_containerView.bounds.size.width*0.50, todayLabelYCoordinate , (_containerView.bounds.size.width)/2, _containerView.bounds.size.height-(2*todayLabelYCoordinate))];
    [temperatureImageView setImage:[UIImage imageNamed:@"art_clear"]];
    //[temperatureImageView setBackgroundColor:[UIColor greenColor]];
    //[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"art_clear"]];
    [temperatureImageView setContentMode:UIViewContentModeScaleAspectFill];
    [_containerView addSubview:temperatureImageView];
    
    
    //create   temperature status label
    UILabel *statusTemperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.size.width*0.50,minTemperatureLabelYCoordinate , _containerView.bounds.size.width*0.50, todayLabelYCoordinate)];
    [statusTemperatureLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    
    
    [statusTemperatureLabel setText:@"Clear Sun"];
    [statusTemperatureLabel setTextAlignment:NSTextAlignmentCenter];
    [statusTemperatureLabel setTextColor:[UIColor whiteColor]];
    //[statusTemperatureLabel setBackgroundColor:[UIColor redColor]];
    [statusTemperatureLabel setBackgroundColor:[UIColor clearColor]];
    
    [_containerView addSubview:statusTemperatureLabel];
    
    //[_containerView setBackgroundColor:[UIColor purpleColor]];
    [_containerView setBackgroundColor:[UIColor clearColor]];
    
    [self.tableView setTableHeaderView:_containerView];
    

}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
