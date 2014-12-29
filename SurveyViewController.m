//
//  SurveyViewController.m
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "SurveyViewController.h"
#import "MainViewController.h"
#import <Parse/Parse.h>
@interface SurveyViewController ()

@property (nonatomic, weak) IBOutlet UIButton *girlButton;
@property (nonatomic, weak) IBOutlet UIButton *boyButton;
@property (nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _boyButton.hidden = YES;
    _girlButton.hidden = YES;
    _girlButton.enabled = NO;
    _boyButton.enabled = NO;
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
    [self presentViewController:navVC animated:YES completion:^{
        [self addDataToParse];
    }];
}

-(void)addDataToParse
{
    PFObject *visitPF = [PFObject objectWithClassName:@"FratStatus"];
    //GIRL = 1 | BOY = 2 | NOT SET = 0
    int genderType = [[NSUserDefaults standardUserDefaults] integerForKey:@"genderType"];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    
    visitPF[@"fratName"] = [NSString stringWithFormat:@"%d",-1];
    visitPF[@"gender"] = [NSString stringWithFormat:@"%d", genderType];
    visitPF[@"deviceToken"] = data;
    [visitPF saveInBackground];
}


#pragma mark - Textfield Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_textField.text isEqualToString:@""])
    {
        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"name"];
        _boyButton.hidden = NO;
        _girlButton.hidden = NO;
        _boyButton.enabled = YES;
        _girlButton.enabled = YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([_textField isFirstResponder] && [touch view] != _textField) {
        [_textField resignFirstResponder];
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
