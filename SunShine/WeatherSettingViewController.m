//
//  WeatherSettingViewController.m
//  SunShine
//
//  Created by udhaykanthd on 6/9/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherSettingViewController.h"

@interface WeatherSettingViewController ()

@end

@implementation WeatherSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configureView {
    [self.view setBackgroundColor:[UIColor redColor]];

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
