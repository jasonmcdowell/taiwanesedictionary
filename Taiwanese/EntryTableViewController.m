//
//  EntryTableViewController.m
//  Table View Practice
//
//  Created by Jason McDowell on 3/10/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "EntryTableViewController.h"
#import "Definition.h"
#import "DefinitionTableViewCell.h"

@interface EntryTableViewController ()

@end

@implementation EntryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    UINib *nib = [UINib nibWithNibName:@"DefinitionTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"Definition"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.entry.definitions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DefinitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Definition" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Definition *definition = self.entry.definitions[indexPath.row];
    cell.taiwaneseLabel.text = [NSString stringWithFormat:@"%@. %@",@(indexPath.row + 1),definition.taiwanese];
    cell.chineseLabel.text = definition.chinese;
    cell.englishLabel.text = definition.english;
    if ([definition.examples count]) {
        for (Example *example in definition.examples) {
            cell.examplesLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@\n\n",example.taiwanese, example.chinese, example.english ];
        }
    } else {
        cell.examplesLabel.text = nil;

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Definition *definition = self.entry.definitions[indexPath.row];
    
    if ([definition.examples count]) {
        return 200;
    } else {
        return 100;
    }
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
