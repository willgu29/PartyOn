//
//  LocationData.m
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "LocationData.h"

@interface LocationData()

@property (nonatomic, strong) NSArray *arrayOfFratLocations;

@end

const int MINIMUM_METERS_AWAY = 10;

@implementation LocationData


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initFratLocations];
    }
    return self;
}

-(void)initFratLocations
{
    CLLocation *testCoord = [[CLLocation alloc] initWithLatitude:19 longitude:19];
    CLLocation *myRoom = [[CLLocation alloc] initWithLatitude:100 longitude:201];
    CLLocation *piKapp = [[CLLocation alloc] initWithLatitude:100 longitude:201];
    
    _arrayOfFratLocations = @[testCoord, myRoom, piKapp];
}

#pragma mark -CLLocationManager

//An array of CLLocation Objects (CLLocation includes a coordinate and method called distanceFromLocation:(CLLocation)location. Returns CLLocationDistance (meters in double)
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
}

//CLVisit has coordinate
-(void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit
{
    if ([visit.departureDate isEqualToDate:[NSDate distantFuture]]){
        // User has arrived, but not left, the location
        
    } else {
        // The visit is complete
        [self checkPlaceLeft:visit];
    }
}

-(void)checkPlaceLeft:(CLVisit *)visit
{
    CLLocation *visitedLocation = [[CLLocation alloc] initWithLatitude:visit.coordinate.latitude longitude:visit.coordinate.longitude];
    
    for (CLLocation *fratLocation in _arrayOfFratLocations)
    {
        CLLocationDistance distance = [visitedLocation distanceFromLocation:fratLocation];
        if (distance < MINIMUM_METERS_AWAY)
        {
            //If person is within 10meters of the CENTER of the frat.. we'll consider them to be at that party
            
            //Decrement that frat's counter
            
            return;
        }
    }
    
    
}


-(void)pushDataToParse
{
    
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



@end
