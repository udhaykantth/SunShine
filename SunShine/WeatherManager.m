//
//  WeatherManager.m
//  SunShine
//
//  Created by udhaykanthd on 5/28/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherManager.h"
/*
 *  weatherDataReceivedNotification
 *
 *  Discussion:
 *    A constant string notification which used when weather data received from server.
 */
NSString * const weatherDataReceivedNotification = @"weatherDataReceivedNotification";
/*
 *  weatherDataFetchFailedNotification
 *
 *  Discussion:
 *    A constant string notification which used when weather data received failed from server.
 */
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
#pragma mark - Singleton

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
        isDailyWeather  = NO;
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
    
    [self.client fetchJSONDataFromCoordinates:coordinate type:WeatherConditionTypeCurrent metrics:_metric];
}
-(void)fetchDailyWeatherCondition
{
    isDailyWeather = YES;
    //TODO:// dynamic coordinates as parameter
    CLLocationCoordinate2D coordinate;
    coordinate.latitude =17.38;
    coordinate.longitude = 78.47;
    [self.client fetchJSONDataFromCoordinates:coordinate type:WeatherConditionTypeDaily metrics:_metric];

}
-(void)fetchHourlyWeatherCondition
{
    isDailyWeather = NO;
    //TODO:// dynamic coordinates as parameter
    CLLocationCoordinate2D coordinate;
    coordinate.latitude =17.38;
    coordinate.longitude = 78.47;
    [self.client fetchJSONDataFromCoordinates:coordinate type:WeatherConditionTypeHourly metrics:_metric];

}

#pragma mark - WeatherClient Delegate Methods
-(void)didFinishFetchJSONDataFromWeatherURL:(NSMutableArray *)data
{
    //NSLog(@"Parsed data completely");
    //_currentCondition = data;
    if (isDailyWeather) {
        if (_dailyWeather) {
            [_dailyWeather removeAllObjects];
            _dailyWeather = nil;
        }
        _dailyWeather = data;

    }
    else
    {
        if (_hourlyWeather) {
            [_hourlyWeather removeAllObjects];
           _hourlyWeather = nil;
        }
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
