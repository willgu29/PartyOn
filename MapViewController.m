//
//  MapViewController.m
//  Party On
//
//  Created by William Gu on 12/29/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "MapViewController.h"
#import "AFNetworking.h"


const NSInteger METERS_PER_MILE = 1609.344;

@interface MapViewController ()

@property (nonatomic, strong) PartyFetcher *partyFetcher;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

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
    
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(34.03, -118.27);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, METERS_PER_MILE, METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:NO];
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



#pragma mark - Map Kit Delegates

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    static NSString *identifier = @"PinAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!annotationView)
    {
        
        NSLog(@"making new MKPinAnnotationView");
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    else
    {
        //else reuse it
        annotationView.annotation  = annotation;
    }
    
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    //annotationView.draggable = YES;
    // annotationView.image = nil;
    
    return annotationView;
}


#pragma mark - PartyFetcher Delegate

-(void)parseCompletionWithFratsPartying:(NSArray *)fratsPartying andLocations:(NSArray *)fratsPartyingLocations

{
    //Create all pin datas for frats and add to map
    for (int i = 0; i < [fratsPartying count]; i++)
    {
        MKPointAnnotation *pinData = [[MKPointAnnotation alloc] init];
        CLLocation *locationData = [fratsPartyingLocations objectAtIndex:i];
        pinData.coordinate = locationData.coordinate;
        pinData.title = [fratsPartying objectAtIndex:i];
        [_mapView addAnnotation:pinData];
    }
    
}

-(void)noPartiesRightNow
{
    //Display some text or alert
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
