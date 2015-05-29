//
//  WeatherManager.m
//  SunShine
//
//  Created by udhaykanthd on 5/28/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherManager.h"

@interface WeatherManager()
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
    [self.client fetchJSONDataFromCoordinates:coordinate];
}

#pragma mark - WeatherClient Delegate Methods
-(void)didFinishFetchJSONDataFromWeatherURL:(WeatherCondition *)data
{
    NSLog(@"Parsed data completely");
}
@end
