//
//  PartyFetcher.m
//  Party On
//
//  Created by William Gu on 12/29/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "PartyFetcher.h"
#import <MapKit/MapKit.h>

@interface PartyFetcher ()

@property (nonatomic, strong) NSMutableArray *fratsPartyingNow;
@property (nonatomic, strong) NSMutableArray *fratLocationsPartying;
@property (nonatomic, strong) NSArray *arrayOfAllFratLocations;


@end

@implementation PartyFetcher

@synthesize delegate;

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initialSetup];
    }
    return self;
}

-(void)initialSetup
{
    _fratsPartyingNow = [[NSMutableArray alloc] init];
    _fratLocationsPartying = [[NSMutableArray alloc] init];
    [self getFratsFromWebsite];
}

-(void)getFratsFromWebsite
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://www.pleasetapthat.com/partyOn/data/partyData.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self parseJSONFratsPartying:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //Alert check internet connection
    }];
    
}

-(void)parseJSONFratsPartying:(id)responseObject
{
    for (id objects in responseObject)
    {
        NSLog(@"object: %@",objects);
        NSString *fratName = [objects valueForKey:@"fratName"];
        NSLog(@"Frat name: %@", fratName);
        [_fratsPartyingNow addObject:fratName];
        NSString *locationID = [objects valueForKey:@"locationID"];
        CLLocation *fratLocation = [_arrayOfAllFratLocations objectAtIndex:(locationID.intValue - 1)];
        [_fratLocationsPartying addObject:fratLocation];
    }
    
    [delegate parseCompletionWithFratsPartying:_fratsPartyingNow andLocations: _fratLocationsPartying];
}



#pragma mark - Temporary Hard code
//IN the future the server will also send over coordinate points.



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
    
    _arrayOfAllFratLocations = @[AEP, AGW, BQP, DSF, DTD, LCA, FDQ, FKS, PKA, PKF, SAE, SC, SN, SFE, SP, QC, QDC, QX, Triangle, ZBT];
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




@end
