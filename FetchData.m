//
//  FetchData.m
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "FetchData.h"
#import <Parse/Parse.h>
#import "FratEnums.h"
#import "GenderEnums.h"

@interface FetchData()

@property (nonatomic, strong) NSArray *partyGoers;
@property (nonatomic) int fratNumber;
@property (nonatomic) int numberOfGuys;
@property (nonatomic) int numberOfGirls;
@property (nonatomic) int totalNumberOfPeopleAtParty;

@end

@implementation FetchData

@synthesize delegate;

-(instancetype)init
{
    self  = [super init];
    if (self)
    {
        [self setInitialValues];
        _fratNumber = 0;

    }
    return self;
}

-(void)setFratNumber:(int)fratNumber
{
    _fratNumber = fratNumber;
}

-(void)setInitialValues
{
    _numberOfGirls = 0;
    _numberOfGuys = 0;
    _totalNumberOfPeopleAtParty = 0;
}


//All fratName numbers 0 or above means they are trying to party or currently at a party (-1 is deactivated)

//This method assumes parsing of people ONLY at this fratNumber location.
//Every query must be done ANEW, thus reset values to defaults everytime and reparse the whole list of people at that party
-(void)queryForPartyGoersAtFrat //Uses _fratNumber to parse which is SET in counterinterface pickerui.
{
    [self setInitialValues];
    
    PFQuery *query = [PFQuery queryWithClassName:@"FratStatus"];

    [query whereKey:@"fratName" equalTo:[NSString stringWithFormat:@"%d", _fratNumber]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            // The find succeeded.
            _totalNumberOfPeopleAtParty = objects.count;
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            _partyGoers = objects;
            
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                if ((int)object[@"genderType"] == GIRL)
                {
                    _numberOfGirls++;
                }
                else if ((int)object[@"genderType"] == BOY)
                {
                    _numberOfGuys++;
                }
            }
            [self parseCompletion];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

//Called automatically after parse query finishes incrementing guys and girls
-(void)parseCompletion
{
    [delegate parseCompletionWithDataGuys:_numberOfGuys girls:_numberOfGirls andTotal:_totalNumberOfPeopleAtParty];
}




@end
