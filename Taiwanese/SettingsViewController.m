//
//  SettingsViewController.m
//  Taiwanese
//
//  Created by Jason McDowell on 5/20/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "SettingsViewController.h"
#import "NSString+Taiwanese.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortOrder;
@property (weak, nonatomic) IBOutlet UISegmentedControl *taiwaneseOrthography;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maximumRecentEntries;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // load settings
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initializetaiwaneseOrthographyControl];
    [self initializeSortOrderControl];
    [self initializeMaximumRecentEntries];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)taiwaneseOrthography:(UISegmentedControl *)sender
{
    // if the control changes, save the new setting
    NSInteger selectedSegmentIndex = sender.selectedSegmentIndex;
    NSString *orthography = PEHOEJI;
    
    if (selectedSegmentIndex == 0) {
        orthography = PEHOEJI;
    } else if (selectedSegmentIndex == 1) {
        orthography = TAILO;
    } else if (selectedSegmentIndex == 2) {
        orthography = DT;
    } else if (selectedSegmentIndex == 3) {
        orthography = EXTENDED_BOPOMOFO;
    } else if (selectedSegmentIndex == 4) {
        orthography = IPA;
    } else {
        orthography = PEHOEJI;
        NSLog(@"Unknown orthography selected. Defaulting to Peh-oe-ji");
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:orthography forKey:@"orthography"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //NSLog(@"Saving orthography: %@", orthography);
    
}

- (void) initializetaiwaneseOrthographyControl
{
    NSInteger selectedSegmentIndex = 0;
    NSString *orthography = [[NSUserDefaults standardUserDefaults] objectForKey:@"orthography"];
    //NSLog(@"Loading orthography: %@", orthography);
    
    if ([orthography isEqualToString:PEHOEJI]) {
        selectedSegmentIndex = 0;
    } else if ([orthography isEqualToString:TAILO]) {
        selectedSegmentIndex = 1;
    } else if ([orthography isEqualToString:DT]) {
        selectedSegmentIndex = 2;
    } else if ([orthography isEqualToString:EXTENDED_BOPOMOFO]) {
        selectedSegmentIndex = 3;
    } else if ([orthography isEqualToString:IPA]) {
        selectedSegmentIndex = 4;
    } else {
        selectedSegmentIndex = 0;
        NSLog(@"Unknown orthography selected. Defaulting to Peh-oe-ji");
    }
    
    self.taiwaneseOrthography.selectedSegmentIndex = selectedSegmentIndex;
}

- (IBAction)sortOrder:(UISegmentedControl *)sender
{
    // if the control changes, save the new setting
    NSInteger selectedSegmentIndex = sender.selectedSegmentIndex;
    NSString *sortOrderField = @"";
    
    if (selectedSegmentIndex == 0) {
        sortOrderField = @"taiwanese";
    } else if (selectedSegmentIndex == 1) {
        sortOrderField = @"chinese";
    } else if (selectedSegmentIndex == 2) {
        sortOrderField = @"english";
    } else {
        sortOrderField = @"taiwanese";
        NSLog(@"Unknown sortOrderField selected. Defaulting to Taiwanese");
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:sortOrderField forKey:@"sortOrder"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //NSLog(@"Saving sort order: %@", sortOrderField);
}

- (void) initializeSortOrderControl
{
    NSInteger selectedSegmentIndex = 0;
    NSString *sortOrderField = [[NSUserDefaults standardUserDefaults] objectForKey:@"sortOrder"];
    //NSLog(@"Loading sort order: %@", sortOrderField);
    
    if ([sortOrderField isEqualToString:@"taiwanese"]) {
        selectedSegmentIndex = 0;
    } else if ([sortOrderField isEqualToString:@"chinese"]) {
        selectedSegmentIndex = 1;
    } else if ([sortOrderField isEqualToString:@"english"]) {
        selectedSegmentIndex = 2;
    } else {
        selectedSegmentIndex = 0;
        NSLog(@"Unknown orthography selected. Defaulting to Taiwanese");
    }
    
    self.sortOrder.selectedSegmentIndex = selectedSegmentIndex;
}

- (IBAction)maximumRecentEntries:(UISegmentedControl *)sender {
    
    // if the control changes, save the new setting
    NSString *title = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    
    NSNumber *maximumRecentEntries = @([title intValue]);
    
    [[NSUserDefaults standardUserDefaults] setObject:maximumRecentEntries forKey:@"maximumRecentEntries"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void) initializeMaximumRecentEntries
{
    NSInteger selectedSegmentIndex = 0;
    NSNumber *maximumRecentEntries = [[NSUserDefaults standardUserDefaults] objectForKey:@"maximumRecentEntries"];
    
    for (int i = 0; i < self.maximumRecentEntries.numberOfSegments ; i++) {
        NSNumber *max = @([[self.maximumRecentEntries titleForSegmentAtIndex:i] intValue]);
        if ([maximumRecentEntries isEqualToNumber:max]) {
            selectedSegmentIndex = i;
            break;
        }
    }
    
    self.maximumRecentEntries.selectedSegmentIndex = selectedSegmentIndex;
}


@end
