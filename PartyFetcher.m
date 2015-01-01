//
//  PartyFetcher.m
//  Party On
//
//  Created by William Gu on 12/29/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "PartyFetcher.h"

@interface PartyFetcher ()

@property (nonatomic, strong) NSMutableArray *fratsPartyingNow;

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
    }
    
    [delegate parseCompletionWithFratsPartying:_fratsPartyingNow];
}




@end
