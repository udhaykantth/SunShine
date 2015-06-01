//
//  WeatherCondition.m
//  SunShine
//
//  Created by udhaykanthd on 5/29/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherCondition.h"

@implementation WeatherCondition
@synthesize  LocationCoordinate,locationName,country,sunset, sunrise,day,icon
,humidity,temperature,temperatureHigh,temperatureLow,weatherDescription,weatherMain
,pressure,seaLevel,groundLevel,windSpeed,windDirection,condition,locationID,base,weatherID,weatherSubID;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)clearData
{
    self.locationName = nil;
    self.country = nil;
    self.sunset = nil;
    self.sunrise = nil;
    self.day = nil ;
    self.icon = nil;
    self.humidity = nil;
    self.temperature = nil;
    self.temperatureHigh= nil;
    self.temperatureLow = nil;
    self.weatherDescription = nil;
    self.weatherMain = nil;
    self.pressure = nil;
    self.seaLevel = nil;
    self.groundLevel =nil;
    self.windSpeed = nil;
    self.windDirection = nil;
    self.condition = nil;
    self.locationID =nil;
    self.base = nil;
    self.weatherID = nil;
    self.weatherSubID = nil;

}
- (void)dealloc
{
    [self clearData];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"[WeatherCondition: LocationName: %@,Country:%@],Sunrise:%@,Sunset :%@,\n,date:%@, icon:%@, humidity:%@ , temperature:%@, tempHigh:%@,tempLow:%@,weatherDescription:%@,Weathermain:%@, pressure:%@,SeaLevel:%@,GroundLevel:%@, windSpeed:%@,WindDirection:%@,Condition:%@,LocationID:%@,base:%@, weatherID:%@ , weatherSubID:%@",
            [self locationName], [self country], [[self sunrise] description],[[self sunset] description],[[self day] description],[self icon],[self humidity],[self temperature],[self temperatureHigh],[self temperatureLow],[self weatherDescription],[self weatherMain],[self pressure],[self seaLevel],[self groundLevel],[self windSpeed],[self windDirection],[self condition],[self locationID],[self base],[self weatherID],[self weatherSubID]];
} 
@end
