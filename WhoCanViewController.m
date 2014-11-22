//
//  WhoCanViewController.m
//  Party On
//
//  Created by William Gu on 11/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "WhoCanViewController.h"

@interface WhoCanViewController ()
{
    NSArray *dataSourcePicker;
}

@end

@implementation WhoCanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createDataForPicker];
    
}

//TO CHANGE VALUES IN PICKER JUST MODIFY THE ARRAY BELOW
-(void)createDataForPicker
{
    dataSourcePicker = @[@"Only Girls", @"Only Guys", @"Everyone", @"Guest List", @"Guest List and Girls"];
}

-(void)saveData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneButton:(UIButton *)sender
{
    [self saveData];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}





-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataSourcePicker objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataSourcePicker count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
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
