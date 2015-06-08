//
//  WeatherTableViewCell.h
//  SunShine
//
//  Created by udhaykanthd on 5/27/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 @class WeatherTableViewCell
 WeatherTableViewCell is a sub-class of UITableViewCell, whose objects functions as custom cell.
 */

@interface WeatherTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView* temperatureStatusImageView;
@property(nonatomic,strong) UILabel *temperatureStatus;
@property(nonatomic,strong) UILabel *maxTemperatureLabel;
@property(nonatomic,strong) UILabel *minTemperatureLabel;
@property(nonatomic,strong) UILabel *dayLabel;
@end
