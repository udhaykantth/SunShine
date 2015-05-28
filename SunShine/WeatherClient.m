//
//  WeatherClient.m
//  SunShine
//
//  Created by udhaykanthd on 5/28/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherClient.h"
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
                
             }
            else {
             }
        }
        else {
         }
        
     }];
    
    [dataTask resume];
}

@end
