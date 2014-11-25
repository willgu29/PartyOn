//
//  LocationData.h
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationData : NSObject <CLLocationManagerDelegate>

-(CLLocationCoordinate2D)getCurrentLocation;
-(instancetype)init;

@end
