//
//  WeatherUtility.m
//  SunShine
//
//  Created by udhaykanthd on 6/1/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherUtility.h"

@interface WeatherUtility()
@property(nonatomic,strong)NSNumberFormatter *numberFormatter;
@property(nonatomic,strong)NSDateFormatter *dateFormatter;

@end

@implementation WeatherUtility

+ (instancetype)sharedWeatherUtility
{
    static WeatherUtility *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _numberFormatter = [[NSNumberFormatter alloc]init];
        _dateFormatter = [[NSDateFormatter alloc ] init];
        
    }
    return self;
}

-(UIImage*) weatherIconFromString:(NSString*) iconID {
     NSString *imageName;
   
    if ([iconID isEqualToString:@"01d"]) {
        imageName = @"ic_clear";
        
    } else if ([iconID isEqualToString:@"02d"] ) {
        imageName = @"ic_light_clouds";
    }
    else if ([iconID isEqualToString:@"03d"] ||[iconID isEqualToString:@"04d"] ) {
        imageName = @"ic_cloudy";
    }
     
    else if ([iconID isEqualToString:@"09d"] ) {
        imageName = @"ic_light_rain";
    }
    else if ([iconID isEqualToString:@"10d"] ) {
        imageName = @"ic_rain";
    }
    else if ([iconID isEqualToString:@"11d"] ) {
        imageName = @"ic_storm";
    }
    else if ([iconID isEqualToString:@"13d"] ) {
        imageName = @"ic_snow";
    }
    else if ([iconID isEqualToString:@"50d"] ) {
        imageName = @"ic_fog";
    }
    else
        {
            imageName = @"default";
            
        }
    UIImage *iconImage = [UIImage imageNamed:imageName ];
    return iconImage;
    
}
-(UIImage*) weatherArtFromString:(NSString*) iconID {
    NSString *imageName;
    
    if ([iconID isEqualToString:@"01d"]) {
        imageName = @"art_clear";
        
    } else if ([iconID isEqualToString:@"02d"] ) {
        imageName = @"art_light_clouds";
    }
    else if ([iconID isEqualToString:@"03d"] ||[iconID isEqualToString:@"04d"] ) {
        imageName = @"art_clouds";
    }
    
    else if ([iconID isEqualToString:@"09d"] ) {
        imageName = @"art_light_rain";
    }
    else if ([iconID isEqualToString:@"10d"] ) {
        imageName = @"art_rain";
    }
    else if ([iconID isEqualToString:@"11d"] ) {
        imageName = @"art_storm";
    }
    else if ([iconID isEqualToString:@"13d"] ) {
        imageName = @"art_snow";
    }
    else if ([iconID isEqualToString:@"50d"] ) {
        imageName = @"art_fog";
    }
    else
    {
        imageName = @"default";
        
    }
    UIImage *iconImage = [UIImage imageNamed:imageName ];
    return iconImage;
    
}

-(NSString*)numberRoundUpToTwoDigit:(NSNumber*)decimalNum {
    [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [_numberFormatter setMaximumFractionDigits:1];
    [_numberFormatter setRoundingMode:NSNumberFormatterRoundUp];

    NSString *numberString = [NSString stringWithFormat:@"%@°",[_numberFormatter stringFromNumber:decimalNum]];
    NSLog(@"Result...%@",numberString);
    return numberString;
}
-(NSString*)dateStringFromIntervalTime:(NSNumber*) interval {
 
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return  [_dateFormatter stringFromDate:date];
}
-(NSString*)dayFromDateInterval:(NSNumber*) interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    [_dateFormatter setDateFormat:@"EEEE"];
    //return  [NSString stringWithFormat:@"Today, %@",[_dateFormatter stringFromDate:date]];
    return  [_dateFormatter stringFromDate:date];

}

@end
