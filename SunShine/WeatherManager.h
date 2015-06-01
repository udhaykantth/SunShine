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



-(void)fetchCurrentConditions;


@end
