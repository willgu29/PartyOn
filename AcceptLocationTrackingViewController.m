//
//  AcceptLocationTrackingViewController.m
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//
#import "SurveyViewController.h"
#import "AcceptLocationTrackingViewController.h"
#import "AppDelegate.h"
@interface AcceptLocationTrackingViewController ()

@end

@implementation AcceptLocationTrackingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)acceptLocation:(UIButton *)sender
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        delegate.locationManager = [[CLLocationManager alloc] init];
        delegate.locationManager.delegate = self;

        [delegate.locationManager requestAlwaysAuthorization];
    }
    else
    {
        SurveyViewController *surveyVC = [[SurveyViewController alloc] init];
        [self presentViewController:surveyVC animated:YES completion:nil];
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"Accepted!");
    SurveyViewController *surveyVC = [[SurveyViewController alloc] init];
    [self presentViewController:surveyVC animated:YES completion:nil];
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
