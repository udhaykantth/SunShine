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
static inline LocationCoordinates LocationCoordinatesMake(double latitude, double longitude) {
    LocationCoordinates aLocationCoordinates;
    aLocationCoordinates.latitude = latitude;
    aLocationCoordinates.longitude= longitude;
    return  aLocationCoordinates;

}

/*
 *  WeatherTemperature
 *
 *  Discussion:
 *    A structure that contains a weather temperature.
 *
 *  Fields:
 *    dayTemperature:
 *      The day Temperature in double.
 *    minTemperature:
 *      The min Temperature in double.
 *    maxTemperature:
 *      The max Temperature in double.
 *    nightTemperature:
 *      The night Temperature in double.
 *    eveningTemperature:
 *      The evening Temperature in double.
 *    morningTemperature:
 *      The morning Temperature in double.
 */
typedef struct {
    double dayTemperature;
    double minTemperature;
    double maxTemperature;
    double nightTemperature;
    double eveningTemperature;
    double morningTemperature;

} Temperature;
/*
 *  WeatherTemperatureMake:
 *
 *  Discussion:
 *    Returns a new Weather temperature at the given day temperature
 */
static inline Temperature TemperatureMake(double dayTemperature,
                            double minTemperature,
                            double maxTemperature,
                            double nightTemperature,
                            double eveningTemperature,
                                   double morningTemperature) {

    Temperature aTemperature;
    aTemperature.dayTemperature = dayTemperature;
    aTemperature.minTemperature = minTemperature;
    aTemperature.maxTemperature = maxTemperature;
    aTemperature.nightTemperature = nightTemperature;
    aTemperature.eveningTemperature = eveningTemperature;
    aTemperature.morningTemperature = morningTemperature;
    return aTemperature;
    
}
/*!
 @class WeatherCondition
 WeatherCondition is a modal class whose objects functions to store weather data .
 */

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
@property (nonatomic) Temperature currentTemperature;

@property (nonatomic, strong) NSString* locationName;
@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSDate* sunset;
@property (nonatomic, strong) NSDate* sunrise;
@property (nonatomic, strong) NSString* day;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *temperatureHigh;
@property (nonatomic, strong) NSString *temperatureLow;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSString *weatherMain;
@property (nonatomic, strong) NSNumber *pressure;
@property (nonatomic, strong) NSNumber *seaLevel;
@property (nonatomic, strong) NSNumber *groundLevel;
@property (nonatomic, strong) NSNumber *windSpeed;
@property (nonatomic, strong) NSNumber *windDirection;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSNumber *locationID;//cityID
@property (nonatomic, strong) NSString *base;
@property (nonatomic, strong) NSNumber *weatherID;//weather ID
@property (nonatomic, strong) NSNumber *weatherSubID;
@property (nonatomic, strong) NSString *hourlyDateTime;
 
@end
