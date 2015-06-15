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
#import "WeatherListDetailPushAnimator.h"
#import "WeatherListDetailPopAnimator.h"
#import "WeatherDetailViewController.h"
#import "WeatherSettingViewController.h"
#import "WeatherShared.h"


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
    PRINT_CONSOLE_LOG(nil);
    [super viewDidLoad];
     self.navigationController.delegate = self;
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addObservers];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    
    NSDictionary *attributeDict = nil;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    
    attributeDict = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
              NSFontAttributeName:font,
              NSParagraphStyleAttributeName:style};
    [refresh setAttributedTitle:[[NSAttributedString alloc]initWithString:@"Updating Weather..." attributes:attributeDict]];
    [refresh setTintColor:[UIColor whiteColor]];
    [refresh addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    

    [self setRefreshControl:refresh];
    [[WeatherManager sharedWeatherManager] findMyLocation];

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
    PRINT_CONSOLE_LOG(nil);
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     PRINT_CONSOLE_LOG(nil);
     

}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    PRINT_CONSOLE_LOG(nil);
}
-(void)dealloc
{
    [self removeObservers];
    

}
#pragma mark - Table view data source delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kCellHeight;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     // Return the number of rows in the section.
     return [[WeatherManager sharedWeatherManager].dailyWeather count]-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"cellForRowAtIndexPath");
    
    static NSString *cellIndentifier = @"WeatherTableViewCell";
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (nil == cell) {
         cell = [[WeatherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
     ////leave blank for the first row as it is shown in header view
    WeatherCondition *weather = [WeatherManager sharedWeatherManager].dailyWeather[indexPath.row+1];
    [self configureHourlyRowCell:cell weather:weather];
    return cell;
}
- (void)configureHeaderRowCell:(WeatherTableViewCell *)cell title:(NSString *)title {
    //NSLog(@"[%s]",__PRETTY_FUNCTION__);

    [cell.dayLabel setText:title];
    
    [cell.temperatureStatus setText:nil];
    [cell.minTemperatureLabel setText:nil];
    [cell.maxTemperatureLabel setText:nil];
    [cell.temperatureStatusImageView setImage:nil];
}
- (void)configureHourlyRowCell:(WeatherTableViewCell *)cell weather:(WeatherCondition *)weather {
    //NSLog(@"[%s],weather data:%@",__PRETTY_FUNCTION__,[weather description]);
    
    if (nil != weather) {
        [cell.dayLabel setText:weather.day];
        //NSLog(@"currentdate:%@",weather.day);
        [cell.temperatureStatusImageView setImage:[[WeatherUtility sharedWeatherUtility] weatherIconFromString:weather.icon]];
        
        [cell.minTemperatureLabel setText:[[WeatherUtility sharedWeatherUtility] stringFromTwoDigitRoundUpDecimal:[weather currentTemperature].minTemperature]];
        [cell.maxTemperatureLabel setText:[[WeatherUtility sharedWeatherUtility] stringFromTwoDigitRoundUpDecimal:[weather currentTemperature].maxTemperature]];
        [cell.temperatureStatus setText:weather.weatherMain];

        
    }
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //NSLog(@"didSelectRowAtIndexPath");
    WeatherDetailViewController *weatherDetailViewController = [[WeatherDetailViewController alloc ]init];
    WeatherCondition *detailWeather = [WeatherManager sharedWeatherManager].dailyWeather[indexPath.row+1];
    [weatherDetailViewController setDetailWeatherCondition:detailWeather] ;

    [self.navigationController pushViewController:weatherDetailViewController animated:YES];
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
    [self.navigationItem setTitle:@"SunShine"];
    
     UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Settings.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openSettingView)];
     [self.navigationItem setRightBarButtonItem:settingItem];
    
    _backgroundImageView = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"Sky"]];
    [self.backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];

    self.refreshControl.layer.zPosition = self.tableView.backgroundView.layer.zPosition + 1;
    ////NSLog(@" after refresh control z position:[%f]", self.refreshControl.layer.zPosition);


    [self.tableView setBackgroundView:self.backgroundImageView];
    
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    //CGFloat topHeight = self.topLayoutGuide.length;
    
    //NSLog(@"screen bounds:%@ \n topheight:%f",NSStringFromCGRect([UIScreen mainScreen].bounds),topHeight);
    
    _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _screenHeight *0.40)];
    //NSLog(@"_containerView:%@",NSStringFromCGRect(_containerView.frame));
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
    
    
    [_minTemperatureLabel setText:@""];//shift+option+8,40°C
    [_minTemperatureLabel setTextAlignment:NSTextAlignmentCenter];
    [_minTemperatureLabel setTextColor:[UIColor whiteColor]];
    //[minTemperatureLabel setBackgroundColor:[UIColor redColor]];
    [_minTemperatureLabel setBackgroundColor:[UIColor clearColor]];
    
    [_containerView addSubview:_minTemperatureLabel];
    
    //create temperature status image left of the screen
    _temperatureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_containerView.bounds.size.width*0.50, todayLabelYCoordinate , (_containerView.bounds.size.width)/2, _containerView.bounds.size.height-(2*todayLabelYCoordinate))];
    [_temperatureImageView setImage:nil];
    //[temperatureImageView setBackgroundColor:[UIColor greenColor]];
    //[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"art_clear"]];
    [_temperatureImageView setContentMode:UIViewContentModeScaleAspectFill];
    [_containerView addSubview:_temperatureImageView];
    
    
    //create   temperature status label
    _statusTemperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.size.width*0.50,minTemperatureLabelYCoordinate , _containerView.bounds.size.width*0.50, todayLabelYCoordinate)];
    [_statusTemperatureLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25]];
    
    
    [_statusTemperatureLabel setText:@""];
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
    //save into the weathermanager, units and location name.
     NSString *units = [[NSUserDefaults standardUserDefaults]objectForKey:UNITS_PREFERENCE];
    if ([units length] > 0) {
        [[WeatherManager sharedWeatherManager]setMetric:units];
        
    }
    else {
        [[WeatherManager sharedWeatherManager]setMetric:DEFAULT_UNIT];//By default
    }
    [[WeatherManager sharedWeatherManager] setCityName:weather.locationName];//existing location name

    


}
#pragma mark Notifications methods

-(void)loadWeatherData:(NSNotification*) notifcation
{
    //NSLog(@"%s",__PRETTY_FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopRefresh];
        [self.tableView reloadData];
        [self updateHeaderView];

});

}
-(void)fetchFailed:(NSNotification*)notification {
    //NSLog(@"%s",__PRETTY_FUNCTION__);
    dispatch_async(dispatch_get_main_queue(), ^{
         [self stopRefresh];
         [self showAlert];
        
    });

}
-(void)locationUpdateReceived:(NSNotification*)notification {
    [self fetchData];

}
-(void)geocoderLocationReceived:(NSNotification*)notification {
    [self fetchData];
    
}
#pragma mark - navigationController transition
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    //this delegate is required an animator object for navigation controller how to perform animation.
    //both will do same type of animation but with different direction.
    switch (operation) {
        case UINavigationControllerOperationPush:
            return [[WeatherListDetailPushAnimator alloc]init];
            break;
        case UINavigationControllerOperationPop:
            return [[WeatherListDetailPopAnimator alloc]init];
            break;
            
        default:
            return nil;
            break;
    }
}
-(WeatherTableViewCell*)tableViewCellForWeather:(WeatherCondition*)aWeather
{
    NSUInteger weatherIndex = [[WeatherManager sharedWeatherManager].dailyWeather indexOfObject:aWeather];
         if (weatherIndex == NSNotFound) {
            return nil;
        }
    //NSLog(@"tableViewCellForWeather index:%lu",(unsigned long)weatherIndex);
  return  (WeatherTableViewCell*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:weatherIndex inSection:0]];
        
    
 }
#pragma mark --notification observers
-(void)addObservers {
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(loadWeatherData:) name:weatherDataReceivedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchFailed:) name:weatherDataFetchFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdateReceived:) name:locationUpdatedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(geocoderLocationReceived:) name:geocoderLocationNotification object:nil];
    
    
    
}
-(void)removeObservers {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:weatherDataReceivedNotification object:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:weatherDataFetchFailedNotification object:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:locationUpdatedNotification object:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:geocoderLocationNotification object:self];

}
#pragma mark --Custom methods
-(void)showAlert {
    
    UIAlertController *errorIssueController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Unable to load data. Connectivity error!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [errorIssueController addAction:okButton];
    [self presentViewController:errorIssueController animated:YES completion:nil];
    
    

}
-(void)fetchData {
    PRINT_CONSOLE_LOG(nil);
     [self.refreshControl beginRefreshing];
    [[WeatherManager sharedWeatherManager] fetchDailyWeatherCondition];
    

}
-(void)stopRefresh {
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];

    }
    //NSLog(@"[%s]",__PRETTY_FUNCTION__);

}
-(void)openSettingView {
    WeatherSettingViewController *weatherSettingVC = [[WeatherSettingViewController alloc ]init];
    [weatherSettingVC setDelegate:self];
    WeatherManager *weatherMgr = [WeatherManager sharedWeatherManager];
    if ([weatherMgr.metric length] > 0 || [weatherMgr.cityName length] > 0) {
        NSDictionary *selectedDataDict = [NSDictionary dictionaryWithObjectsAndKeys:weatherMgr.metric,UNITS,weatherMgr.cityName,LOCATION_NAME, nil];
        [weatherSettingVC setExistingSelectedData:selectedDataDict];
        
    }
    [weatherSettingVC setModalPresentationStyle:UIModalPresentationPopover];
    UINavigationController *naviController = [[UINavigationController alloc]initWithRootViewController:weatherSettingVC];
     [self presentViewController:naviController animated:YES completion:nil];
  
    
}
-(void)dissmissViewContorller:(NSMutableDictionary *)selectedData {
    PRINT_CONSOLE_LOG([selectedData description]);
    if (nil != selectedData) {
         [[WeatherManager sharedWeatherManager] setMetric:[selectedData objectForKey:UNITS]];
        [[WeatherManager sharedWeatherManager] setCityName:[selectedData objectForKey:LOCATION_NAME]];
        [[WeatherManager sharedWeatherManager]latitudeLogitudeFromCity:[[selectedData objectForKey:LOCATION_NAME] lowercaseString]];
 
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
