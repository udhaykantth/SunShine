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
/*!
 @class WeatherListViewController
 WeatherListViewController is a  table view controller which list the weather data,animate on select the cell(Push or pop),refreshes the data by pulling the list view.
 */

@interface WeatherListViewController : UITableViewController<UINavigationControllerDelegate>

/*!
 @method tableViewCellForWeather
 @abstract  gets the selected view cell from the selected weatherCondition data.
 @param aWeather, selected  weather condition object.
 @result  retrieves the selected cell from the selected weather condition data.
 */
-(WeatherTableViewCell*)tableViewCellForWeather:(WeatherCondition*)aWeather;


@end
