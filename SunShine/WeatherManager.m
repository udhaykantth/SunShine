//
//  WeatherManager.m
//  SunShine
//
//  Created by udhaykanthd on 5/28/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherManager.h"
NSString * const weatherDataReceivedNotification = @"weatherDataReceivedNotification";
NSString * const weatherDataFetchFailedNotification = @"weatherDataFetchFailedNotification";



@interface WeatherManager()
{
    BOOL isDailyWeather;
}
@property (nonatomic, strong) WeatherClient *client;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation WeatherManager

+ (instancetype)sharedWeatherManager {
    static id _sharedWeatherManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherManager = [[self alloc] init];
    });
    
    return _sharedWeatherManager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _client = [[WeatherClient alloc]init];
        [_client setClientDelegate:self];
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        _currentCondition  = [[NSMutableArray alloc]init];
        _dailyWeather = [[NSMutableArray alloc] init];
        _hourlyWeather = [[NSMutableArray alloc ]init];
        _isDailyWeather  = NO;
        //[self fetchCurrentConditions];

    }
    return self;
}
#pragma mark - custom methods
-(void)fetchCurrentConditions
{
    //TODO:// dynamic coordinates as parameter
    CLLocationCoordinate2D coordinate;
    coordinate.latitude =17.38;
    coordinate.longitude = 78.47;
    [self.client fetchJSONDataFromCoordinates:coordinate type:WeatherConditionTypeCurrent];
}
-(void)fetchDailyWeatherCondition
{
    _isDailyWeather = YES;
    //TODO:// dynamic coordinates as parameter
    CLLocationCoordinate2D coordinate;
    coordinate.latitude =17.38;
    coordinate.longitude = 78.47;
    [self.client fetchJSONDataFromCoordinates:coordinate type:WeatherConditionTypeDaily];

}
-(void)fetchHourlyWeatherCondition
{
    _isDailyWeather = NO;
    //TODO:// dynamic coordinates as parameter
    CLLocationCoordinate2D coordinate;
    coordinate.latitude =17.38;
    coordinate.longitude = 78.47;
    [self.client fetchJSONDataFromCoordinates:coordinate type:WeatherConditionTypeHourly];

}

#pragma mark - WeatherClient Delegate Methods
-(void)didFinishFetchJSONDataFromWeatherURL:(NSMutableArray *)data
{
    NSLog(@"Parsed data completely");
    //_currentCondition = data;
    if (_isDailyWeather) {
        _dailyWeather = data;

    }
    else
    {
        _hourlyWeather = data;
    }
     [[NSNotificationCenter defaultCenter] postNotificationName:weatherDataReceivedNotification object:nil];
}
-(void)didFailFetchJSONDataFromWeatherURL
{
    [[NSNotificationCenter defaultCenter] postNotificationName:weatherDataFetchFailedNotification object:nil];

}
-(void)clearWeatherData
{
    if ([_hourlyWeather count ]> 0){
        [_hourlyWeather removeAllObjects];
    }
    if ([_dailyWeather count] > 0 ) {
        [_dailyWeather removeAllObjects];
        
    }
}
@end
