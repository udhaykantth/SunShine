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


@interface WeatherManager : NSObject <CLLocationManagerDelegate,WeatherClientDelegate>
+(instancetype)sharedWeatherManager;

@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic,strong)  NSMutableArray* currentCondition;
@property (nonatomic, strong, readwrite) NSMutableArray  *dailyWeather;
@property (nonatomic, strong, readwrite) NSMutableArray   *hourlyWeather;
@property (nonatomic,readwrite)BOOL isDailyWeather; // if yes,daily weather.Otherwise,hourly weather 



-(void)fetchCurrentConditions;
-(void)fetchDailyWeatherCondition;
-(void)fetchHourlyWeatherCondition;




@end
