//
//  FetchData.h
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@class FetchData;
@protocol FetchDataDelegate

-(void)parseCompletionWithDataGuys:(int)numberOfGuys girls:(int)numberOfGirls andTotal:(int)numberOfPeople;

@end

@interface FetchData : NSObject

@property (nonatomic, assign) id delegate;

-(instancetype)init;
-(void)setFratNumber:(int)fratNumber;

@end
