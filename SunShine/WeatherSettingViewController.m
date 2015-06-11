//
//  WeatherSettingViewController.m
//  SunShine
//
//  Created by udhaykanthd on 6/9/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "WeatherSettingViewController.h"
#import "WeatherShared.h"
#import <QuartzCore/QuartzCore.h>

@interface WeatherSettingViewController ()
{

    BOOL isDisableDoneButton;
}
@property(nonatomic,strong) UIView *containerView;
@property(nonatomic,strong) UILabel *location;
@property(nonatomic,strong) UITextField *locationValue;
@property(nonatomic,strong) UILabel *temperatureUnits;
@property(nonatomic,strong)  UITextField *temperatureUnitsValue;
@property(nonatomic,strong) UIPickerView *unitsPickerView;
@property(nonatomic,strong) NSArray *pickerViewData;
@property(nonatomic,strong) NSMutableDictionary *selectedData;


@end

@implementation WeatherSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isDisableDoneButton = YES;
    PRINT_CONSOLE_LOG;
    // Do any additional setup after loading the view.
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    [self.navigationItem setRightBarButtonItem:doneItem];
    [self.navigationItem setLeftBarButtonItem:cancelItem];
    _selectedData = [[NSMutableDictionary alloc]init];
    [self configureView];
}
-(void)viewWillDisappear:(BOOL)animated {
    PRINT_CONSOLE_LOG;
    [super viewWillDisappear:animated];
   // [self dismissKeyboard];
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
    //int mainViewY = self.view.bounds.origin.y;
    int labelHeight = 30;
    
    int containViewY = 150.0;
    
    //Container view
    _containerView = [[UIView alloc]initWithFrame:CGRectMake( mainViewX, containViewY, mainViewWidth, mainViewHeight-mainViewX-200)];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    
     _location = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, _containerView.bounds.origin.y+10, mainViewWidth/2, labelHeight)];
    // [_humidity setBackgroundColor:[UIColor blackColor]];
    [_location setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [_location setText:@"Location:"];
    [_location setTextAlignment:NSTextAlignmentRight];
    [_location setTextColor:[UIColor blackColor]];
    [_containerView addSubview: _location];
    
    //location value textfield
    _locationValue = [[UITextField alloc]initWithFrame:CGRectMake(mainViewWidth/2+10, _containerView.bounds.origin.y, mainViewWidth/2-15, 50)];
    [_locationValue setPlaceholder:@"Location value"];
    [_locationValue setDelegate:self];
    [_locationValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [_locationValue setTextAlignment:NSTextAlignmentLeft];
    [_locationValue setTextColor:[UIColor blackColor]];
    [_locationValue setTag:LOCATION_TEXTFIELD_TAG];
    [_locationValue becomeFirstResponder];
   
    [_containerView addSubview: _locationValue];
    
    int temperatureUnitY = _location.frame.origin.y+_location.frame.size.height+20;
    
    _temperatureUnits = [[UILabel alloc]initWithFrame:CGRectMake(_containerView.bounds.origin.x, temperatureUnitY, mainViewWidth/2, labelHeight)];
    [_temperatureUnits setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [_temperatureUnits setText:@"Temperature Units:"];
    [_temperatureUnits setTextAlignment:NSTextAlignmentRight];
    [_temperatureUnits setTextColor:[UIColor blackColor]];
    [_containerView addSubview: _temperatureUnits];
    
    
    
    _temperatureUnitsValue = [[UITextField alloc]initWithFrame:CGRectMake(mainViewWidth/2+10,temperatureUnitY, mainViewWidth/2-15, labelHeight)];
    [_temperatureUnitsValue setPlaceholder:@"None"];
    [_temperatureUnitsValue setDelegate:self];
    [_temperatureUnitsValue setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [_temperatureUnitsValue setTextAlignment:NSTextAlignmentLeft];
    [_temperatureUnitsValue setTextColor:[UIColor blackColor]];
    [_temperatureUnitsValue setTag:UNITS_TEXTFIELD_TAG];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPickerView:)];
    
    UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [toolBar setItems:[NSArray arrayWithObjects:spaceBar, doneBarButton,nil]];
    
    [_temperatureUnitsValue setInputAccessoryView:toolBar];
    
    if (_unitsPickerView == nil) {
        //CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        _unitsPickerView = [[UIPickerView alloc]init];
        [_unitsPickerView setDataSource:self];
        [_unitsPickerView setDelegate:self];
        //[_unitsPickerView setFrame:CGRectMake(0, screenWidth/2-40, screenWidth, (screenWidth/2)-20)];
        NSLog(@"pickerFrame:%@",NSStringFromCGRect(_unitsPickerView.frame));
        [_temperatureUnitsValue setInputView:_unitsPickerView];
        
    }
    [_containerView addSubview:_temperatureUnitsValue];
    
    _pickerViewData = [NSArray arrayWithObjects:@"None",@"Metric",@"Imperial", nil];

    [self.view addSubview:_containerView];
    
}

-(void)done:(id)sender
{
    PRINT_CONSOLE_LOG;
    [self dismissKeyboard];
    if ([_locationValue.text length] == 0 || [_temperatureUnitsValue.text length] == 0 || [_temperatureUnitsValue.text isEqualToString:@"None"]) {
        [self.delegate dissmissViewContorller:nil];
        return;
  
    }
    [_selectedData setObject:_locationValue.text forKey:LOCATION_NAME];
    [_selectedData setObject:_temperatureUnitsValue.text forKey:UNITS];
    
    [self.delegate dissmissViewContorller:_selectedData];
}
-(void)cancel:(id) sender{
    PRINT_CONSOLE_LOG;
    [self dismissKeyboard];

    [self.delegate dissmissViewContorller:nil];

}

#pragma mark-- UITextField Delegate.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing:%@",textField.text);
    [textField becomeFirstResponder];
    

}
// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"textFieldShouldEndEditing :%@,%@",[_locationValue class], [_temperatureUnitsValue class]);
    
        if(textField.tag == LOCATION_TEXTFIELD_TAG) {
            if ([textField.text length ]==0) {
                
            textField.layer.borderColor =  ([[UIColor redColor] CGColor]);
            textField.layer.borderWidth = 1.0;
                NSLog(@"cannot be empty");
                isDisableDoneButton = YES;
               // [self.navigationItem.rightBarButtonItem setEnabled:NO];

               // return NO;//weired

            }
            else {
                textField.layer.borderColor =  ([[UIColor whiteColor] CGColor]);
                textField.layer.borderWidth = 1.0;
                [textField resignFirstResponder];
                isDisableDoneButton = NO;
                //[self.navigationItem.rightBarButtonItem setEnabled:YES];


            }
        }
        else if (textField.tag == UNITS_TEXTFIELD_TAG) {
             if ([textField.text length ]== 0 || [_temperatureUnitsValue.text isEqualToString:@"None"]) {
            textField.layer.borderColor =  ([[UIColor redColor] CGColor]);
            textField.layer.borderWidth = 1.0;
                 NSLog(@"cannot be empty");
                 isDisableDoneButton = YES;
                 //[self.navigationItem.rightBarButtonItem setEnabled:NO];


                // return NO;

             }
             else {
                 textField.layer.borderColor =  ([[UIColor whiteColor] CGColor]);
                 textField.layer.borderWidth = 1.0;
                 [textField resignFirstResponder];
                 isDisableDoneButton = NO;
                 //[self.navigationItem.rightBarButtonItem setEnabled:YES];


             
             }
        }
    [self.navigationItem.rightBarButtonItem setEnabled:!isDisableDoneButton];
 
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
         NSDictionary *attributeDict = nil;
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setAlignment:NSTextAlignmentLeft];
        
        attributeDict = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:style};
        
         [_temperatureUnitsValue setAttributedText:[[NSAttributedString alloc]initWithString:units attributes:attributeDict]];
        
        [_selectedData setObject:units forKey:UNITS];
    }
}
-(void)dismissPickerView:(id)sender {

    if ([_temperatureUnitsValue isFirstResponder]) {
        [_temperatureUnitsValue resignFirstResponder];
   
    }

}
-(void)dismissKeyboard {
    if ([_temperatureUnitsValue isFirstResponder]) {
        [_temperatureUnitsValue resignFirstResponder];
    }
    if ([_locationValue isFirstResponder]) {
        [_locationValue resignFirstResponder];
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
