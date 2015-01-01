//
//  MapViewController.m
//  Party On
//
//  Created by William Gu on 12/29/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "MapViewController.h"
#import "AFNetworking.h"

@interface MapViewController ()

@property (nonatomic, strong) PartyFetcher *partyFetcher;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    _partyFetcher = [[PartyFetcher alloc] init];
    _partyFetcher.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backButton:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Adding Pin to Map

-(void)addPin
{
//    MKPointAnnotation *pinData = [[MKPointAnnotation alloc] init];
    
//    MKPinAnnotationView *pinAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:<#(id<MKAnnotation>)#> reuseIdentifier:(NSString *)]
}

#pragma mark - Map Kit Delegates




#pragma mark - PartyFetcher Delegate

-(void)parseCompletionWithFratsPartying:(NSArray *)fratsPartying

{
    
}

#pragma mark - Support Buttons

-(IBAction)supportButton:(UIButton *)sender
{
    [self reportBug];
}

-(void)reportBug
{
    if ([MFMailComposeViewController canSendMail])
    {
        NSString *emailTitle = @"Suggestions,Comments,Praise";
        // Email Content
        NSString *messageBody = @"Hi my name is .... and .... ";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"info@gustudios.com"];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Mail is not configured on this account. Please email info@gustudios.com"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
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
