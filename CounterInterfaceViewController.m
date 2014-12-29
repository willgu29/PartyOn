//
//  CounterInterfaceViewController.m
//  Party On
//
//  Created by William Gu on 11/24/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#import "CounterInterfaceViewController.h"
#import "FetchData.h"

@interface CounterInterfaceViewController ()
{
    NSArray *dataSourcePicker;
    NSTimer *queryTimer;
}

@property (nonatomic) int fratLocationChosen;
@property (nonatomic, strong) FetchData *dataFetcher;

//UILabels
@property (nonatomic, weak) IBOutlet UILabel *numberOfGirls;
@property (nonatomic, weak) IBOutlet UILabel *numberOfGuys;
@property (nonatomic, weak) IBOutlet UILabel *totalNumberOfPeople;


@end

@implementation CounterInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createDataForPicker];
    [self setupFetchData];
}

-(void)setupFetchData
{
    _dataFetcher = [[FetchData alloc] init];
    _dataFetcher.delegate = self;
}
//TO CHANGE VALUES IN PICKER JUST MODIFY THE ARRAY BELOW
-(void)createDataForPicker
{
    dataSourcePicker = @[@"NONE",
                         @"AEP",
                         @"AGW",
                         @"BQP",
                         @"DSF",
                         @"DTD",
                         @"LCA",
                         @"FDQ",
                         @"FKS",
                         @"PKA",
                         @"PKF",
                         @"SAE",
                         @"SC",
                         @"SN",
                         @"SFE",
                         @"SP",
                         @"QC",
                         @"QDC",
                         @"QX",
                         @"Triangle",
                         @"ZBT"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction 

-(IBAction)startCounterButton:(UIButton *)sender
{
    [self startCounter];
}

-(IBAction)backButton:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


-(void)startCounter
{
    if (_fratLocationChosen > 0)
    {
        //Continue
        [self setupTimer];
    }
    else
    {
        //display error... choose a location
    }
}

-(void)setupTimer
{
    [queryTimer invalidate];
    queryTimer = nil;
    if (queryTimer == nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            queryTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:_dataFetcher selector:@selector(queryForPartyGoersAtFrat) userInfo:nil repeats:YES];
            
        });
    }
}

-(void)resetLabels
{
    _numberOfGirls.text = @"0";
    _numberOfGuys.text = @"0";
    _totalNumberOfPeople.text = @"0";
}

//Called automatically by FetchData object
-(void)parseCompletionWithDataGuys:(int)numberOfGuys girls:(int)numberOfGirls andTotal:(int)numberOfPeople
{
    _numberOfGirls.text = [NSString stringWithFormat:@"%d",numberOfGirls];
    _numberOfGuys.text = [NSString stringWithFormat:@"%d",numberOfGuys];
    _totalNumberOfPeople.text = [NSString stringWithFormat:@"%d",numberOfPeople];

}

#pragma mark - UIPicker Delegate


//If user changes picker, reset and make them start over by clicking start counter again.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [queryTimer invalidate];
    [self resetLabels];
    
    NSLog(@"Row: %d Name: %@", row, [dataSourcePicker objectAtIndex:row]);
    _fratLocationChosen = row;
    [_dataFetcher setFratNumber:row];
    
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataSourcePicker objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataSourcePicker count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
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
