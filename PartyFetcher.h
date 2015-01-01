//
//  PartyFetcher.h
//  Party On
//
//  Created by William Gu on 12/29/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@class PartyFetcher;
@protocol PartyFetcherDelegate

-(void)parseCompletionWithFratsPartying:(NSArray *)fratsPartying andLocations:(NSArray *)fratsPartyingLocations;

@end

@interface PartyFetcher : NSObject

@property (nonatomic, assign) id delegate;


@end
