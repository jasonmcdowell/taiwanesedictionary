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
#import "NSString+TaiwaneseHelpers.h"
#import "NSString+Maryknoll.h"

@interface StartingViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableDictionary *dictionary;
@property (strong, nonatomic) NSMutableArray *filteredArray;
@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) RMEIdeasPullDownControl *rmeideasPullDownControl;
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

// lazy instantiation
- (NSMutableArray *) history {
    if (!_history) {
        _history = [[NSMutableArray alloc] init];
    }
    
    return _history;
}

// lazy instantiation
- (NSMutableArray *) favorites {
    if (!_favorites) {
        _favorites= [[NSMutableArray alloc] init];
    }
    
    return _favorites;
}

#pragma mark - Initialize Table View

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    self.filteredArray = [NSMutableArray arrayWithArray:@[]];
//    self.searchText = @"";
//}

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
    
    self.rmeideasPullDownControl.layer.borderColor = [UIColor clearColor].CGColor;
    
    //[self loadDictionary];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.searchDisplayController.searchResultsTableView reloadData];
    
    
    NSString *sortOrderField = [[NSUserDefaults standardUserDefaults] objectForKey:@"sortOrder"];
    NSUInteger  controlIndex = 0;
    if ([sortOrderField isEqualToString:@"taiwanese"]) {
        controlIndex = 0;
    } else if ([sortOrderField isEqualToString:@"english"]) {
        controlIndex = 1;
    } else if ([sortOrderField isEqualToString:@"chinese"]) {
        controlIndex = 2;
    } else {
        controlIndex = 0;
        NSLog(@"Unknown sort order chosen. Defaulting to Taiwanese");
    }
    
    [self.rmeideasPullDownControl selectControlAtIndex:controlIndex];
    
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
    
    //NSLog(@"Loading dictionary from file.");
    //NSLog(@"The dictionary has %@ entries.", @([self.dictionaryArray count]));
    
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
    return [self.filteredArray count];
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
    NSString *formattedTaiwanese = [definition.taiwanese convertToTaiwaneseOrthography];
    cell.textLabel.text = formattedTaiwanese;
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

#pragma mark - Content Filtering
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

        // don't search if the string is whitespace or empty
        if ([[searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            return;
        }
        
        /* 
         Analyze search text and customize behavior
         - if the search text is written in Chinese, only the chinese field will be searched.
         - if we detect numbers, we will search for tones by number, otherwise tones are ignored.
         - if we detect diacritics, we will search for exact diacritic matches
         */
        
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
        NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:1];
        // Filter the array using NSPredicate
        NSInteger i = 0;
        
        NSString *formattedSearchText = searchText;
        
        BOOL containsDiacritics = [searchText containsDiacritics];
        BOOL containsNumbers = [searchText containsNumbers];
        BOOL containsHanji = [script isEqualToString:@"Hans"] || [script isEqualToString:@"Hant"] || [script isEqualToString:@"Hani"];
        
        if (containsDiacritics || containsNumbers) {
            formattedSearchText = [[searchText removeDashes] convertToNumberedPehoeji];
        } else {
            formattedSearchText = [[[searchText removeDashes] convertToNumberedPehoeji] removeNumbers];
        }
        NSLog( @"Search: %d %d %@",containsDiacritics,containsNumbers, searchText);

        NSLog( @"Search: %@", formattedSearchText);
        
        for (Entry *entry in self.dictionaryArray) {

            // every 100 iterations, check to see if the search string has changed. If it has, then the current search should stop.
            if (!(i % 100)) {
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
            if (containsHanji)
            {
                //NSLog(@"Searching chinese text.");
                for (Definition *definition in entry.definitions) {
                    NSString *defintionString = definition.chinese;
                    NSRange matchedRange = [defintionString rangeOfString:searchText];
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
                    
                    NSString *defintionString = @"";
                    if (containsDiacritics || containsNumbers) {
                        defintionString = [definition.taiwanese removeDashes];
                    } else {
                        defintionString = [[definition.taiwanese removeDashes] removeNumbers];
                    }
                    
                    //NSLog( @"\t%@", defintionString);
                    NSRange matchedRange = [defintionString rangeOfString:formattedSearchText options:NSCaseInsensitiveSearch];
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
        
        // sort filtered data here
//        NSString *sortOrderField = [[NSUserDefaults standardUserDefaults] objectForKey:@"sortOrder"];
//        //NSLog(@"Loading sort order: %@", sortOrderField);
//        
//        if (![sortOrderField isEqualToString:@"taiwanese"] && ![sortOrderField isEqualToString:@"chinese"] && ![sortOrderField isEqualToString:@"english"]) {
//            NSLog(@"Unknown orthography selected. Defaulting to Taiwanese");
//            sortOrderField = @"taiwanese";
//        }
//        
//        
//        tempArray = [[tempArray sortedArrayUsingComparator: ^NSComparisonResult(id a, id b) {
//            Entry *first = (Entry *) a;
//            Entry *second = (Entry *) b;
//            
//            Definition *firstDefinition =  first.definitions[0];
//            Definition *secondDefinition =  second.definitions[0];
//            
//            NSString *firstString = [firstDefinition performSelector:NSSelectorFromString(sortOrderField)];
//            NSString *secondString = [secondDefinition performSelector:NSSelectorFromString(sortOrderField)];
//            
//            //NSLog(@"%@, %@", firstString, secondString);
//            //NSLog(@"%d", [firstString compare:secondString options:NSCaseInsensitiveSearch]);
//            
//            return [firstString compare:secondString options:NSCaseInsensitiveSearch];
//            
//            //        NSString *firstString = [first.key removeSourceToneMarks];
//            //        NSString *secondString = [second.key removeSourceToneMarks];
//            //        return [firstString compare:secondString options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch];
//        }] mutableCopy];
        
        // if the search is still valid, set the filtered array to the search results
        if ([self.searchText isEqualToString:searchText]) {
            UISearchDisplayController *controller = self.searchDisplayController;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.filteredArray = tempArray;
                //NSLog(@"results: %@",tempArray);
                [controller.searchResultsTableView reloadData];
                
                self.rmeideasPullDownControl = [[RMEIdeasPullDownControl alloc] initWithDataSource:self
                                                                                          delegate:self
                                                                                  clientScrollView:self.searchDisplayController.searchResultsTableView];
                
                CGRect originalFrame = self.rmeideasPullDownControl.frame;
                self.rmeideasPullDownControl.frame = CGRectMake(0.0, self.searchBar.frame.size.height, originalFrame.size.width, originalFrame.size.height);
                
                //It is recommended that the control is placed behind the client scrollView. Remember to make its background transparent.
                [self.view insertSubview:self.rmeideasPullDownControl belowSubview:self.searchDisplayController.searchResultsTableView];

                self.rmeideasPullDownControl.userInteractionEnabled = NO;
                self.rmeideasPullDownControl.layer.borderColor = [UIColor clearColor].CGColor;
                
                NSString *sortOrderField = [[NSUserDefaults standardUserDefaults] objectForKey:@"sortOrder"];
                NSUInteger  controlIndex = 0;
                if ([sortOrderField isEqualToString:@"taiwanese"]) {
                    controlIndex = 0;
                } else if ([sortOrderField isEqualToString:@"english"]) {
                    controlIndex = 1;
                } else if ([sortOrderField isEqualToString:@"chinese"]) {
                    controlIndex = 2;
                } else {
                    controlIndex = 0;
                    NSLog(@"Unknown sort order chosen. Defaulting to Taiwanese");
                }
                
                [self.rmeideasPullDownControl selectControlAtIndex:controlIndex];
                
            });
        }
        
    });
    
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
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

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    self.searchDisplayController.searchResultsTableView.hidden  = YES;
//    self.rmeideasPullDownControl.layer.backgroundColor = [UIColor clearColor].CGColor;
//    [self.rmeideasPullDownControl removeFromSuperview];
//    self.rmeideasPullDownControl = nil;
}


#pragma mark - Generate Dictionary

- (void) generateDictionary
{
    /*
     Instructions for generating a dictionary file from Mkdictionary.xls
     
     1. Open Mkdictionary.xls in Excel. Export the data as Mkdictionary.txt with UTF-16 text.
     2. Move the file Mkdictionary.txt to the app bundle (supporting files).
     3. Run this generateDictionary method via the regenerateDictionary method.
     4. Copy the generated dictionary.plist from the Document directory to the app bundle.
     4. Remove Mkdictionary.txt from from the app bundle.
     
     */
    
    
    #define COMPLETE_DICTIONARY @"Mkdictionary"
    NSString *resource = COMPLETE_DICTIONARY;
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:resource ofType:@"txt"];
    NSError *error;
    NSString *entireFileInString = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
    
    // try UTF-16 encoding in case UTF-8 doesn't work
    if (!entireFileInString) {
        entireFileInString = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF16StringEncoding error:&error];
    }
    
    if(entireFileInString == nil) {
        NSLog(@"Error : %@", [error localizedDescription]);
    }
    
    NSArray *lines = [entireFileInString componentsSeparatedByString:@"\n"];
    NSLog(@"path:%@\n", fullPath);
    NSLog(@"Loaded %@ lines of data.", @([lines count]));
    
    // Remove first line of data, if the header is there.
    NSString *line = [lines firstObject];
    NSString *firstLineString = [line substringToIndex:[@"Sort" length]];
    if ([firstLineString isEqualToString:@"Sort"]) {
        lines = [lines subarrayWithRange:NSMakeRange(1, [lines count]-1)];
        NSLog(@"Removed the first line of data: %@", line);
        NSLog(@"We now have %@ lines of data.", @([lines count]));
    }
    
    // parse lines and put into dictionary
    Definition *lastDefinition = [[Definition alloc] init];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    float totalLines = (float) [lines count];
    float progress = 0.0;
    //self.progress.progress = progress;
    for (NSString *line in lines) {
        progress += 1.0 / totalLines;
        //NSLog(@"progress: %f", progress);
        //dispatch_async(dispatch_get_main_queue(), ^{[self.progress setProgress:progress animated:YES];});
        
        NSArray *parsedLine = [line componentsSeparatedByString:@"\t"];
        if ([parsedLine count] == 4) {
            NSString *taiwanese = parsedLine[1];
            NSString *chinese = parsedLine[2];
            NSString *english = parsedLine[3];
            
            // Format the taiwanese, chinese, and english strings.
            //taiwanese = [[taiwanese removeOuterQuotesDebug] convertSourceToPehoeji]; //NSLog(@"%@",taiwanese);
            taiwanese = [[[taiwanese removeOuterQuotesDebug] convertSourceToNumberedPehoeji] removedDoubledNumbers]; //NSLog(@"%@",taiwanese);
            chinese = [chinese removeOuterQuotesDebug];
            english = [english removeOuterQuotesDebug];
            
            //NSLog(@"English: %@", english);
            
            //check to see if this line contains an example
            if ([taiwanese length] >= 1) {
                if ([[taiwanese substringToIndex:1] isEqualToString:@":"]) {
                    Example *example = [[Example alloc] initWithTaiwanese:[taiwanese removeColons]
                                                                  Chinese:chinese
                                                                  English:english];
                    // add this example to the previous defintion, and add it back to the dictionary
                    [lastDefinition addExample:example];
                    continue;
                }
            }
            
            //NSLog(@"%@",taiwanese);
            
            Definition *defintion = [[Definition alloc] initWithTaiwanese:taiwanese
                                                                  Chinese:chinese
                                                                  English:english
                                                                 Examples:nil];
            // Check to see if we have already stored this Definition as an Entry.
            NSString *entryKey = taiwanese;
            Entry *entry = [dictionary objectForKey:entryKey];
            if (!entry) {
                entry = [[Entry alloc] initWithKey:entryKey];
            }
            
            // Add the Definition to the Entry.
            [entry addDefinition:defintion];
            [dictionary setObject:entry forKey:entry.key];
            //NSLog(@"Stored entry with key: %@", entryKey);
            
            // Remember this Definition.
            lastDefinition = defintion;
        } else {
            NSLog(@"Unexpected format in source file for line:\n%@", line);
        }
    }
    
    NSArray *dictionaryArray = [[NSArray alloc] init];
    
    dictionaryArray = [[dictionary allValues] sortedArrayUsingComparator: ^NSComparisonResult(id a, id b) {
        Entry *first = (Entry *) a;
        Entry *second = (Entry *) b;
        
        NSString *firstString = first.key;
        NSString *secondString = second.key;
        
        return [firstString compare:secondString options:NSCaseInsensitiveSearch];

//        NSString *firstString = [first.key removeSourceToneMarks];
//        NSString *secondString = [second.key removeSourceToneMarks];
//        return [firstString compare:secondString options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch];
    }];
//    
//    for (Entry *entry in dictionaryArray) {
//        NSLog(@"%@", entry.key);
//    }
    
    // Store dictionary in plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:@"dictionary.plist"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionaryArray];
    //NSData *data = [NSKeyedArchiver archivedDataWithRootObject:@[lastDefinition, lastDefinition, lastDefinition]];
    BOOL result = [data writeToFile:filePath atomically:YES];
    
    if (result) {
        NSLog(@"Successfully wrote the dictionary to a file");
        NSLog(@"path:%@\n", filePath);
    } else {
        NSLog(@"Error writing the dictionary to a file");
    }
    
}

- (IBAction)regenerateDictionary:(id)sender
{
    NSLog(@"Regenerating dictionary.");
    dispatch_queue_t queue = dispatch_queue_create("generateDictionary", NULL);
    dispatch_async(queue, ^{
        [self generateDictionary];
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.tableView reloadData];
        });
    });
}

#pragma mark - RMEIdeasePullDownControl DataSource and Delegate methods

- (UIImage*) rmeIdeasPullDownControl:(RMEIdeasPullDownControl*)rmeIdeasPullDownControl imageForControlAtIndex:(NSUInteger)controlIndex
{
    UIImage *image0 = [UIImage imageNamed:@"sortTaiwanese.png"];
    UIImage *image1 = [UIImage imageNamed:@"sortEnglish.png"];
    UIImage *image2 = [UIImage imageNamed:@"sortChinese.png"];
    
    NSArray *imagesArray = @[image0, image1, image2];
    
    return imagesArray[controlIndex];
}
- (UIImage*) rmeIdeasPullDownControl:(RMEIdeasPullDownControl*)rmeIdeasPullDownControl selectedImageForControlAtIndex:(NSUInteger)controlIndex
{
    UIImage *image0 = [UIImage imageNamed:@"sortTaiwaneseSelected.png"];
    UIImage *image1 = [UIImage imageNamed:@"sortEnglishSelected.png"];
    UIImage *image2 = [UIImage imageNamed:@"sortChineseSelected.png"];
    
    NSArray *imagesArray = @[image0, image1, image2];
    
    return imagesArray[controlIndex];
}
- (NSString*) rmeIdeasPullDownControl:(RMEIdeasPullDownControl*)rmeIdeasPullDownControl titleForControlAtIndex:(NSUInteger)controlIndex
{
    NSArray *array = @[@"Sort order: Taiwanese", @"Sort order: English", @"Sort order: Chinese"];
    return array[controlIndex];
}
- (NSUInteger) numberOfButtonsRequired:(RMEIdeasPullDownControl*)rmeIdeasPullDownControl
{
    return 3;
}

- (void) rmeIdeasPullDownControl:(RMEIdeasPullDownControl*)rmeIdeasPullDownControl selectedControlAtIndex:(NSUInteger)controlIndex
{
    NSString *sortOrderField = @"";
    
    if (controlIndex == 0) {
        sortOrderField = @"taiwanese";
    } else if (controlIndex == 1) {
        sortOrderField = @"english";
    } else if (controlIndex == 2) {
        sortOrderField = @"chinese";
    } else {
        sortOrderField = @"taiwanese";
        NSLog(@"Unknown sort order chosen. Defaulting to Taiwanese");
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:sortOrderField forKey:@"sortOrder"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // sort filtered data here
    
    NSArray *tempArray = [self.filteredArray sortedArrayUsingComparator: ^NSComparisonResult(id a, id b) {
        Entry *first = (Entry *) a;
        Entry *second = (Entry *) b;
        
        Definition *firstDefinition =  first.definitions[0];
        Definition *secondDefinition =  second.definitions[0];
        
        NSString *firstString = @"";
        NSString *secondString = @"";
        
        if ([sortOrderField isEqualToString:@"taiwanese"]) {
            firstString = firstDefinition.taiwanese;
            secondString = secondDefinition.taiwanese;
        } else if ([sortOrderField isEqualToString:@"english"]) {
            firstString = firstDefinition.english;
            secondString = secondDefinition.english;
        } else if ([sortOrderField isEqualToString:@"chinese"]) {
            firstString = [firstDefinition.chinese pinyin];
            secondString = [secondDefinition.chinese pinyin];
        }
        
        //NSLog(@"%@, %@", firstString, secondString);
        //NSLog(@"%d", [firstString compare:secondString options:NSCaseInsensitiveSearch]);
        
        return [firstString compare:secondString options:NSCaseInsensitiveSearch];
        
        //        NSString *firstString = [first.key removeSourceToneMarks];
        //        NSString *secondString = [second.key removeSourceToneMarks];
        //        return [firstString compare:secondString options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch];
    }];
    
    self.filteredArray = [tempArray mutableCopy];
    
    [self.searchDisplayController.searchResultsTableView reloadData];
}


@end
