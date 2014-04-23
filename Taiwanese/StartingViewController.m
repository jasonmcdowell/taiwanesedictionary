//
//  StartingViewController.m
//  Taiwanese
//
//  Created by Jason McDowell on 3/17/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "StartingViewController.h"
#import "Entry.h"
#import "Definition.h"
#import "Example.h"
#import "EntryTableViewController.h"
#import "NSString+Taiwanese.h"

@interface StartingViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableDictionary *dictionary;
@property (strong, nonatomic) NSArray *dictionaryArray;
@property (strong, nonatomic) NSMutableArray *filteredArray;
@property (strong, nonatomic) NSString *searchText;
@end

@implementation StartingViewController

#pragma mark - Lazy Instantiation

// lazy instantiation
- (NSMutableDictionary *) dictionary {
    if (!_dictionary) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _dictionary;
}

// lazy instantiation
- (NSArray *) dictionaryArray {
    if (!_dictionaryArray) {
        _dictionaryArray = [[NSArray alloc] init];
    }
    
    return _dictionaryArray;
}

// lazy instantiation
- (NSMutableArray *) filteredArray {
    if (!_filteredArray) {
        _filteredArray = [[NSMutableArray alloc] init];
    }
    
    return _filteredArray;
}

#pragma mark - Initialize Table View

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Retrieve stored dictionary
    dispatch_queue_t queue = dispatch_queue_create("loadDictionary", NULL);
    dispatch_async(queue, ^{
        [self loadDictionary];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchBar.text = self.searchText;
        });
    });
    
    //[self loadDictionary];
}

- (void) loadDictionary
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:@"dictionary.plist"];
    
    NSString *resource = @"dictionary";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:resource ofType:@"plist"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (array) {
        self.dictionaryArray = array;
    } else {
        self.dictionaryArray = @[];
    }
    self.filteredArray = [NSMutableArray arrayWithCapacity:[self.dictionaryArray count]];
    
    NSLog(@"Loading dictionary from file.");
    NSLog(@"The dictionary has %@ entries.", @([self.dictionaryArray count]));
    
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredArray count];
    } else {
        return [self.dictionaryArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"SearchResultsTableViewCell";
//    UITableViewCell *cell = [self.searchDisplayController.searchResultsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell == nil) {
//        // Load the top-level objects from the custom cell XIB.
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SearchResultsTableViewCell" owner:self options:nil];
//        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
//        cell = [topLevelObjects objectAtIndex:0];
//    }
//    if (cell == nil) {
//        cell = [[SearchResultsTableViewCell alloc] init];
//    }
    
    static NSString *CellIdentifier = @"SearchResultsTableViewCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    Entry *entry;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if ([self.filteredArray count] > indexPath.row) {
            entry = [self.filteredArray objectAtIndex:indexPath.row];
        }
        
    } else {
        //NSLog(@"row: %d", indexPath.row);
        entry = [self.dictionaryArray objectAtIndex:indexPath.row];
    }
    
    Definition *definition = [entry.definitions firstObject];
    cell.textLabel.text = definition.taiwanese;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",definition.chinese, definition.english];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EntryTableViewController *controller = [[EntryTableViewController alloc] init];
    Entry *entry;
    entry = self.filteredArray[indexPath.row];
    controller.entry = entry;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    //NSLog( @"Initiated search for \"%@\" with scope \"%@\".", searchText, scope);
    
    @synchronized (self)
    {
        self.searchText = [searchText copy];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("search", NULL);
    dispatch_async(queue, ^{
        //NSDate* start = [NSDate date];
        
        // check to see if the search string has changed since this queue was started.
        if ( ![self.searchText isEqualToString:searchText] ) {
            return;
        }
        

        if ([[searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            return;
        }
        
        // Attempt to figure out the language of the search text
        NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:@[NSLinguisticTagSchemeLanguage, NSLinguisticTagSchemeScript] options:0];
        [tagger setString:searchText];
        NSString *script = [tagger tagAtIndex:0 scheme:NSLinguisticTagSchemeScript tokenRange:NULL sentenceRange:NULL];
        
        //NSString *language = [tagger tagAtIndex:0 scheme:NSLinguisticTagSchemeLanguage tokenRange:NULL sentenceRange:NULL];
        //NSOrthography *orthography = [tagger orthographyAtIndex:0 effectiveRange:nil];
        //        NSLog(@"Language: %@", language);
        //        NSLog(@"Script: %@ %d", script, ([script isEqualToString:@"Hans"] || [script isEqualToString:@"Hant"] || [script isEqualToString:@"Hani"]));
        //        NSLog(@"Orthography: %@", orthography);
        
        // start searching for matching strings
        NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:[self.dictionaryArray count]];
        // Filter the array using NSPredicate
        NSInteger i = 0;
        for (Entry *entry in self.dictionaryArray) {
            
            // every 1000 iterations, check to see if the search string has changed. If it has, then the current search should stop.
            if (!(i % 1000)) {
                //NSLog(@"search: %@ Script: %@ %d, %d", searchText, script, ([script isEqualToString:@"Hans"] || [script isEqualToString:@"Hant"] || [script isEqualToString:@"Hani"]), i);
                if ( ![self.searchText isEqualToString:searchText] ) {
                    //NSTimeInterval timer = [start timeIntervalSinceNow];
                    //NSLog( @"Interrupted search. \"%@\" != \"%@\" with scope \"%@\" after %.4lf seconds.",searchText, self.searchText, scope, -1.0*timer);
                    break;
                }
            }
            i++;
            
            //NSLog(@"Script: %@ %d", script, ([script isEqualToString:@"Hans"] || [script isEqualToString:@"Hant"] || [script isEqualToString:@"Hani"]));
            // If the searchText is in Chinese, search the chinese definitions. Ignore the choice of scope.
            if ([script isEqualToString:@"Hans"] || [script isEqualToString:@"Hant"] || [script isEqualToString:@"Hani"])
            {
                //NSLog(@"Searching chinese text.");
                for (Definition *definition in entry.definitions) {
                    NSString *defintionString = definition.chinese;
                    NSRange matchedRange = [defintionString rangeOfString:searchText options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch];
                    BOOL foundEntry = matchedRange.length > 0;
                    if (foundEntry)
                    {
                        if (([scope isEqualToString:@"begins"] && (matchedRange.location == 0)) || [scope isEqualToString:@"contains"]) {
                            [tempArray addObject:entry];
                        }
                        
                    }
                }
            }
            else
            {
                for (Definition *definition in entry.definitions) {
                    NSString *defintionString = [definition.taiwanese removeDashes];
                    NSRange matchedRange = [defintionString rangeOfString:[searchText removeDashes] options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch];
                    BOOL foundEntry = matchedRange.length > 0;
                    // search Taiwanese definitions
                    if (foundEntry)
                    {
                        // if the scope is "begins" and the string is matched at the beginning OR if the scope is "contains"
                        if (([scope isEqualToString:@"begins"] && (matchedRange.location == 0)) || [scope isEqualToString:@"contains"]) {
                            [tempArray addObject:entry];
                            break;
                        }
                    }
                    else
                    {
                        // search English definitions
                        NSString *defintionString = definition.english;
                        NSRange matchedRange = [defintionString rangeOfString:searchText options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch];
                        BOOL foundEntry = matchedRange.length > 0;
                        if (foundEntry)
                        {
                            if (([scope isEqualToString:@"begins"] && (matchedRange.location == 0)) || [scope isEqualToString:@"contains"]) {
                                [tempArray addObject:entry];
                                break;
                            }
                            
                        }
                    }
                    
                }
            }
        }
        
        // if the search is still valid, set the filtered array to the search results
        if ([self.searchText isEqualToString:searchText]) {
            UISearchDisplayController *controller = self.searchDisplayController;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.filteredArray = tempArray;
                //NSLog(@"results: %@",tempArray);
                [controller.searchResultsTableView reloadData];
            });
        }
        
    });
    
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}




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
