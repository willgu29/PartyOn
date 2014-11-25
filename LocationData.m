//
//  LocationData.m
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "LocationData.h"

@implementation LocationData




#pragma mark -CLLocationManager

//An array of CLLocation Objects (CLLocation includes a coordinate and method called distanceFromLocation:(CLLocation)location. Returns CLLocationDistance (meters in double)
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
}

//CLVisit has coordinate
-(void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit
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
