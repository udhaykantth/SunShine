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


@interface WeatherManager : NSObject <CLLocationManagerDelegate,WeatherClientDelegate>
+(instancetype)sharedWeatherManager;

@property (nonatomic, strong, readonly) CLLocation *currentLocation;


-(void)fetchCurrentConditions;


@end
