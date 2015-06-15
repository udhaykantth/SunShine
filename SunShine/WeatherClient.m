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
#import "WeatherShared.h"




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
- (void)fetchJSONDataFromCoordinates:(CLLocationCoordinate2D)coordinate type:(WeatherConditionType)WeatherconditionType units:(NSString*)units
{
    
    //TODO:// coordinates has to be dynamic
    //frame Url based onthe type of weather condition.
   
    
    NSURL *url;
    NSString *unit;
    if ([units length ] == 0) {
      //default units is metric
        unit = @"metric";
    }
    else
    {
        unit = [units lowercaseString];
    }
    switch (WeatherconditionType) {
        case WeatherConditionTypeCurrent:
            url =  [NSURL URLWithString:[NSString stringWithFormat:@"%@%f&lon=%f&units=%@",WeatherURL_TypeCurrent,coordinate.latitude,coordinate.longitude,unit]];
             
            break;
        case WeatherConditionTypeHourly:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%f&lon=%f&units=%@%@",WeatherURL_TypeHourly,coordinate.latitude,coordinate.longitude, unit,@"&cnt=12"]];
            
             break;
        case WeatherConditionTypeDaily:
            url =  [NSURL URLWithString:[NSString stringWithFormat:@"%@%f&lon=%f&units=%@%@",WeatherURL_TypeDaily,coordinate.latitude,coordinate.longitude, unit,@"&cnt=7"]];
            
            break;
            
        default:
            //as of now default is same as WeatherConditionTypeCurrent
            url =  [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WeatherURL_TypeCurrent,unit]];
            break;
    }
    PRINT_CONSOLE_LOG(url);
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (! error) {
            NSError *jsonError = nil;
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if (! jsonError) {
                //NSLog(@"json data is %@",json);
                WeatherJsonParser* parser = [[WeatherJsonParser alloc]initWithWeatherDataFromJSON:(NSDictionary*)json delegate:self];
                [parser parseJSON];
            }
            else {
                //NSLog(@"Could not get the data!!");
               [self.clientDelegate didFailFetchJSONDataFromWeatherURL];

            }
        }
        else {
            //NSLog(@"No internet connectivity,Try again!!");
            [self.clientDelegate didFailFetchJSONDataFromWeatherURL];

        }
        
    }];
    
    [dataTask resume];
}
-(void)didFinishParsing:(NSMutableArray *)parsedData
{
    //NSLog(@"Parsing Done successfully");
    [self.clientDelegate didFinishFetchJSONDataFromWeatherURL:parsedData];
}
-(void)didFinishParsingWithError:(NSError *)error {
    [self.clientDelegate didFailFetchJSONDataFromWeatherURL];

}
@end
