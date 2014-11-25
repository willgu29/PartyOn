//
//  LoginViewController.m
//  Party On
//
//  Created by William Gu on 11/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import <Parse/Parse.h>
#import "AcceptLocationTrackingViewController.h"
#import "AppDelegate.h"
#import "SurveyViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginButton:(UIButton *)sender
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.locationManager = [[CLLocationManager alloc] init];
    if ([delegate.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        AcceptLocationTrackingViewController *acceptVC = [[AcceptLocationTrackingViewController alloc] init];
        [self presentViewController:acceptVC animated:YES completion:nil];
    }
    else
    {
        SurveyViewController *surveyVC = [[SurveyViewController alloc] init];
        [self presentViewController:surveyVC animated:YES completion:nil];
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
