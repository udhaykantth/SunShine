//
//  WeatherDetailViewController.m
//  SunShine
//
//  Created by udhaykanthd on 6/4/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherDetailViewController.h"
 #import "WeatherCondition.h"

@interface WeatherDetailViewController ()
 
@end

@implementation WeatherDetailViewController

- (void)viewDidLoad {
    NSLog(@"[%s]",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configureView {
    NSLog(@"[%s]",__PRETTY_FUNCTION__);
    NSLog(@"detail data:%@",[_detailWeatherCondition description]);

    if (self.detailWeatherCondition) {
        //update the user interface with weather in detail.
        
    }

}

#pragma mark -- detailWeatherCondition
-(void)setDetailWeatherCondition :(WeatherCondition*)newDetailItem{
    NSLog(@"[%s]",__PRETTY_FUNCTION__);

    if (_detailWeatherCondition != newDetailItem) {
        _detailWeatherCondition = newDetailItem;
        //Update the view.
        [self configureView];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
