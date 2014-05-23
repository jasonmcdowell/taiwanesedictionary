//
//  ListTableTableViewController.m
//  Taiwanese
//
//  Created by Jason McDowell on 5/4/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "ListTableViewController.h"
#import "Entry.h"
#import "Definition.h"
#import "Example.h"
#import "EntryTableViewController.h"
#import "NSString+Taiwanese.h"
#import "StartingViewController.h"

@interface ListTableViewController ()
@property (nonatomic, strong) NSMutableArray *tableData;
@end

@implementation ListTableViewController

@synthesize tableData = _tableData;

// lazy instantiation
- (NSMutableArray *) tableData {
    // This list is loaded from file everytime tableData is accessed. This is very inefficient.
    // An alternate method would be to keep the tableData property updated when you update the plist.
    // The problem is that we are updating the plist from other places in the code - we don't have access to the tableData property.
    // I think the inefficiency is fine for reasonably short lists (such as favorites and recents.
    
    // Get existing favorites
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [self.listTitle stringByAppendingString:@".plist"];
    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // if array is nil, create an empty array
    if (!array) {
        array = @[];
    }
    _tableData = [array mutableCopy];
    
    //NSLog(@"Successfully read %@. %d items total.", fileName, [_tableData count]);

    return _tableData;
}

- (void)setTableData:(NSMutableArray *)tableData
{
    _tableData = tableData;
    
    // Prepare empty file to write to plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [self.listTitle stringByAppendingString:@".plist"];
    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_tableData];
    
    // Write to plist
    BOOL result = [data writeToFile:filePath atomically:YES];
    if (result) {
        //NSLog(@"Successfully wrote %@. %d items total.", fileName, [_tableData count]);
    } else {
        NSLog(@"Error writing %@", fileName);
    }
    
}


- (void)clearList:(UIBarButtonItem *)sender
{
    // clear list
    self.tableData = [@[] mutableCopy];
    
    // reload tableview
    [self.tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    //NSLog(@"Currently have %d items in %@", [self.tableData count], self.listTitle);

}

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
    
    //[self loadData];
    
    // Add BarButtonItem for clearing a list
    UIBarButtonItem *addFavorite = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Clear"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(clearList:)];
    
    self.navigationItem.rightBarButtonItem = addFavorite;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    Entry *entry;
    if ([self.tableData count] > indexPath.row) {
        entry = [self.tableData objectAtIndex:indexPath.row];
    }
    
    self.tableData[indexPath.row] = entry;
    
    
    
    Definition *definition = [entry.definitions firstObject];
    
    NSString *string = [definition.taiwanese convertToTaiwaneseOrthography];
    
    string = [NSString stringWithFormat:@"\U0001d11e \u31AA \U000031AA \u2b51 \u2605 "];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:20]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:NSLocalizedString(string, nil) attributes:attributes];
    cell.textLabel.attributedText = attributedString;
    
    //cell.textLabel.text = [definition.taiwanese convertToTaiwaneseOrthography];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",definition.chinese, definition.english];
    
    return cell;
}

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
     // Return NO if you do not want the specified item to be editable.
     return YES;
 }

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         // we're operating on a copy of tableData. All we can do is set it.
         NSMutableArray *temp = [NSMutableArray arrayWithCapacity:1];
         temp = self.tableData;
         [temp removeObjectAtIndex:indexPath.row];
         self.tableData = temp;
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     } else if (editingStyle == UITableViewCellEditingStyleInsert) {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
 }

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EntryTableViewController *controller = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Entry *entry;
    entry = self.tableData[indexPath.row];
    controller.entry = entry;
    //    if ([[segue identifier] isEqualToString:@"favorites"])
    //    {
    //    }
}


@end
