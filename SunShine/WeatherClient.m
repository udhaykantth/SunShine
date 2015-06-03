//
//  WeatherClient.m
//  SunShine
//
//  Created by udhaykanthd on 5/28/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherClient.h"
#import "WeatherJsonParser.h"
#import "WeatherCondition.h"

#define WeatherURL @""

@interface WeatherClient()
@property(nonatomic,strong) NSURLSession *session;

@end

@implementation WeatherClient
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration ];
        _session = [NSURLSession sessionWithConfiguration:defaultConfig ];
    }
    return self;
}
- (void)fetchJSONDataFromWeatherURL:(NSURL *)url {
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if (! jsonError) {
                NSLog(@"json data is %@",json);
                WeatherJsonParser *parse = [[WeatherJsonParser alloc]initWithWeatherDataFromJSON:(NSDictionary*)json delegate:self];
                
             }
            else {
             }
        }
        else {
         }
        
     }];
    
    [dataTask resume];
}
//- (void)fetchJSONDataFromCoordinates:(CLLocationCoordinate2D)coordinate
- (void)fetchJSONDataFromCoordinates:(CLLocationCoordinate2D)coordinate type:(WeatherConditionType)WeatherconditionType;
{
    
    //TODO:// coordinates has to be dynamic and metrics
    //frame Url based onthe type of weather condition.
    NSURL *url;
    switch (WeatherconditionType) {
        case WeatherConditionTypeCurrent:
            url =  [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?lat=17.38&lon=78.47&units=metric"];
            
            break;
        case WeatherConditionTypeHourly:
            url = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/forecast?lat=17.3700&lon=78.4800&units=metric&cnt=12"];
            
             break;
        case WeatherConditionTypeDaily:
            url =  [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=17.3700&lon=78.4800&units=metric&cnt=7"];
           
            break;
            
        default:
            url =  [NSURL URLWithString:@"http://www.google.com"];
            break;
    }
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if (! jsonError) {
                NSLog(@"json data is %@",json);
                WeatherJsonParser* parser = [[WeatherJsonParser alloc]initWithWeatherDataFromJSON:(NSDictionary*)json delegate:self];
                [parser parseJSON];
            }
            else {
                NSLog(@"Could not get the data!!");
            }
        }
        else {
            NSLog(@"Unable to connect to the server,Try again!!");

        }
        
    }];
    
    [dataTask resume];
}
-(void)didFinishParsing:(NSMutableArray *)parsedData
{
    NSLog(@"Parsing Done successfully");
    [self.clientDelegate didFinishFetchJSONDataFromWeatherURL:parsedData];
}
@end
