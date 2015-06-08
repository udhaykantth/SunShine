//
//  WeatherDetailViewController.m
//  SunShine
//
//  Created by udhaykanthd on 6/4/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherDetailViewController.h"
 #import "WeatherCondition.h"
#import "WeatherUtility.h"

@interface WeatherDetailViewController ()
@property(nonatomic,strong) UIView *containerView;
@property(nonatomic,strong) UILabel *humidity;
@property(nonatomic,strong) UILabel *humidityValue;
@property(nonatomic,strong) UILabel *pressure;
@property(nonatomic,strong) UILabel *pressureValue;
@property(nonatomic,strong) UILabel *date;
@property(nonatomic,strong) UILabel *dateValue;
@property(nonatomic,strong) UILabel *dayTemperature;
@property(nonatomic,strong) UILabel *dayTemperatureValue;
@property(nonatomic,strong) UILabel *minimumTemperature;
@property(nonatomic,strong) UILabel *minimumTemperatureValue;
@property(nonatomic,strong) UILabel *maximumTemperature;
@property(nonatomic,strong) UILabel *maximumTemperatureValue;
@property(nonatomic,strong) UILabel *nightTemperature;
@property(nonatomic,strong) UILabel *nightTemperatureValue;
@property(nonatomic,strong) UILabel *eveningTemperature;
@property(nonatomic,strong) UILabel *eveningTemperatureValue;
@property(nonatomic,strong) UILabel *morningTemperature;
@property(nonatomic,strong) UILabel *morningTemperatureValue;
@property(nonatomic,strong) UILabel *speed;
@property(nonatomic,strong) UILabel *speedValue;
@property(nonatomic,strong) UILabel *deg;
@property(nonatomic,strong) UILabel *degValue;
@property(nonatomic,strong) UILabel *topDescription;



@end

@implementation WeatherDetailViewController

#pragma mark --View methods

- (void)viewDidLoad {
    //NSLog(@"[%s]",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"Day Weather Report"];
    [self.view setBackgroundColor:[UIColor colorWithRed:74.0/255 green:144.0/255 blue:226.0/255 alpha:1.0]];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configureView {
    //NSLog(@"[%s]",__PRETTY_FUNCTION__);
    //NSLog(@"detail data:%@",[_detailWeatherCondition description]);

    if (self.detailWeatherCondition) {
        //update the user interface with weather in detail.
        if (_containerView == nil) {
            
            
            _containerView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x
                                                                     , 100.0, self.view.bounds.size.width, (self.view.bounds.size.height)-130)];
            int humidityY =100;
            int halfContainerViewWidth = _containerView.bounds.size.width/2;
            int fullContainerViewWidth = _containerView.bounds.size.width;

            int labelHeight = 20;
            
           // [_containerView setBackgroundColor:[UIColor redColor]];
            //NSLog(@"_containerframe:%@",NSStringFromCGRect(_containerView.frame));
            
            _topDescription = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x+20, _containerView.bounds.origin.y, fullContainerViewWidth-(labelHeight*2), labelHeight*4)];
            //[_topDescription setBackgroundColor:[UIColor blackColor]];
            [_topDescription setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            
            //TODO:// night description hard coded.
            [_topDescription setText:[NSString stringWithFormat:@"%@: %@.The high will be %@.Mostly cloudy night with a low of %@.",_detailWeatherCondition.day,_detailWeatherCondition.weatherDescription,[[WeatherUtility sharedWeatherUtility] stringFromTwoDigitRoundUpDecimal:_detailWeatherCondition.currentTemperature.maxTemperature],[[WeatherUtility sharedWeatherUtility] stringFromTwoDigitRoundUpDecimal:_detailWeatherCondition.currentTemperature.minTemperature]]];
            [_topDescription setTextAlignment:NSTextAlignmentLeft];
            [_topDescription setNumberOfLines:3];
            [_topDescription setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _topDescription];
            
            
            _humidity = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, _containerView.bounds.origin.y+ humidityY, halfContainerViewWidth, labelHeight)];
           // [_humidity setBackgroundColor:[UIColor blackColor]];
            [_humidity setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_humidity setText:@"Humidity:"];
            [_humidity setTextAlignment:NSTextAlignmentRight];
            [_humidity setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _humidity];
            
            _humidityValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ humidityY, halfContainerViewWidth, labelHeight)];
           // [_humidityValue setBackgroundColor:[UIColor whiteColor]];
             [_humidityValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_humidityValue setText:[NSString stringWithFormat:@"%@ %@",[_detailWeatherCondition.humidity stringValue],@"%"]];
            [_humidityValue setTextAlignment:NSTextAlignmentLeft];
            [_humidityValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _humidityValue];
            
            int pressureY = humidityY+_humidity.frame.size.height+5;
            
            _pressure = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, pressureY, halfContainerViewWidth, labelHeight)];
           // [_pressure setBackgroundColor:[UIColor blackColor]];
            [_pressure setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_pressure setText:@"Pressure:"];
            [_pressure setTextAlignment:NSTextAlignmentRight];
            [_pressure setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _pressure];
            
            _pressureValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ pressureY, halfContainerViewWidth, labelHeight)];
          //  [_pressureValue setBackgroundColor:[UIColor whiteColor]];
            [_pressureValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_pressureValue setText:[NSString stringWithFormat:@"%0.f hPa",[_detailWeatherCondition.pressure doubleValue]]];
            [_pressureValue setTextAlignment:NSTextAlignmentLeft];
            [_pressureValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _pressureValue];
            
            int dateY = pressureY+_pressure.frame.size.height+5;
            _date = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, dateY, halfContainerViewWidth, labelHeight)];
            //[_date setBackgroundColor:[UIColor blackColor]];
            [_date setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_date setText:@"Day:"];
            [_date setTextAlignment:NSTextAlignmentRight];
            [_date setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _date];
            
            _dateValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ dateY, halfContainerViewWidth, labelHeight)];
           // [_dateValue setBackgroundColor:[UIColor whiteColor]];
            [_dateValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_dateValue setText:_detailWeatherCondition.day];
            [_dateValue setTextAlignment:NSTextAlignmentLeft];
            [_dateValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _dateValue];
            
            int dayY = dateY+_date.frame.size.height+5;
            _dayTemperature = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, dayY, halfContainerViewWidth, labelHeight)];
           // [_dayTemperature setBackgroundColor:[UIColor blackColor]];
            [_dayTemperature setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_dayTemperature setText:@"Day Temperature:"];
            [_dayTemperature setTextAlignment:NSTextAlignmentRight];
            [_dayTemperature setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _dayTemperature];
            
            _dayTemperatureValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ dayY, halfContainerViewWidth, labelHeight)];
           // [_dayTemperatureValue setBackgroundColor:[UIColor whiteColor]];
            [_dayTemperatureValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_dayTemperatureValue setText:[NSString stringWithFormat:@"%0.f°", _detailWeatherCondition.currentTemperature.dayTemperature]];
            [_dayTemperatureValue setTextAlignment:NSTextAlignmentLeft];
            [_dayTemperatureValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _dayTemperatureValue];
            
            int minTemperatureY = dayY+_dayTemperature.frame.size.height+5;
            _minimumTemperature = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, minTemperatureY, halfContainerViewWidth, labelHeight)];
            //[_minimumTemperature setBackgroundColor:[UIColor blackColor]];
            [_minimumTemperature setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_minimumTemperature setText:@"Min Temperature:"];
            [_minimumTemperature setTextAlignment:NSTextAlignmentRight];
            [_minimumTemperature setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _minimumTemperature];
            
            _minimumTemperatureValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ minTemperatureY, halfContainerViewWidth, labelHeight)];
           // [_minimumTemperatureValue setBackgroundColor:[UIColor whiteColor]];
            [_minimumTemperatureValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_minimumTemperatureValue setText:[NSString stringWithFormat:@"%0.f°", _detailWeatherCondition.currentTemperature.minTemperature]];
            
            
            [_minimumTemperatureValue setTextAlignment:NSTextAlignmentLeft];
            [_minimumTemperatureValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _minimumTemperatureValue];
            
            int maxTemperatureY = minTemperatureY+_minimumTemperature.frame.size.height+5;
            _maximumTemperature = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, maxTemperatureY, halfContainerViewWidth, labelHeight)];
           // [_maximumTemperature setBackgroundColor:[UIColor blackColor]];
            [_maximumTemperature setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_maximumTemperature setText:@"Max Temperature:"];
            [_maximumTemperature setTextAlignment:NSTextAlignmentRight];
            [_maximumTemperature setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _maximumTemperature];
            
            _maximumTemperatureValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ maxTemperatureY, halfContainerViewWidth, labelHeight)];
           // [_maximumTemperatureValue setBackgroundColor:[UIColor whiteColor]];
            [_maximumTemperatureValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_maximumTemperatureValue setText:[NSString stringWithFormat:@"%0.f°", _detailWeatherCondition.currentTemperature.maxTemperature]];
            
            [_maximumTemperatureValue setTextAlignment:NSTextAlignmentLeft];
            [_maximumTemperatureValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _maximumTemperatureValue];
            
            int nightTemperatureY = maxTemperatureY+_maximumTemperature.frame.size.height+5;
            _nightTemperature = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, nightTemperatureY, halfContainerViewWidth, labelHeight)];
           // [_nightTemperature setBackgroundColor:[UIColor blackColor]];
            [_nightTemperature setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_nightTemperature setText:@"Night Temperature:"];
            [_nightTemperature setTextAlignment:NSTextAlignmentRight];
            [_nightTemperature setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _nightTemperature];
            
            _nightTemperatureValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ nightTemperatureY, halfContainerViewWidth, labelHeight)];
           // [_nightTemperatureValue setBackgroundColor:[UIColor whiteColor]];
            [_nightTemperatureValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_nightTemperatureValue setText:[NSString stringWithFormat:@"%0.f°",_detailWeatherCondition.currentTemperature.nightTemperature]];
            
            [_nightTemperatureValue setTextAlignment:NSTextAlignmentLeft];
            [_nightTemperatureValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _nightTemperatureValue];
            
            int eveningTemperatureY = nightTemperatureY+_nightTemperature.frame.size.height+5;
            _eveningTemperature = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, eveningTemperatureY, halfContainerViewWidth, labelHeight)];
           // [_eveningTemperature setBackgroundColor:[UIColor blackColor]];
            [_eveningTemperature setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_eveningTemperature setText:@"Evening Temperature:"];
            [_eveningTemperature setTextAlignment:NSTextAlignmentRight];
            [_eveningTemperature setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _eveningTemperature];
            
            _eveningTemperatureValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ eveningTemperatureY, halfContainerViewWidth, labelHeight)];
           // [_eveningTemperatureValue setBackgroundColor:[UIColor whiteColor]];
            [_eveningTemperatureValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_eveningTemperatureValue setText:[NSString stringWithFormat:@"%0.f°",_detailWeatherCondition.currentTemperature.eveningTemperature]];
            
            [_eveningTemperatureValue setTextAlignment:NSTextAlignmentLeft];
            [_eveningTemperatureValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _eveningTemperatureValue];
            
            int morningTemperatureY = eveningTemperatureY+_eveningTemperature.frame.size.height+5;
            _morningTemperature = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, morningTemperatureY, halfContainerViewWidth, labelHeight)];
           // [_morningTemperature setBackgroundColor:[UIColor blackColor]];
            [_morningTemperature setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_morningTemperature setText:@"Morning Temperature:"];
            [_morningTemperature setTextAlignment:NSTextAlignmentRight];
            [_morningTemperature setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _morningTemperature];
            
            _morningTemperatureValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ morningTemperatureY, halfContainerViewWidth, labelHeight)];
            //[_morningTemperatureValue setBackgroundColor:[UIColor whiteColor]];
            [_morningTemperatureValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_morningTemperatureValue setText:[NSString stringWithFormat:@"%0.f°",_detailWeatherCondition.currentTemperature.morningTemperature]];
            
            [_morningTemperatureValue setTextAlignment:NSTextAlignmentLeft];
            [_morningTemperatureValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _morningTemperatureValue];
            
            int speedY = morningTemperatureY+_morningTemperature.frame.size.height+5;
            _speed = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, speedY, halfContainerViewWidth, labelHeight)];
          //  [_speed setBackgroundColor:[UIColor blackColor]];
            [_speed setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_speed setText:@"Speed:"];
            [_speed setTextAlignment:NSTextAlignmentRight];
            [_speed setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _speed];
            
            _speedValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ speedY, halfContainerViewWidth, labelHeight)];
           // [_speedValue setBackgroundColor:[UIColor whiteColor]];
            [_speedValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_speedValue setText:[NSString stringWithFormat:@"%@ %@",[_detailWeatherCondition.windSpeed stringValue],@"km/h"]];
            [_speedValue setTextAlignment:NSTextAlignmentLeft];
            [_speedValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _speedValue];
           
            int degY = speedY+_speed.frame.size.height+5;
            _deg = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, degY, halfContainerViewWidth, labelHeight)];
           // [_deg setBackgroundColor:[UIColor blackColor]];
            [_deg setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_deg setText:@"Deg:"];
            [_deg setTextAlignment:NSTextAlignmentRight];
            [_deg setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _deg];
            
            _degValue = [[UILabel alloc]initWithFrame:CGRectMake(halfContainerViewWidth+10, _containerView.bounds.origin.y+ degY, halfContainerViewWidth, labelHeight)];
           // [_degValue setBackgroundColor:[UIColor whiteColor]];
            [_degValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
            [_degValue setText:[_detailWeatherCondition.windDirection stringValue]];
            [_degValue setTextAlignment:NSTextAlignmentLeft];
            [_degValue setTextColor:[UIColor whiteColor]];
            [_containerView addSubview: _degValue];
            
            
            
           // NSLog(@"_humidity:%@",NSStringFromCGRect(_humidity.frame));
           // NSLog(@"_humidityValue:%@",NSStringFromCGRect(_humidityValue.frame));

            
            
            
            
            
            
            
            [self.view addSubview: _containerView];
        
            
        }
        else
        {
        }
        
    }

}

#pragma mark -- detailWeatherCondition
-(void)setDetailWeatherCondition :(WeatherCondition*)newDetailItem{
    //NSLog(@"[%s]",__PRETTY_FUNCTION__);

    if (_detailWeatherCondition != newDetailItem) {
        _detailWeatherCondition = newDetailItem;
        //Update the view.
       //. [self configureView];
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
