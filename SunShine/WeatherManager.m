//
//  WeatherManager.m
//  SunShine
//
//  Created by udhaykanthd on 5/28/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherManager.h"
#import "WeatherShared.h"
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
/*
 *  weatherDataFetchWithCurrentLocationNotification
 *
 *  Discussion:
 *    A constant string notification which used when weather data with current user location received   from server.
 */
NSString * const weatherDataFetchWithCurrentLocationNotification = @"weatherDataFetchWithCurrentLocationNotification";
NSString * const locationUpdatedNotification = @"locationUpdatedNotification";
NSString * const geocoderLocationNotification =@"geocoderLocationNotification";



@interface WeatherManager()
{
    BOOL isDailyWeather;
}
@property (nonatomic, strong) WeatherClient *client;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;
@property (nonatomic,strong) CLGeocoder *geocoder;


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
        if (nil == _locationManager) {
            _locationManager = [[CLLocationManager alloc] init];
            [_locationManager setDelegate:self];
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization];
            }
            // [_locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
            //[_locationManager setDistanceFilter:500];
             //[_locationManager startMonitoringSignificantLocationChanges];
            
        }
        
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
    [self.client fetchJSONDataFromCoordinates:self.currentLocation.coordinate type:WeatherConditionTypeCurrent units:_metric];
}
-(void)fetchDailyWeatherCondition
{
    isDailyWeather = YES;
    //TODO:// dynamic coordinates as parameter
    [self.client fetchJSONDataFromCoordinates:self.currentLocation.coordinate type:WeatherConditionTypeDaily units:_metric];

}
-(void)fetchHourlyWeatherCondition
{
    isDailyWeather = NO;
    [self.client fetchJSONDataFromCoordinates:self.currentLocation.coordinate type:WeatherConditionTypeHourly units:_metric];

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
- (void)findMyLocation {
    self.isFirstUpdate = YES;
    [self.locationManager startUpdatingLocation];

}
#pragma mark CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    PRINT_CONSOLE_LOG([locations description]);
   if (self.isFirstUpdate) {
       CLLocation *location = [locations lastObject];
       
       if (location.horizontalAccuracy > 0) {
           self.currentLocation = location;
           [self.locationManager stopUpdatingLocation];
       }
        self.isFirstUpdate = NO;
       [[NSNotificationCenter defaultCenter] postNotificationName:locationUpdatedNotification object:nil];

        return;
    }
    
    
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    PRINT_CONSOLE_LOG([error description]);

}
#pragma mark 
-(void)latitudeLogitudeFromCity:(NSString*)cityName
{
    PRINT_CONSOLE_LOG(cityName);
    if (nil == self.geocoder) {
        self.geocoder = [[CLGeocoder alloc ] init];

    }
    [self.geocoder geocodeAddressString:cityName completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if ([placemarks count] > 0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            //CLLocation *location = placemark.location;
            self.currentLocation = placemark.location;
            //CLLocationCoordinate2D coordinate = location.coordinate;
           // NSLog(@"latitude: %f, longitude: %f,city:%@,name:%@,adminstrative area:%@,country:%@,address dictionary:%@,subAdministrativeArea:%@,sublocality:%@,subthoroughfare:%@,inlandwater:%@,thoroughfare :%@, ocean:%@, areasOfInterest:%@", coordinate.latitude, coordinate.longitude,placemark.locality,placemark.name,placemark.administrativeArea,placemark.country,placemark.addressDictionary,placemark.subAdministrativeArea,placemark.subLocality,placemark.subThoroughfare,placemark.inlandWater,placemark.thoroughfare,placemark.ocean,placemark.areasOfInterest);
            [[NSNotificationCenter defaultCenter] postNotificationName:geocoderLocationNotification object:nil];

        }
    }];


}
 @end
