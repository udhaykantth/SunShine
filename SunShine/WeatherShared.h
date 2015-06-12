//
//  WeatherShared.h
//  SunShine
//
//  Created by udhaykanthd on 6/11/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#ifndef SunShine_WeatherShared_h
#define SunShine_WeatherShared_h

//Setting view Constants
#define UNITS @"UNITS"
#define LOCATION_NAME @"LOCATION"
#define UNITS_PREFERENCE @"UNITS_PREFERENCE"
#define DEFAULT_UNIT @"metric"

//List view Constants
#define kCellHeight 65.0

//Print Logs
#ifdef DEBUG
#define PRINT_CONSOLE_LOG(message)  \
if(message!=nil) \
NSLog(@"[%@ %@]-[Debug message:%@]",[self class],NSStringFromSelector(_cmd),message);\
else \
NSLog(@"[%@ %@]",[self class],NSStringFromSelector(_cmd));
#else
#define PRINT_CONSOLE_LOG(...) NSLog(@"[%@ %@]",[self class],NSStringFromSelector(_cmd));
#endif


//UITextField tags
#define  LOCATION_TEXTFIELD_TAG 1001
#define  UNITS_TEXTFIELD_TAG 1002

//Weather client request urls
#define  WeatherURL_TypeCurrent @"http://api.openweathermap.org/data/2.5/weather?lat=17.38&lon=78.47&units="
#define  WeatherURL_TypeHourly @"http://api.openweathermap.org/data/2.5/forecast?lat=17.3700&lon=78.4800&units="
#define  WeatherURL_TypeDaily   @"http://api.openweathermap.org/data/2.5/forecast/daily?lat=17.3700&lon=78.4800&units="

//weathersettingViewController constants
#define WeatherSettingBackgroundColor [UIColor colorWithRed:74.0/255.0 green:144.0/255.0 blue:226.0/255.0 alpha:1.0]

#endif

