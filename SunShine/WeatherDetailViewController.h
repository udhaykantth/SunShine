//
//  WeatherDetailViewController.h
//  SunShine
//
//  Created by udhaykanthd on 6/4/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  WeatherCondition;

/*!
 @class WeatherDetailViewController
 WeatherDetailViewController is a    view controller which displays the detail weather condition data.
 */
@interface WeatherDetailViewController : UIViewController
@property(nonatomic,strong) WeatherCondition *detailWeatherCondition;
@end
