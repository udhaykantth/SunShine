//
//  WeatherTableViewCell.m
//  SunShine
//
//  Created by udhaykanthd on 5/27/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherTableViewCell.h"
#define kImageViewWidth  65
#define kImageViewHeight  65
#define kImageViewHeight2  65




@implementation WeatherTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]];
        [self.contentView setBackgroundColor:[UIColor clearColor]];

        [self configureUIControls];

        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configureUIControls
{
    //configure UIControls
    //temperature status image
    _temperatureStatusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y,kImageViewWidth  , kImageViewHeight)];
    [_temperatureStatusImageView setContentMode:UIViewContentModeScaleAspectFill];
    [_temperatureStatusImageView setImage:[UIImage imageNamed:@"ic_clear"]];
    //[_temperatureStatusImageView setBackgroundColor:[UIColor blackColor]];
    
    [self.contentView addSubview:_temperatureStatusImageView];
    
    //create a dayLabel
    _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(kImageViewWidth+10,self.bounds.origin.y, 200, 30)];
     [_dayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30]];
     [_dayLabel setText:@"Tommorrow"];
    [_dayLabel setTextAlignment:NSTextAlignmentLeft];
    [_dayLabel setTextColor:[UIColor whiteColor]];
   // [_dayLabel setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:_dayLabel];
    
    //create a temperatureStatus
    _temperatureStatus = [[UILabel alloc]initWithFrame:CGRectMake(kImageViewWidth+10,self.bounds.origin.y+_dayLabel.frame.size.height, 150, 30)];
    [_temperatureStatus setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:14]];
    [_temperatureStatus setText:@"Rain"];
    [_temperatureStatus setTextAlignment:NSTextAlignmentLeft];
    [_temperatureStatus setTextColor:[UIColor whiteColor]];
   // [_temperatureStatus setBackgroundColor:[UIColor orangeColor]];
    [self.contentView addSubview:_temperatureStatus];
    
    //create a dayLabel
    _maxTemperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(_dayLabel.frame.origin.x+_dayLabel.frame.size.width+10,self.bounds.origin.y,(self.frame.size.width)-( _temperatureStatusImageView.frame.size.width+_dayLabel.frame.size.width)+20, 30)];
    [_maxTemperatureLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30]];
    [_maxTemperatureLabel setText:@"30°"];
    [_maxTemperatureLabel setTextAlignment:NSTextAlignmentCenter];
    [_maxTemperatureLabel setTextColor:[UIColor whiteColor]];
    //[_maxTemperatureLabel setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:_maxTemperatureLabel];
    
    //create a _minTemperatureLabel
    _minTemperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(_dayLabel.frame.origin.x+_dayLabel.frame.size.width+10,self.bounds.origin.y+_temperatureStatus.frame.size.height, (self.frame.size.width)-( _temperatureStatusImageView.frame.size.width+_dayLabel.frame.size.width)+20, 30)];
    [_minTemperatureLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:14]];
    [_minTemperatureLabel setText:@"10°"];
    [_minTemperatureLabel setTextAlignment:NSTextAlignmentCenter];
    [_minTemperatureLabel setTextColor:[UIColor whiteColor]];
    //[_minTemperatureLabel setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:_minTemperatureLabel];

    
    
    
    }
@end
