//
//  CreateEventViewController.m
//  Party On
//
//  Created by William Gu on 11/11/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "CreateEventViewController.h"
#import "WhoCanViewController.h"
@interface CreateEventViewController ()

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)nextButton:(UIButton *)sender
{
    WhoCanViewController *whoVC = [[WhoCanViewController alloc] init];
    
    
    [self.navigationController pushViewController:whoVC animated:YES];
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
