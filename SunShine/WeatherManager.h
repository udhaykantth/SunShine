//
//  WeatherManager.h
//  SunShine
//
//  Created by udhaykanthd on 5/28/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherClient.h"
extern NSString * const weatherDataReceivedNotification;
extern NSString * const weatherDataFetchFailedNotification;
extern NSString * const weatherDataFetchWithCurrentLocationNotification;
extern NSString * const  locationUpdatedNotification;
extern NSString * const geocoderLocationNotification;

/*!
 @class WeatherManager
 WeatherManager is a single-ton class whose objects functions as a wrapper for
 objects weatherClient class, weather condition class & stores the data in objects to display in table view.
 */

@interface WeatherManager : NSObject <CLLocationManagerDelegate,WeatherClientDelegate>
/*!
 @method sharedWeatherManager
 @abstract Initializes a single-ton class.
 @result an initialized single-ton WeatherManager.
 */
+(instancetype)sharedWeatherManager;

@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic,strong)  NSMutableArray* currentCondition;
@property (nonatomic, strong, readwrite) NSMutableArray  *dailyWeather;
@property (nonatomic, strong, readwrite) NSMutableArray   *hourlyWeather;
@property (nonatomic,strong)  NSString *metric;
@property (nonatomic,strong)  NSString *cityName;

- (void)findMyLocation;



/*!
 @method fetchCurrentConditions
 @abstract fetch the data from server providing the current latitude and longitude
 @result invokes the weather client api to fetch the json from the server.
 */


-(void)fetchCurrentConditions;
/*!
 @method fetchDailyWeatherCondition
 @abstract fetch the daily weather data from server providing the locations.
 @result invokes the weather client api to fetch the json data of type daily weather from the server.
 */
-(void)fetchDailyWeatherCondition;
/*!
 @method fetchHourlyWeatherCondition
 @abstract fetch the hourly weather data from the server providing the locations.
 @result invokes the weather client api to fetch the json data of type hourly weatehr condition from the server.
 */
-(void)fetchHourlyWeatherCondition;
/*!
 @method latitudeLogitudeFromCity
 @abstract cityName, takes converts city name into latitude and longitude of city.
 @result converts city address into latitude and longitude.
 */

-(void)latitudeLogitudeFromCity:(NSString*)cityName;






@end
