//
//  WeatherSettingViewController.m
//  SunShine
//
//  Created by udhaykanthd on 6/9/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherSettingViewController.h"
#define UNITS @"UNITS"
#define LOCATION_NAME @"LOCATION"

@interface WeatherSettingViewController ()
@property(nonatomic,strong) UIView *containerView;
@property(nonatomic,strong) UILabel *location;
@property(nonatomic,strong) UITextField *locationValue;
@property(nonatomic,strong) UILabel *temperatureUnits;
@property(nonatomic,strong)  UIButton *temperatureUnitsValue;
@property(nonatomic,strong) UIPickerView *unitsPickerView;
@property(nonatomic,strong) NSArray *pickerViewData;
@property(nonatomic,strong) NSMutableDictionary *selectedData;


@end

@implementation WeatherSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    [self.navigationItem setRightBarButtonItem:doneItem];
    [self.navigationItem setLeftBarButtonItem:cancelItem];
    _selectedData = [[NSMutableDictionary alloc]init];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configureView {
    [self.view setBackgroundColor:[UIColor colorWithRed:74.0/255.0 green:144.0/255.0 blue:226.0/255.0 alpha:1.0]];
    int mainViewHeight = self.view.bounds.size.height;
    int mainViewWidth = self.view.bounds.size.width;
    int mainViewX = self.view.bounds.origin.x;
    int mainViewY = self.view.bounds.origin.y;
    int labelHeight = 30;
    
    int containViewY = 150.0;
    _containerView = [[UIView alloc]initWithFrame:CGRectMake( mainViewX, containViewY, mainViewWidth, mainViewHeight-mainViewX-200)];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    
     _location = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, _containerView.bounds.origin.y+10, mainViewWidth/2, labelHeight)];
    // [_humidity setBackgroundColor:[UIColor blackColor]];
    [_location setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [_location setText:@"Location:"];
    [_location setTextAlignment:NSTextAlignmentRight];
    [_location setTextColor:[UIColor blackColor]];
    [_containerView addSubview: _location];
    
    _locationValue = [[UITextField alloc]initWithFrame:CGRectMake(mainViewWidth/2+10, _containerView.bounds.origin.y, mainViewWidth/2, 50)];
    [_locationValue setPlaceholder:@"Location value"];
    [_locationValue setDelegate:self];
    [_locationValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [_locationValue setTextAlignment:NSTextAlignmentLeft];
    [_locationValue setTextColor:[UIColor blackColor]];
    [_containerView addSubview: _locationValue];
    
    int temperatureUnitY = _location.frame.origin.y+_location.frame.size.height+10;
    
    _temperatureUnits = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, temperatureUnitY, mainViewWidth/2, labelHeight)];
    [_temperatureUnits setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [_temperatureUnits setText:@"Temperature Units:"];
    [_temperatureUnits setTextAlignment:NSTextAlignmentRight];
    [_temperatureUnits setTextColor:[UIColor blackColor]];
    [_containerView addSubview: _temperatureUnits];
    
    
    
    _temperatureUnitsValue = [UIButton buttonWithType:UIButtonTypeSystem];
    [_temperatureUnitsValue setFrame:CGRectMake(mainViewWidth/2+10, temperatureUnitY+3, mainViewWidth/2, 25)];
    
//    NSDictionary *attributeDict = nil;
//    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
//    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    [style setAlignment:NSTextAlignmentLeft];
//    
//    attributeDict = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
//                      NSFontAttributeName:font,
//                      NSParagraphStyleAttributeName:style};
//    
//    [_temperatureUnitsValue setAttributedTitle:[[NSAttributedString alloc]initWithString:@"united states of america" attributes:attributeDict] forState:UIControlStateNormal];
     //[_temperatureUnitsValue setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_temperatureUnitsValue addTarget:self action:@selector(unitTemperature:) forControlEvents:UIControlEventTouchUpInside];
    //[_temperatureUnitsValue setBackgroundColor:[UIColor blackColor]];
    [_temperatureUnitsValue setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //[_temperatureUnitsValue setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_containerView addSubview: _temperatureUnitsValue];
    
    _pickerViewData = [NSArray arrayWithObjects:@"None",@"Metric",@"Imperial", nil];

    
    
    
    [self.view addSubview:_containerView];
    

}
-(void)unitTemperature:(id)sender {
    NSLog(@"sender is:%@",(UIButton*)[sender titleLabel].text);
    if (_unitsPickerView == nil) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        //CGFloat pickerViewWidth = screenWidth *3/4;
        
        _unitsPickerView = [[UIPickerView alloc]init];
        [_unitsPickerView setDataSource:self];
        [_unitsPickerView setDelegate:self];
        [_unitsPickerView setFrame:CGRectMake(0, screenWidth/2-40, screenWidth, screenWidth/2)];
        NSLog(@"pickerFrame:%@",NSStringFromCGRect(_unitsPickerView.frame));
        [_containerView addSubview: _unitsPickerView];

    }
 
}

-(void)done:(id)sender
{
    NSLog(@"[%@ %@]",[self class],NSStringFromSelector(_cmd));
    if ([_locationValue isFirstResponder]) {
        [_locationValue resignFirstResponder];
    }
    
    [self.delegate dissmissViewContorller];
}
-(void)cancel:(id) sender{
    NSLog(@"[%@ %@]",[self class],NSStringFromSelector(_cmd));
    if ([_locationValue isFirstResponder]) {
        [_locationValue resignFirstResponder];
    }

    [self.delegate dissmissViewContorller];

}

#pragma mark-- UITextField Delegate.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}       // return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing:%@",textField.text);
    [_unitsPickerView removeFromSuperview];

}           // became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"textFieldShouldEndEditing");
    [textField resignFirstResponder];

    return YES;
}
// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return (_pickerViewData != nil)?[_pickerViewData count]:0;
}
#pragma mark - UIPickerViewDelegate

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
   
    NSDictionary *attributeDict = nil;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    
    attributeDict = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                      NSFontAttributeName:font,
                      NSParagraphStyleAttributeName:style};
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:[_pickerViewData objectAtIndex:row] attributes:attributeDict];
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"didSelectRow :%@",[_pickerViewData objectAtIndex:row]);
    if (_selectedData) {
       NSString *units  = [_pickerViewData objectAtIndex:row];
        [_temperatureUnitsValue setTitle:units forState:UIControlStateNormal];
        NSDictionary *attributeDict = nil;
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setAlignment:NSTextAlignmentLeft];
        
        attributeDict = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:style};
        
        [_temperatureUnitsValue setAttributedTitle:[[NSAttributedString alloc]initWithString:units attributes:attributeDict] forState:UIControlStateNormal];
        
        [_selectedData setObject:units forKey:UNITS];
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
