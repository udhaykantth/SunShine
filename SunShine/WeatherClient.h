//
//  WeatherClient.h
//  SunShine
//
//  Created by udhaykanthd on 5/28/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherClient : NSObject
- (void)fetchJSONDataFromWeatherURL:(NSURL *)url;

@end
