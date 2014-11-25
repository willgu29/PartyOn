//
//  PartyPushInterfaceViewController.m
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "PartyPushInterfaceViewController.h"

@interface PartyPushInterfaceViewController ()
{
    BOOL isActivated;
}


@end

@implementation PartyPushInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)activateDeactive:(UIButton *)sender
{
    if (isActivated)
    {
        isActivated = NO;
        //DEACTIVE PUSH and LOCATION TRACKING
    }
    else
    {
        isActivated = YES;
        //ACTIVATE PUSH and LOCATION TRACKING
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
