//
//  WeatherListViewController.h
//  SunShine
//
//  Created by udhaykanthd on 5/27/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  WeatherTableViewCell;
@class  WeatherCondition;

@interface WeatherListViewController : UITableViewController<UINavigationControllerDelegate>
-(WeatherTableViewCell*)tableViewCellForWeather:(WeatherCondition*)aWeather;


@end
