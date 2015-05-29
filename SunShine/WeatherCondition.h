//
//  WeatherCondition.h
//  SunShine
//
//  Created by udhaykanthd on 5/29/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *  WeatherCoordinates
 *
 *  Discussion:
 *    A structure that contains a geographical coordinate.
 *
 *  Fields:
 *    latitude:
 *      The latitude in double.
 *    longitude:
 *      The longitude in double.
 */
typedef struct {
    double latitude;
    double longitude;
} LocationCoordinates;
/*
 *  WeatherCoordinatesMake:
 *
 *  Discussion:
 *    Returns a new WeatherCoordinates at the given latitude and longitude
 */
LocationCoordinates LocationCoordinatesMake(double latitude, double longitude);

@interface WeatherCondition : NSObject
{

}
/*
 *  coordinate
 *
 *  Discussion:
 *    Returns the coordinate of the current location.
 */
@property (nonatomic, readwrite) LocationCoordinates LocationCoordinate;
@property (nonatomic, strong) NSString* locationName;
@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSDate* sunset;
@property (nonatomic, strong) NSDate* sunrise;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, strong) NSNumber *temperatureHigh;
@property (nonatomic, strong) NSNumber *temperatureLow;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSString *weatherMain;
@property (nonatomic, strong) NSNumber *pressure;
@property (nonatomic, strong) NSNumber *seaLevel;
@property (nonatomic, strong) NSNumber *groundLevel;
@property (nonatomic, strong) NSNumber *windSpeed;
@property (nonatomic, strong) NSNumber *windDirection;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic,strong) NSNumber *locationID;
@property (nonatomic,strong) NSString *base;
@property (nonatomic,strong) NSNumber *weatherID;
@property (nonatomic,strong) NSNumber *weatherSubID;








@end
