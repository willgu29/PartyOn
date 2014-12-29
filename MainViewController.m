//
//  MainViewController.m
//  Party On
//
//  Created by William Gu on 11/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "MainViewController.h"
#import "CreateEventViewController.h"
#import "PartyPushInterfaceViewController.h"
#import "CounterInterfaceViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)createEvent:(UIButton *)sender
{
    
    
    CreateEventViewController *createVC = [[CreateEventViewController alloc] init];

    [self.navigationController pushViewController:createVC animated:YES];
}

-(IBAction)trynaParty:(UIButton *)sender
{
    PartyPushInterfaceViewController *partyVC = [[PartyPushInterfaceViewController alloc] init];
    [self presentViewController:partyVC animated:YES completion:nil];
}

-(IBAction)trynaHost:(UIButton *)sender
{
    CounterInterfaceViewController *counterVC = [[CounterInterfaceViewController alloc] init];
    [self presentViewController:counterVC animated:YES completion:nil];
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
