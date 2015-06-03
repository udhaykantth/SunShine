//
//  WeatherUtility.h
//  SunShine
//
//  Created by udhaykanthd on 6/1/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface WeatherUtility : NSObject
+ (instancetype)sharedWeatherUtility;
-(UIImage*) weatherIconFromString:(NSString*) iconID;
-(UIImage*) weatherArtFromString:(NSString*) iconID;
-(NSString*)numberRoundUpToTwoDigit:(NSNumber*)tempInDecimal;
-(NSString*)dateStringFromIntervalTime:(NSNumber*) interval;
-(NSString*)dayFromDateInterval:(NSNumber*) interval;
-(NSString*)stringFromTwoDigitRoundUpDecimal:(double)decimal;



@end
