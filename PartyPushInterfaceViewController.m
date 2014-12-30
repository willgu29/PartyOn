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
#import "MapViewController.h"

//CLLocationManager will update locations only after this constant of meters has changed.
const int LOCATIONAL_UPDATE_AFTER_RANGE_OF_METERS = 3;

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
-(void)startMonitoring
{
    NSLog(@"Monitoring visit!");
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (delegate.locationManager == nil)
    {
        delegate.locationManager = [[CLLocationManager alloc] init];
    }
    if (_locationData == nil)
    {
        _locationData = [[LocationData alloc] init];

    }
    delegate.locationManager.delegate = _locationData;
    
    [self configureLocationManager];
    
//    [delegate.locationManager startMonitoringVisits]; //Visits Data is buggy
    
    
    [delegate.locationManager startUpdatingLocation];
}

//CHANGE Location Manager PROPERTIES here
-(void)configureLocationManager
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    //distance filter
    delegate.locationManager.pausesLocationUpdatesAutomatically = YES;
    delegate.locationManager.distanceFilter = LOCATIONAL_UPDATE_AFTER_RANGE_OF_METERS;
    delegate.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    
}

-(void)stopMonitoringVisits
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    [delegate.locationManager stopMonitoringVisits];
    
    [delegate.locationManager stopUpdatingLocation];
}

-(IBAction)activateDeactive:(UIButton *)sender
{
    if (isActivated)
    {
        isActivated = NO;
        //DEACTIVE PUSH and LOCATION TRACKING
        [self stopMonitoringVisits];
        [sender setTitle:@"Activate" forState:UIControlStateNormal];
    }
    else
    {
        isActivated = YES;
        //ACTIVATE PUSH and LOCATION TRACKING
        [self startMonitoring];
        [sender setTitle:@"Deactive" forState:UIControlStateNormal];

    }
}

-(IBAction)backButton:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)mapViewButton:(UIButton *)sender
{
    MapViewController *mapVC = [[MapViewController alloc] init];
    [self presentViewController:mapVC animated:YES completion:nil];
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
