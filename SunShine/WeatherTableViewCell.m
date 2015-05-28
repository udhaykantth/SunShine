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
        //configure UIControls
        _temperatureStatusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y,kImageViewWidth  , kImageViewHeight)];
        [_temperatureStatusImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_temperatureStatusImageView setBackgroundColor:[UIColor blackColor]];
        
        [self.contentView addSubview:_temperatureStatusImageView];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]];
        
         
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        

        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
