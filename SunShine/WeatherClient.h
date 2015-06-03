//
//  WeatherClient.h
//  SunShine
//
//  Created by udhaykanthd on 5/28/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherJsonParser.h"

/****************	Weather ConditionType	****************/

typedef NS_OPTIONS(NSUInteger, WeatherConditionType) {
    WeatherConditionTypeNone    = -1,
    WeatherConditionTypeCurrent = 0,
    WeatherConditionTypeHourly  = 1,
    WeatherConditionTypeDaily   = 2
    
};

@protocol WeatherClientDelegate <NSObject>

@required
-(void)didFinishFetchJSONDataFromWeatherURL:(NSMutableArray*)data;

@end

@interface WeatherClient : NSObject<WeatherJsonParserDelegate>
@property(nonatomic,weak)id<WeatherClientDelegate> clientDelegate;
- (void)fetchJSONDataFromWeatherURL:(NSURL *)url;
- (void)fetchJSONDataFromCoordinates:(CLLocationCoordinate2D)coordinate type:(WeatherConditionType)WeatherconditionType;


@end
