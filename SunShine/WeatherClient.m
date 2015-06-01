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
- (void)fetchJSONDataFromCoordinates:(CLLocationCoordinate2D)coordinate
{
    
    //TODO:// coordinates has to be dynamic.
    NSURL *url = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?lat=17.38&lon=78.47&units=metric"];
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
            }
        }
        else {
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
