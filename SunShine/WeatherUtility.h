//
//  WeatherUtility.h
//  SunShine
//
//  Created by udhaykanthd on 6/1/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
/*!
 @class WeatherUtility
 WeatherUtility is a utility single ton class whose objects functions to retrieve image from bundle,
 round up the decimal digits,gets string date from interval time.
 */

@interface WeatherUtility : NSObject
/*!
 @method sharedWeatherUtility
 @abstract  single ton weather utility class.
 @result creates an singleton weather utility class.
 */
+ (instancetype)sharedWeatherUtility;
/*!
 @method weatherIconFromString
 @abstract  gets the weather icon images from the bundle by provided icon as string.
 @param iconID, name of the icon image.
 @result  retrieves the weather icon image from given icon id.
 */
-(UIImage*) weatherIconFromString:(NSString*) iconID;
/*!
 @method weatherArtFromString
 @abstract gets the weather art images from the bundle by provided art image as string.
 @param iconID, name of the icon image.
 @result retrieves the weather art image from given icon id.
 */
-(UIImage*) weatherArtFromString:(NSString*) iconID;
/*!
 @method numberRoundUpToTwoDigit
 @abstract  round up the decimal number up to one/two digit.
 @param tempInDecimal, temperature value in decimal.
 @result round up the decimal number up to one/two digit
 */
-(NSString*)numberRoundUpToTwoDigit:(NSNumber*)tempInDecimal;
/*!
 @method dateStringFromIntervalTime
 @abstract  conversion of interval time into short style string date .
 @param interval, time interval in numbers.
 @result Converts the interval time into short style date format.
 */
-(NSString*)dateStringFromIntervalTime:(NSNumber*) interval;
/*!
 @method dayFromDateInterval
 @abstract  Conversion of interval time into day of the week.
 @param interval, time interval in numbers.
 @result Conversion of interval time into day of the week.
 */
-(NSString*)dayFromDateInterval:(NSNumber*) interval;
/*!
 @method stringFromTwoDigitRoundUpDecimal
 @abstract Conversion of decimal number into string with round up one/two digits.
 @param decimal digit.
 @result  Conversion of decimal number into string with round up one/two digits.
 */
-(NSString*)stringFromTwoDigitRoundUpDecimal:(double)decimal;



@end
