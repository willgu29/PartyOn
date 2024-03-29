//
//  LocationData.m
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "LocationData.h"
#import "NSDataConvert.h"
#import <Parse/Parse.h>
#import "FratEnums.h"
@interface LocationData()

@property (nonatomic, strong) NSArray *arrayOfFratLocations;
@property (nonatomic) int fratStatus;

@end

const int MINIMUM_METERS_AWAY = 10;

@implementation LocationData

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initFratLocations];
        [self saveFratStatusWithStatus:NONE];
    }
    return self;
}


//CHANGE THIS TO ADD ADDITIONAL TEST LOCATIONS WHEN PARTYING*********
-(void)initFratLocations
{
    //*** Checked and Accurate ***
    CLLocation *AEP = [self locationOfFratWithDegrees:34 minutes:03 seconds:58.21 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:55.62];
    CLLocation *AGW = [self locationOfFratWithDegrees:34 minutes:04 seconds:04.98 andDegreesLong:-118 andMinutesLong:27 andSecondsLong:03.04];
    CLLocation *BQP = [self locationOfFratWithDegrees:34 minutes:04 seconds:06.70 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:57.21];
    CLLocation *DSF = [self locationOfFratWithDegrees:34 minutes:04 seconds:01.01 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:56.09];
    CLLocation *DTD = [self locationOfFratWithDegrees:34 minutes:04 seconds:00.01 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:52.02];
    CLLocation *LCA = [self locationOfFratWithDegrees:34 minutes:04 seconds:04.40 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:56.79];
    CLLocation *FDQ = [self locationOfFratWithDegrees:34 minutes:04 seconds:07.63 andDegreesLong:-118 andMinutesLong:27 andSecondsLong:04.34];
    CLLocation *FKS = [self locationOfFratWithDegrees:34 minutes:04 seconds:02.07 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:58.02];
    CLLocation *PKA = [self locationOfFratWithDegrees:34 minutes:04 seconds:08.41 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:59.06];
    CLLocation *PKF = [self locationOfFratWithDegrees:34 minutes:04 seconds:00.64 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:55.37];
    CLLocation *SAE = [self locationOfFratWithDegrees:34 minutes:03 seconds:59.80 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:52.07];
    CLLocation *SC = [self locationOfFratWithDegrees:34 minutes:04 seconds:13.83 andDegreesLong:-118 andMinutesLong:27 andSecondsLong:08.69];
    CLLocation *SN = [self locationOfFratWithDegrees:34 minutes:04 seconds:05.75 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:55.71];
    CLLocation *SFE = [self locationOfFratWithDegrees:34 minutes:04 seconds:04.60 andDegreesLong:-118 andMinutesLong:27 andSecondsLong:00.67];
    CLLocation *SP = [self locationOfFratWithDegrees:34 minutes:04 seconds:02.11 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:56.35];
    CLLocation *QC = [self locationOfFratWithDegrees:34 minutes:03 seconds:59.21 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:51.74];
    CLLocation *QDC = [self locationOfFratWithDegrees:34 minutes:04 seconds:08.67 andDegreesLong:-118 andMinutesLong:27 andSecondsLong:01.34];
    CLLocation *QX = [self locationOfFratWithDegrees:34 minutes:04 seconds:02.95 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:54.79];
    CLLocation *Triangle = [self locationOfFratWithDegrees:34 minutes:04 seconds:04.42 andDegreesLong:-118 andMinutesLong:27 andSecondsLong:01.97];
    //???: treehouse or actual ZBT? <--- TREEHOUSE
    CLLocation *ZBT = [self locationOfFratWithDegrees:34 minutes:04 seconds:03.77 andDegreesLong:-118 andMinutesLong:26 andSecondsLong:56.27];
    
    _arrayOfFratLocations = @[AEP, AGW, BQP, DSF, DTD, LCA, FDQ, FKS, PKA, PKF, SAE, SC, SN, SFE, SP, QC, QDC, QX, Triangle, ZBT];
}

//CLLocationDegrees is type double
-(CLLocation *)locationOfFratWithDegrees:(double)degreesLat minutes:(double)minutesLat seconds:(double)secondsLat andDegreesLong:(double)degreesLong andMinutesLong:(double)minutesLong andSecondsLong:(double)secondsLong
{
    
    CLLocationDegrees latitude = [self decimalDegreesForDegress:degreesLat minutes:minutesLat seconds:secondsLat];
    CLLocationDegrees longitude = [self decimalDegreesForDegress:degreesLong minutes:minutesLong seconds:secondsLong];
    
    return [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
}


-(CLLocationDegrees)decimalDegreesForDegress:(double)degrees minutes:(double)minutes seconds:(double)seconds
{
    int latsign=1;
    
    if (degrees<0){
        latsign = -1;
    }
    else{
        latsign=1;
    }
    double dd = (degrees + (latsign* (minutes/60.)) + (latsign* (seconds/3600.) ) ) ;
    return dd;
}


#pragma mark -CLLocationManager

//An array of CLLocation Objects (CLLocation includes a coordinate and method called distanceFromLocation:(CLLocation)location. Returns CLLocationDistance (meters in double)
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Location updated");
    CLLocation *currentLocation = [locations lastObject];
    [self saveLastLocationData:currentLocation];
    [self checkCurrentLocation:currentLocation];
    
}

-(void)saveLastLocationData:(CLLocation *)visit
{
    PFObject *visitPF = [PFObject objectWithClassName:@"LocationData"];
    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:visit.coordinate.latitude longitude:visit.coordinate.longitude];
    visitPF[@"coordinate"] = point;
    visitPF[@"time"] = visit.timestamp;
    visitPF[@"verticalAccuracy"] = [NSString stringWithFormat:@"%f",visit.verticalAccuracy];
    visitPF[@"accuracy"] = [NSString stringWithFormat:@"%f",visit.horizontalAccuracy];
    visitPF[@"name"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    visitPF[@"speed"] = [NSString stringWithFormat:@"%f",visit.speed];
    visitPF[@"course"] = [NSString stringWithFormat:@"%f", visit.course];
    [visitPF saveInBackground];
}


-(void)saveLastFratLocationData:(CLLocation *)visit andFratNumber:(int)number
{
    PFObject *visitPF = [PFObject objectWithClassName:@"LocationData"];
    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:visit.coordinate.latitude longitude:visit.coordinate.longitude];
    visitPF[@"FratNumber"] = [NSString stringWithFormat:@"%d",number];
    visitPF[@"coordinate"] = point;
    visitPF[@"time"] = visit.timestamp;
    visitPF[@"verticalAccuracy"] = [NSString stringWithFormat:@"%f",visit.verticalAccuracy];
    visitPF[@"accuracy"] = [NSString stringWithFormat:@"%f",visit.horizontalAccuracy];
    visitPF[@"name"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    visitPF[@"speed"] = [NSString stringWithFormat:@"%f",visit.speed];
    visitPF[@"course"] = [NSString stringWithFormat:@"%f", visit.course];
    [visitPF saveInBackground];
}

-(void)checkCurrentLocation:(CLLocation *)visit
{
    
    CLLocation *visitedLocation = [[CLLocation alloc] initWithLatitude:visit.coordinate.latitude longitude:visit.coordinate.longitude];
    
    int fratNum = 0;
    
    for (CLLocation *fratLocation in _arrayOfFratLocations)
    {
        CLLocationDistance distance = [visitedLocation distanceFromLocation:fratLocation];
        if (distance < MINIMUM_METERS_AWAY)
        {
            //If person is within 10meters of the CENTER of the frat.. we'll consider them to be at that party
            [self saveLastFratLocationData:visit andFratNumber:fratNum];
            _fratStatus = fratNum;
            //TODO: ping server this data...
            [self saveFratStatusWithStatus:_fratStatus];
            return;
        }
        fratNum++;
    }
    
    //IF method has reached this point, it means this location is not at any registered frat.
    _fratStatus = NONE;
    [self saveFratStatusWithStatus:_fratStatus];
    //then ping server this data
    
}

//When reaching this point, an object FratStatus w/ device token will have already been made. Therefore, just update the object
-(void)saveFratStatusWithStatus:(int)status
{
    PFQuery *query = [PFQuery queryWithClassName:@"FratStatus"];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    NSString *hexString = [data hexadecimalString];
    [query whereKey:@"deviceToken" equalTo:hexString];
    PFObject *visitPF = [query getFirstObject];
    visitPF[@"fratName"] = [NSString stringWithFormat:@"%d",status];
    [visitPF saveInBackground];

    
    //No longer need to add these datas, already added on initial setup.
//    int genderType = [[NSUserDefaults standardUserDefaults] integerForKey:@"genderType"];
//    
//    visitPF[@"fratName"] = [NSString stringWithFormat:@"%d",_fratStatus];
//    visitPF[@"gender"] = [NSString stringWithFormat:@"%d", genderType];
//    visitPF[@"deviceToken"] = data;
    

}

-(void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager
{
    NSLog(@"Resumed Updates");
}

-(void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    NSLog(@"Paused Updates");
}


-(void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error
{
    //The location manager object calls this method to let you know that it has stopped deferring the delivery of location events. The manager may call this method for any number of reasons. For example, it calls it when you stop location updates altogether, when you ask the location manager to disallow deferred updates, or when a condition for deferring updates (such as exceeding a timeout or distance parameter) is met.
    
    [self saveFratStatusWithStatus:DEACTIVATED];
}

//CLRegion is a defined area to monitor we give to CLLocationManager
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    
}

//***************************************************************
#pragma mark - DEPRECATED CLVISIT INACCURACY
//NOT USING CLVisit Anymore due to inaccuracy of tracking
//-(void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit
//{
//    NSLog(@"New Visit!");
//    [self saveVisitData:visit];
//
//    if ([visit.departureDate isEqualToDate:[NSDate distantFuture]]){
//        // User has arrived, but not left, the location
//
//    } else {
//        // The visit is complete
//        [self checkPlaceLeft:visit];
//    }
//}

-(void)saveVisitData:(CLVisit *)visit
{
    PFObject *visitPF = [PFObject objectWithClassName:@"VisitData"];
    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:visit.coordinate.latitude longitude:visit.coordinate.longitude];
    visitPF[@"Coordinate"] = point;
    visitPF[@"arrival"] = visit.arrivalDate;
    visitPF[@"departure"] = visit.departureDate;
    visitPF[@"accuracy"] = [NSString stringWithFormat:@"%f",visit.horizontalAccuracy];
    visitPF[@"name"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    [visitPF saveInBackground];
}

//FOR TESTING PURPOSES, what does the 10meter radius get/consider a visit?
-(void)saveFratVisitData:(CLVisit *)visit andFratNumber:(int)number
{
    PFObject *visitPF = [PFObject objectWithClassName:@"SpecificVisit"];
    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:visit.coordinate.latitude longitude:visit.coordinate.longitude];
    visitPF[@"Coordinate"] = point;
    visitPF[@"arrival"] = visit.arrivalDate;
    visitPF[@"departure"] = visit.departureDate;
    visitPF[@"accuracy"] = [NSString stringWithFormat:@"%f",visit.horizontalAccuracy];
    visitPF[@"FratNumber"] = [NSString stringWithFormat:@"%d",number];
    visitPF[@"name"] = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    [visitPF saveInBackground];
}

-(void)checkPlaceLeft:(CLVisit *)visit
{
    NSLog(@"Checking place left");
    CLLocation *visitedLocation = [[CLLocation alloc] initWithLatitude:visit.coordinate.latitude longitude:visit.coordinate.longitude];
    
    int fratNum = 0;
    
    for (CLLocation *fratLocation in _arrayOfFratLocations)
    {
        CLLocationDistance distance = [visitedLocation distanceFromLocation:fratLocation];
        if (distance < MINIMUM_METERS_AWAY)
        {
            //If person is within 10meters of the CENTER of the frat.. we'll consider them to be at that party
            [self saveFratVisitData:visit andFratNumber:fratNum];
            //Decrement that frat's counter
            
            return;
        }
        fratNum++;
    }
    
}


@end
