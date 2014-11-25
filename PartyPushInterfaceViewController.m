//
//  PartyPushInterfaceViewController.m
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "PartyPushInterfaceViewController.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "LocationData.h"
@interface PartyPushInterfaceViewController ()
{
    BOOL isActivated;
}

@property (nonatomic, strong) LocationData *locationData;


@end

@implementation PartyPushInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Will automatically send CLLocationManagerDelegate CLVisits (determined by substantial amount of time spent at a location
-(void)startMonitoringVisits
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.locationManager.delegate = _locationData;
    [delegate.locationManager startMonitoringVisits];
}

-(void)stopMonitoringVisits
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.locationManager stopMonitoringVisits];
}

-(IBAction)activateDeactive:(UIButton *)sender
{
    if (isActivated)
    {
        isActivated = NO;
        //DEACTIVE PUSH and LOCATION TRACKING
        [self stopMonitoringVisits];
    }
    else
    {
        isActivated = YES;
        //ACTIVATE PUSH and LOCATION TRACKING
        [self startMonitoringVisits];
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
