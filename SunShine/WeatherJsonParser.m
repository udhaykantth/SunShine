//
//  WeatherJsonParser.m
//  SunShine
//
//  Created by udhaykanthd on 5/29/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherJsonParser.h"


@interface WeatherJsonParser()
{
    NSDictionary* jsonDict;
}
-(void)weatherDataFromJSON:(NSDictionary*)json;

@end

@implementation WeatherJsonParser

-(instancetype)initWithWeatherDataFromJSON:(NSDictionary*)json delegate:(id<WeatherJsonParserDelegate>)delegate;
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        jsonDict = json;
        
    }
    return self;
}
-(void)parseJSON
{
    NSLog(@"Parsing...");
    [self weatherDataFromJSON:jsonDict];
}

-(void)weatherDataFromJSON:(NSDictionary*)json {

    if (json == nil) {
        //NSError *error;
        
        //[self.delegate didFinishParsingWithError:];
    }
   
    WeatherCondition* weatherData = [[WeatherCondition alloc]init];
    NSString* base = [json objectForKey:@"base"];
    if ([base length]!= 0 && nil != base) {
        [weatherData setBase:base];
    }
    NSNumber* weatherID = [json objectForKey:@"id"];
    if (!(weatherID < 0)) {
        [weatherData setWeatherID:weatherID];
    }
    NSNumber* date = [json objectForKey:@"dt"];
    if (!(date < 0)) {
         // convert interval into date object
        
    }
    NSDictionary* main = [json objectForKey:@"main"];
    if (main != nil) {
        NSNumber* humidity = [main objectForKey:@"humidity"];
        if (!(humidity < 0)) {
            [weatherData setHumidity:humidity];
        }
        NSNumber* temp_min = [main objectForKey:@"temp_min"];
        if (!(temp_min < 0)) {
            [weatherData setTemperatureLow:temp_min];
        }
        NSNumber* temp_max = [main objectForKey:@"temp_max"];
        if (!(temp_max < 0)) {
            [weatherData setTemperatureHigh:temp_max];
        }
        NSNumber* temperature = [main objectForKey:@"temp"];
        if (!(temperature < 0)) {
            [weatherData setTemperature:temperature];
        }
        NSNumber* pressure = [main objectForKey:@"pressure"];
        if (!(pressure < 0)) {
            [weatherData setPressure:pressure];
        }
        NSNumber* seaLevel = [main objectForKey:@"sea_level"];
        if (!(seaLevel < 0)) {
            [weatherData setSeaLevel:seaLevel];
        }
        NSNumber* grndLevel = [main objectForKey:@"grnd_level"];
        if (!(grndLevel < 0)) {
            [weatherData setGroundLevel:grndLevel];
        }
        
    }
    
    
    NSDictionary* coordinates = [json objectForKey:@"coord"];
    if (coordinates != nil) {
        double longitude = [[coordinates objectForKey:@"lon"] doubleValue];
        double latitude = [[coordinates objectForKey:@"lat"]  doubleValue];
        //TODO:// to make it static
       // LocationCoordinates locationLatLog= LocationCoordinatesMake(latitude, longitude);
       // weatherData.LocationCoordinate = locationLatLog;
        
    }
    
    
    
    NSDictionary* sys = [json objectForKey:@"sys"];
    if (sys != nil) {
        //NSNumber* message = [sys objectForKey:@"message"];
        //since message is not used ,so ignored
        NSString* country = [sys objectForKey:@"country"];
        if ([country length]!=0) {
            [weatherData setCountry:country];
        }
        
        NSNumber* sunset = [sys objectForKey:@"sunset"];
        if (!(sunset < 0)) {
            //TODO:// convert interval into date/time
            //[weatherData setSunset:<#(NSDate *)#>];
        }
        NSNumber* sunrise = [sys objectForKey:@"sunrise"];
        if (!(sunrise < 0)) {
            //TODO:// convert interval into date/time.
            //[weatherData setSunrise:<#(NSDate *)#>];
        }
    }
    
   
    
    NSDictionary* wind = [json objectForKey:@"wind"];
    if (wind != nil) {
        double speed = [[wind objectForKey:@"speed"]doubleValue];
        if (!(speed < 0)) {
            [weatherData setWindSpeed:[NSNumber numberWithDouble:speed]];
        }
        long  deg = [[wind objectForKey:@"deg"] longValue];
        if (!(deg < 0)) {
            [weatherData setWindDirection:[NSNumber numberWithLong:deg]];
        }
        
    }
    
    
    NSArray* weather = [json objectForKey:@"weather"];
    if ([weather count] !=0) {
        for (int i =0; i<[weather count]; i++) {
            NSDictionary* weatherDict = [weather objectAtIndex:i];
            long weatherID =[[weatherDict objectForKey:@"id"]longValue];
            if (!(weatherID < 0)) {
                [weatherData setWeatherSubID:[NSNumber numberWithLong:weatherID]];
            }
            NSString* main= [weatherDict objectForKey:@"main"];
            if ([main length]!=0) {
                [weatherData setWeatherMain:main];
            }
            NSString* icon= [weatherDict objectForKey:@"icon"];
            if ([icon length] != 0) {
                [weatherData setIcon:icon];
            }
            NSString* description= [weatherDict objectForKey:@"description"];
            if ([description length]!=0) {
                [weatherData setWeatherDescription:description];
            }
        }
        
    }
    
    NSDictionary* clouds = [json objectForKey:@"clouds"];
    if (clouds != nil) {
        long all = [[clouds objectForKey:@"all"]longValue];
        if (!(all < 0)) {
             //all is not used , so ignored it.
        }
        
    }
   
    
   // NSNumber* cod= [json objectForKey:@"cod"];
   // if (cod ) {
         // cod is not used , so ignored it.
   // }
    NSString* locationName= [json objectForKey:@"name"];
    if ([locationName length]!=0) {
        [weatherData setLocationName:locationName];
    }
    NSDictionary* rain = [json objectForKey:@"rain"];
    if (rain!= nil) {
        //double rainReading= [[rain objectForKey:@"3h"]doubleValue];
        // 3h is not used , so ignored it.
  
    }
    NSLog(@"Parsing Done...");
    NSLog(@"Parsed Weather data is:%@",[WeatherCondition description]);

    [self.delegate didFinishParsing:weatherData];
 
}


@end
