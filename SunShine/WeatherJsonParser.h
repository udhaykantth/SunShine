//
//  WeatherJsonParser.h
//  SunShine
//
//  Created by udhaykanthd on 5/29/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherCondition.h"


@protocol WeatherJsonParserDelegate <NSObject>

-(void)didFinishParsing:(NSMutableArray*)parsedData;
-(void)didFinishParsingWithError:(NSError**) error;

@end

@interface WeatherJsonParser : NSObject
@property(nonatomic,weak)id<WeatherJsonParserDelegate>delegate;
-(instancetype)initWithWeatherDataFromJSON:(NSDictionary*)json delegate:(id<WeatherJsonParserDelegate>)delegate;
-(void)parseJSON;


@end
