//
//  PartyFetcher.m
//  Party On
//
//  Created by William Gu on 12/29/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "PartyFetcher.h"

@implementation PartyFetcher

-(void)GET
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://100.110.224.170:3000" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self PARSE:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


-(void)PARSE:(id)responseObject
{
    //Get Frat Name
    //If frat name matches one of existing combinination of letters, place a pin at that frat location
    //
}


@end
