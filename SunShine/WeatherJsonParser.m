//
//  WeatherJsonParser.m
//  SunShine
//
//  Created by udhaykanthd on 5/29/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherJsonParser.h"
#import "WeatherUtility.h"


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
        NSError *error;
        [self.delegate didFinishParsingWithError:&error];
     }
    //weather parsing for the daily or hourly
    NSMutableArray* weatherMutableArray = [NSMutableArray array];

    NSNumber *count = [json objectForKey:@"cnt"];
    NSLog(@"Count is %@",([count integerValue] == 7)? @"daily Weather":@"Hourly Weather");
     NSArray *weather = [json objectForKey:@"list"];
    if ([weather count] !=0) {
        for (int i =0; i<[weather count]; i++) {
            WeatherCondition* weatherData = [[WeatherCondition alloc]init];
             NSDictionary* weatherDict = [weather objectAtIndex:i];
           
            NSNumber* date = [weatherDict objectForKey:@"dt"];
            if (!(date < 0)) {
                // convert interval into date object
                [weatherData setDay:[[WeatherUtility sharedWeatherUtility]dayFromDateInterval:date]];
                NSLog(@"WJP date:%@",[[WeatherUtility sharedWeatherUtility]dayFromDateInterval:date]);
                
                
            }
            
           
            
            //hourly weather
            if ([count intValue] > 7) {
                
                NSDictionary* main = [weatherDict objectForKey:@"main"];;
                if (main != nil) {
                    NSNumber* humidity = [main objectForKey:@"humidity"];
                    if (!(humidity < 0)) {
                        [weatherData setHumidity:humidity];
                    }
                    NSNumber* temp_min = [main objectForKey:@"temp_min"];
                    
                    NSNumber* temp_max = [main objectForKey:@"temp_max"];
                    
                    [weatherData setCurrentTemperature:TemperatureMake( 0.0, [temp_min doubleValue], [temp_max doubleValue], 0.0,0.0,0.0)];
                    
                    NSNumber* temperature = [main objectForKey:@"temp"];
                    if (!(temperature < 0)) {
                        [weatherData setTemperature:[[WeatherUtility sharedWeatherUtility] numberRoundUpToTwoDigit:temperature]];
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
                
                NSDictionary* clouds = [weatherDict objectForKey:@"clouds"];
                if (clouds != nil) {
                    long all = [[clouds objectForKey:@"all"]longValue];
                    if (!(all < 0)) {
                        //all is not used , so ignored it.
                    }
                    
                }
                NSDictionary* wind = [weatherDict objectForKey:@"wind"];
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
                NSDictionary* rain = [weatherDict objectForKey:@"rain"];
                if (rain!= nil) {
                    //double rainReading= [[rain objectForKey:@"3h"]doubleValue];
                    // 3h is not used , so ignored it.
                    
                }
               NSString *dateTimeString= [weatherDict objectForKey:@"dt_txt"];
                if ([dateTimeString length] > 0) {
                    [weatherData setHourlyDateTime:dateTimeString];
                }
                
                
            }
            else { //daily weather
                //NSNumber* clouds = [weatherDict objectForKey:@"clouds"]; //long value,unused

                NSNumber* pressure = [weatherDict objectForKey:@"pressure"];
                if (!(pressure < 0)) {
                    [weatherData setPressure:pressure];
                }
                NSNumber* humidity = [weatherDict objectForKey:@"humidity"];
                if (!(humidity < 0)) {
                    [weatherData setHumidity:humidity];
                }
                double speed = [[weatherDict objectForKey:@"speed"]doubleValue];
                if (!(speed < 0)) {
                    [weatherData setWindSpeed:[NSNumber numberWithDouble:speed]];
                }
                long  deg = [[weatherDict objectForKey:@"deg"] longValue];
                if (!(deg < 0)) {
                    [weatherData setWindDirection:[NSNumber numberWithLong:deg]];
                }
                
                NSNumber* rain = [weatherDict objectForKey:@"rain"];
                if (rain!= nil) {
                    //double rainReading= [[rain objectForKey:@"3h"]doubleValue];
                    // 3h is not used , so ignored it.
                    
                }
                
            NSDictionary* temperatureDict = [weatherDict objectForKey:@"temp"];
            NSNumber* day = [temperatureDict objectForKey:@"day"];
            NSNumber* min = [temperatureDict objectForKey:@"min"];

            NSNumber* max = [temperatureDict objectForKey:@"max"];

            NSNumber* night = [temperatureDict objectForKey:@"night"];

            NSNumber* eve = [temperatureDict objectForKey:@"eve"];
            NSNumber* morn = [temperatureDict objectForKey:@"morn"];
            [weatherData setCurrentTemperature:TemperatureMake( [day doubleValue], [min doubleValue], [max doubleValue], [night doubleValue], [eve doubleValue], [morn doubleValue])];
            }
           // common for both daily and hourly weather
            
             NSArray* weatherArray= [weatherDict objectForKey:@"weather"];
            
            if ([weatherArray count]> 0) {
                NSDictionary* weatherSubDict = [weatherArray objectAtIndex:0];

                
                long weatherID =[[weatherSubDict objectForKey:@"id"]longValue];
                if (!(weatherID < 0)) {
                    [weatherData setWeatherID:[NSNumber numberWithLong:weatherID]];
                }
                NSString* main= [weatherSubDict objectForKey:@"main"];
                if ([main length]!=0) {
                    [weatherData setWeatherMain:main];
                }
                NSString* icon= [weatherSubDict objectForKey:@"icon"];
                if ([icon length] != 0) {
                    [weatherData setIcon:icon];
                }
                NSString* description= [weatherSubDict objectForKey:@"description"];
                if ([description length]!=0) {
                    [weatherData setWeatherDescription:description];
                }
                
            }
            
            NSDictionary *cityDict = [json objectForKey:@"city"];
            if (cityDict !=nil) {
                NSNumber* locationID = [cityDict objectForKey:@"id"];
                if (!(locationID < 0)) {
                    [weatherData setLocationID:locationID];
                }
                NSString* locationName= [cityDict objectForKey:@"name"];
                if ([locationName length]!=0) {
                    [weatherData setLocationName:locationName];
                }
                NSString* country = [cityDict objectForKey:@"country"];
                if ([country length]!=0) {
                    [weatherData setCountry:country];
                }
                
                // NSString *population = [cityDict objectForKey:@"population"];//Unused field
                NSDictionary* coordinates = [cityDict objectForKey:@"coord"];
                if (coordinates != nil) {
                    double longitude = [[coordinates objectForKey:@"lon"] doubleValue];
                    double latitude = [[coordinates objectForKey:@"lat"]  doubleValue];
                    [weatherData setLocationCoordinate:LocationCoordinatesMake(latitude, longitude)];
                    
                }
                
            }
            
        
            [weatherMutableArray addObject:weatherData];
            
         
        
        }
        [self.delegate didFinishParsing:weatherMutableArray];

    }
}


            
            
           
    
    
   
    /* // Weather parsing for the current weather
     WeatherCondition* weatherData = [[WeatherCondition alloc]init];
    NSString* base = [json objectForKey:@"base"];
    if ([base length]!= 0 && nil != base) {
        [weatherData setBase:base];
    }
    NSNumber* locationID = [json objectForKey:@"id"];
    if (!(locationID < 0)) {
        [weatherData setLocationID:locationID];
    }
    NSNumber* date = [json objectForKey:@"dt"];
    if (!(date < 0)) {
         // convert interval into date object
        [weatherData setDay:[[WeatherUtility sharedWeatherUtility]dayFromDateInterval:date]];
        NSLog(@"WJP date:%@",[[WeatherUtility sharedWeatherUtility]dayFromDateInterval:date]);

        
    }
    NSDictionary* main = [json objectForKey:@"main"];
    if (main != nil) {
        NSNumber* humidity = [main objectForKey:@"humidity"];
        if (!(humidity < 0)) {
            [weatherData setHumidity:humidity];
        }
        NSNumber* temp_min = [main objectForKey:@"temp_min"];
        if (!(temp_min < 0)) {
            
            [weatherData setTemperatureLow:[[WeatherUtility sharedWeatherUtility] numberRoundUpToTwoDigit:temp_min]];
        }
        NSNumber* temp_max = [main objectForKey:@"temp_max"];
        if (!(temp_max < 0)) {
            [weatherData setTemperatureHigh:[[WeatherUtility sharedWeatherUtility] numberRoundUpToTwoDigit:temp_max]];
        }
        NSNumber* temperature = [main objectForKey:@"temp"];
        if (!(temperature < 0)) {
            [weatherData setTemperature:[[WeatherUtility sharedWeatherUtility] numberRoundUpToTwoDigit:temperature]];
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
                [weatherData setWeatherID:[NSNumber numberWithLong:weatherID]];
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
    NSLog(@"Parsed Weather data is:%@",[weatherData description]);
     NSMutableArray* weatherArray = [NSMutableArray array];
    [weatherArray addObject:weatherData];

    [self.delegate didFinishParsing:weatherArray];
     */
 
    


@end
