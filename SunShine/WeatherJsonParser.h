//
//  WeatherJsonParser.h
//  SunShine
//
//  Created by udhaykanthd on 5/29/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherCondition.h"

/*!
 @class WeatherJsonParserDelegate
 WeatherJsonParserDelegate  is used to acknowledge the parsing completed successfully or not to its delegated object.
 */
@protocol WeatherJsonParserDelegate <NSObject>
/*!
 @method didFinishParsing
 @abstract  invoked once the parsing is done successfully.
 @param parsed json data.
 @result delegated by the weather client api, once json data parsed sucessfully.
 */

-(void)didFinishParsing:(NSMutableArray*)parsedData;
/*!
 @method didFinishParsingWithError
 @abstract invoked once the parsing is failed.
 @param error description.
 @result delegated by the weather client api, once json data parse failed.
 */
-(void)didFinishParsingWithError:(NSError*) error;

@end
/*!
 @class WeatherJsonParser
 WeatherJsonParser is a class whose objects functions json parsing which downloaded from the server & instatiate the parsing delegate.
 */

@interface WeatherJsonParser : NSObject
@property(nonatomic,weak)id<WeatherJsonParserDelegate>delegate;
/*!
 @method initWithWeatherDataFromJSON
 @abstract Initializes an WeatherJsonParser with the given
 delegate and json data.
 @discussion init weatherjsonparser object with json data and delegate object.
 @param json.
 @param weather json parser delegate.
 @result  creates the object with json data and delegate object.
 */
-(instancetype)initWithWeatherDataFromJSON:(NSDictionary*)json delegate:(id<WeatherJsonParserDelegate>)delegate;
/*!
 @method parseJSON
 @abstract parse the json data downloaded from the server.
 @result parse the json data and stores in weatherCondition object.
 */
-(void)parseJSON;


@end
