//
//  SurveyViewController.m
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "SurveyViewController.h"
#import "MainViewController.h"
@interface SurveyViewController ()

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)guyButton:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"genderType"];
    [self segueToMainVC];
}

-(IBAction)girlButton:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"genderType"];
    [self segueToMainVC];

}

-(void)segueToMainVC
{
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    [self presentViewController:navVC animated:YES completion:nil];
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
