//
//  WeatherListViewController.m
//  SunShine
//
//  Created by udhaykanthd on 5/27/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherListViewController.h"
#import "WeatherTableViewCell.h"
#import "WeatherManager.h"
#import "WeatherUtility.h"

#define kCellHeight 65


@interface WeatherListViewController ()
@property(nonatomic,strong) UIImageView *backgroundImageView;
@property(nonatomic,strong) UIView *containerView;
@property (nonatomic, assign) CGFloat screenHeight;
@property(nonatomic,strong) UILabel *todayLabel;
@property(nonatomic,strong) UILabel *maxTemperatureLabel;
@property(nonatomic,strong) UILabel *minTemperatureLabel;
@property(nonatomic,strong) UIImageView* temperatureImageView;
@property(nonatomic,strong)UILabel *statusTemperatureLabel;


@end

@implementation WeatherListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[WeatherManager sharedWeatherManager] fetchDailyWeatherCondition];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(loadWeatherData:) name:weatherDataReceivedNotification object:nil];

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
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:weatherDataReceivedNotification object:self];
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
    NSLog(@"numberOfRowsInSection count:%lu",(unsigned long)[[WeatherManager sharedWeatherManager].dailyWeather count]);
    return [[WeatherManager sharedWeatherManager].dailyWeather count]-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath");
    
    static NSString *cellIndentifier = @"WeatherTableViewCell";
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
         cell = [[WeatherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
     ////leave blank for the first row as it is shown in header view
    WeatherCondition *weather = [WeatherManager sharedWeatherManager].dailyWeather[indexPath.row+1];
    [self configureHourlyRowCell:cell weather:weather];
    
    
   /* if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
           // [self configureHeaderRowCell:cell title:@"Hourly Forecast"];
//            WeatherCondition *weather = [WeatherManager sharedWeatherManager].dailyWeather[indexPath.row];
//            [self configureHourlyRowCell:cell weather:weather];
        }
        else {
//            WeatherCondition *weather = [WeatherManager sharedWeatherManager].currentCondition[indexPath.row-1];
//            [self configureHourlyRowCell:cell weather:weather];
        }
    }
    */
    
    // Configure the cell...
    
    
    return cell;
}
- (void)configureHeaderRowCell:(WeatherTableViewCell *)cell title:(NSString *)title {
    NSLog(@"[%s]",__PRETTY_FUNCTION__);

    [cell.dayLabel setText:title];
    
    [cell.temperatureStatus setText:nil];
    [cell.minTemperatureLabel setText:nil];
    [cell.maxTemperatureLabel setText:nil];
    [cell.temperatureStatusImageView setImage:nil];
}
- (void)configureHourlyRowCell:(WeatherTableViewCell *)cell weather:(WeatherCondition *)weather {
    NSLog(@"[%s],weather data:%@",__PRETTY_FUNCTION__,[weather description]);
    
    if (weather != nil) {
        [cell.dayLabel setText:weather.day];
        NSLog(@"currentdate:%@",weather.day);
        [cell.temperatureStatusImageView setImage:[[WeatherUtility sharedWeatherUtility] weatherIconFromString:weather.icon]];
        //[cell.minTemperatureLabel setText:weather.temperatureLow];
        //[cell.maxTemperatureLabel setText:weather.temperatureHigh];
        
        [cell.minTemperatureLabel setText:[[WeatherUtility sharedWeatherUtility] stringFromTwoDigitRoundUpDecimal:[weather currentTemperature].minTemperature]];
        [cell.maxTemperatureLabel setText:[[WeatherUtility sharedWeatherUtility] stringFromTwoDigitRoundUpDecimal:[weather currentTemperature].maxTemperature]];
        [cell.temperatureStatus setText:weather.weatherMain];

        
    }
 
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
    
    _todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, todayLabelYCoordinate, _containerView.bounds.size.width*0.50, todayLabelYCoordinate+30)];
    [_todayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:25]];
    // [todayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30]];
    [_todayLabel setNumberOfLines:2];
    [_todayLabel setText:@" "];
    [_todayLabel setTextAlignment:NSTextAlignmentCenter];
    [_todayLabel setTextColor:[UIColor whiteColor]];
    //[_todayLabel setBackgroundColor:[UIColor blackColor]];
    [_todayLabel setBackgroundColor:[UIColor clearColor]];
    
    [_containerView addSubview:_todayLabel];
    
    
    //create max temperature label
    _maxTemperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,maxTemperatureLabelYCoordinate+30 , _containerView.bounds.size.width*0.50, todayLabelYCoordinate*2)];
    [_maxTemperatureLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:70]];

 
    [_maxTemperatureLabel setText:@" "];//shift+option+8,40°C
    [_maxTemperatureLabel setTextAlignment:NSTextAlignmentCenter];
    [_maxTemperatureLabel setTextColor:[UIColor whiteColor]];
    //[_maxTemperatureLabel setBackgroundColor:[UIColor greenColor]];
    [_maxTemperatureLabel setBackgroundColor:[UIColor clearColor]];
    
    [_containerView addSubview:_maxTemperatureLabel];
    
    //create min temperature label
    _minTemperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,minTemperatureLabelYCoordinate , _containerView.bounds.size.width*0.50, todayLabelYCoordinate)];
    [_minTemperatureLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40]];
    
    
    [_minTemperatureLabel setText:@"40°"];//shift+option+8,40°C
    [_minTemperatureLabel setTextAlignment:NSTextAlignmentCenter];
    [_minTemperatureLabel setTextColor:[UIColor whiteColor]];
    //[minTemperatureLabel setBackgroundColor:[UIColor redColor]];
    [_minTemperatureLabel setBackgroundColor:[UIColor clearColor]];
    
    [_containerView addSubview:_minTemperatureLabel];
    
    //create temperature status image left of the screen
    _temperatureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_containerView.bounds.size.width*0.50, todayLabelYCoordinate , (_containerView.bounds.size.width)/2, _containerView.bounds.size.height-(2*todayLabelYCoordinate))];
    [_temperatureImageView setImage:[UIImage imageNamed:@"art_clear"]];
    //[temperatureImageView setBackgroundColor:[UIColor greenColor]];
    //[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"art_clear"]];
    [_temperatureImageView setContentMode:UIViewContentModeScaleAspectFill];
    [_containerView addSubview:_temperatureImageView];
    
    
    //create   temperature status label
    _statusTemperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.size.width*0.50,minTemperatureLabelYCoordinate , _containerView.bounds.size.width*0.50, todayLabelYCoordinate)];
    [_statusTemperatureLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25]];
    
    
    [_statusTemperatureLabel setText:@"Clear Sun"];
    [_statusTemperatureLabel setTextAlignment:NSTextAlignmentCenter];
    [_statusTemperatureLabel setTextColor:[UIColor whiteColor]];
    //[statusTemperatureLabel setBackgroundColor:[UIColor redColor]];
    [_statusTemperatureLabel setBackgroundColor:[UIColor clearColor]];
    
    [_containerView addSubview:_statusTemperatureLabel];
    
    //[_containerView setBackgroundColor:[UIColor purpleColor]];
    [_containerView setBackgroundColor:[UIColor clearColor]];
    
    [self.tableView setTableHeaderView:_containerView];
    

}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(void)updateHeaderView
{
    WeatherCondition *weather = [WeatherManager sharedWeatherManager].dailyWeather[0];
     [_todayLabel setText:[NSString stringWithFormat:@"Today\n%@",weather.locationName]];//day
    [_maxTemperatureLabel setText:[[WeatherUtility sharedWeatherUtility] stringFromTwoDigitRoundUpDecimal:[weather currentTemperature].maxTemperature]];
    [_minTemperatureLabel setText:[[WeatherUtility sharedWeatherUtility] stringFromTwoDigitRoundUpDecimal:[weather currentTemperature].minTemperature]];
    [_statusTemperatureLabel setText:weather.weatherMain];
    [_temperatureImageView setImage:[[WeatherUtility sharedWeatherUtility] weatherArtFromString:weather.icon]];


}
-(void)loadWeatherData:(NSNotification*) notifcation
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self updateHeaderView];

});

}
@end
