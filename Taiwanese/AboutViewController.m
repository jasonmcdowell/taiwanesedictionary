//
//  AboutViewController.m
//  Taiwanese
//
//  Created by Jason McDowell on 5/3/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"fred"])
    {
        AboutViewController *controller = [segue destinationViewController];
        controller.hidesBottomBarWhenPushed = YES;
    }
}

- (IBAction)sendEmail:(id)sender
{
    NSString *emailAddress = @"taiwanese.app@gmail.com";
    NSString *subject = @"Taiwanese Dictionary 1.1";
    NSString *body = @"Bug Report / Feature Request";
    
	NSString *mailString = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
							[emailAddress stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
							[subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
							[body  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	   
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:mailString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
    } else {
        NSLog(@"Cannot open Mail URL");
    }
}


- (IBAction)website:(id)sender
{
    NSString *website = @"http://taiwanese.nfshost.com";
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:website]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
    } else {
        NSLog(@"Cannot open Website");
    }
}

@end
