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

 /*!
 @enum WeatherConditionType
 
 @discussion The WeatherConditionType enum defines constants that
 can be used to specify the type of url requested to server to fetch the respective weather data(current weather or hourly weather or daily weather data).
 
 @constant WeatherConditionTypeNone Specifies that requested url type is default.
 
 @constant WeatherConditionTypeCurrent Specifies that
 requested url type is current weather which allowed to get current weather data.
 
 @constant WeatherConditionTypeHourly Specifies that 
 requested url type is hourly weather which allowed to get hourly weather data.
 
 @constant WeatherConditionTypeDaily Specifies that 
  requested url type is daily weather which allowed to get daily weather data.
 */

typedef NS_OPTIONS(NSUInteger, WeatherConditionType) {
    WeatherConditionTypeNone    = -1,
    WeatherConditionTypeCurrent = 0,
    WeatherConditionTypeHourly  = 1,
    WeatherConditionTypeDaily   = 2
    
};

/*!
 @method WeatherClientDelegate
 @abstract delegate to weathermanager class.
 @result  protocol weather client delegate, updates the weathermanganer class once the json data received from the server .
 */
@protocol WeatherClientDelegate <NSObject>

@required
/*!
 @method didFinishFetchJSONDataFromWeatherURL
 @abstract updates to delegate class that json data is fetch successfully from the server and post the notification to weatherListViewController that it received data successfully and reload the table.
 @param data an NSData object representing the URL content
 corresponding to the given response.
 @result an initialized NSCachedURLResponse.
 */
-(void)didFinishFetchJSONDataFromWeatherURL:(NSMutableArray*)data;
/*!
 @method didFailFetchJSONDataFromWeatherURL
 @abstract clears the stored data,sends the failed notification to weatherListViewController
 @result clears the stored data,sends the failed notification to weatherListViewController.
 */
-(void)didFailFetchJSONDataFromWeatherURL;

@end
/*!
 @class WeatherClient
 WeatherClient is a class whose objects functions is to connect to server ,fetch the data in JSON format and update back to weather manager class.
 */
@interface WeatherClient : NSObject<WeatherJsonParserDelegate>
@property(nonatomic,weak)id<WeatherClientDelegate> clientDelegate;
- (void)fetchJSONDataFromCoordinates:(CLLocationCoordinate2D)coordinate type:(WeatherConditionType)WeatherconditionType;


@end
