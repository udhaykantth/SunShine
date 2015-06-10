//
//  WeatherSettingViewController.h
//  SunShine
//
//  Created by udhaykanthd on 6/9/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WeatherSettingViewControllerDelegate <NSObject>

-(void)dissmissViewContorller;

@end

@interface WeatherSettingViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,weak)id<WeatherSettingViewControllerDelegate> delegate;

@end
