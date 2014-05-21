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
#import <ParseKit/ParseKit.h>
#import "NSString+Taiwanese.h"

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

    // Store dictionary in plist
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:@"dictionary.plist"];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionaryArray];
    //NSData *data = [NSKeyedArchiver archivedDataWithRootObject:@[lastDefinition, lastDefinition, lastDefinition]];
    //BOOL result = [data writeToFile:filePath atomically:YES];
    
    UINib *nib = [UINib nibWithNibName:@"DefinitionTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"Definition"];
    
    // Add BarButtonItem for adding an Entry to Favorites
    UIBarButtonItem *addFavorite = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage imageNamed:@"favorites"]
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(addFavorite)];
    self.navigationItem.rightBarButtonItem = addFavorite;
    
    
    NSString *formattedTaiwanese = [self.entry.key convertToTaiwaneseOrthography];
    self.navigationItem.title = formattedTaiwanese;
    //self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"history"];
    
    [self saveHistory];
    
    // Set up a ParseKit tokenizer and add symbols for all sounds in Peh-oe-ji.
    // http://en.wikipedia.org/wiki/Taiwanese_Hokkien
    // http://210.240.194.97/giankiu/lunbun/Ungian/ch3.pdf
    
    // convert peh-oe-ji to numbered POJ. Maybe I should store the data as numbered peh-oe-ji? Is there an advantage for lookups? Ordering? similar syllables would group in tone order...
    
    [self.entry.key convertPehoejiToNumberedPehoeji];
    
    PKTokenizer *tokenizer = [PKTokenizer tokenizerWithString:self.entry.key];
    [tokenizer setTokenizerState:tokenizer.symbolState from:0 to:255];
    
    NSArray *toneArray = @[@"", @"́", @"̀", @"̂", @"̄", @"̍"];
    NSArray *toneArray48 = @[@"t", @"p", @"k", @"h", @"̍t", @"̍p", @"̍k", @"̍h"];
    NSArray *simpleVowels = @[@"a", @"i", @"u", @"e", @"o", @"o͘", @"m"];
    NSArray *compoundVowels = @[@"ai", @"au", @"ia", @"iu", @"io", @"iau", @"ui", @"oa", @"oe", @"oai", @"ng"];
    
    for (NSString *tone in toneArray) {
        // Simple Vowels
        for (NSString *vowel in simpleVowels) {
            NSMutableString *newSymbol = [vowel mutableCopy];
            [newSymbol insertString:tone atIndex:1];
            [tokenizer.symbolState add:newSymbol];
        }
        for (NSString *vowel in compoundVowels) {
            NSMutableString *newSymbol = [vowel mutableCopy];
            [newSymbol insertString:tone atIndex:1];
            [tokenizer.symbolState add:newSymbol];
        }
        for (NSString *vowel in compoundVowels) {
            NSMutableString *newSymbol = [vowel mutableCopy];
            [newSymbol insertString:tone atIndex:2];
            [tokenizer.symbolState add:newSymbol];
        }
    }
    
    for (NSString *tone in toneArray48) {
        for (NSString *vowel in simpleVowels) {
            NSMutableString *newSymbol = [vowel mutableCopy];
            [newSymbol insertString:tone atIndex:1];
            [tokenizer.symbolState add:newSymbol];
        }
        for (NSString *vowel in compoundVowels) {
            NSMutableString *newSymbol = [vowel mutableCopy];
            [newSymbol insertString:tone atIndex:1];
            [tokenizer.symbolState add:newSymbol];
        }
        for (NSString *vowel in compoundVowels) {
            NSMutableString *newSymbol = [vowel mutableCopy];
            [newSymbol insertString:tone atIndex:2];
            [tokenizer.symbolState add:newSymbol];
        }
    }
    
    // Nasal Vowels
    
    
    // Vowels with Suffixes
//    [tokenizer.symbolState add:@"am"];
//    [tokenizer.symbolState add:@"an"];
//    [tokenizer.symbolState add:@"ang"];
//    [tokenizer.symbolState add:@"m"];
//    [tokenizer.symbolState add:@"om"];
//    [tokenizer.symbolState add:@"ng"];
//    [tokenizer.symbolState add:@"ian"];
//    [tokenizer.symbolState add:@"eng"];
//    [tokenizer.symbolState add:@"oan"];
//    [tokenizer.symbolState add:@"ong"];
    
    // Nasal
    [tokenizer.symbolState add:@"ⁿ"];
    
    // Syllable delimiter
    [tokenizer.symbolState add:@"-"];

    // Consonants
    [tokenizer.symbolState add:@"p"];
    [tokenizer.symbolState add:@"b"];
    [tokenizer.symbolState add:@"ph"];
    [tokenizer.symbolState add:@"m"];
    [tokenizer.symbolState add:@"t"];
    [tokenizer.symbolState add:@"th"];
    [tokenizer.symbolState add:@"n"];
    [tokenizer.symbolState add:@"ng"];
    [tokenizer.symbolState add:@"l"];
    [tokenizer.symbolState add:@"k"];
    [tokenizer.symbolState add:@"g"];
    [tokenizer.symbolState add:@"kh"];
    [tokenizer.symbolState add:@"h"];
    [tokenizer.symbolState add:@"chi"];
    [tokenizer.symbolState add:@"ji"];
    [tokenizer.symbolState add:@"chhi"];
    [tokenizer.symbolState add:@"si"];
    [tokenizer.symbolState add:@"ch"];
    [tokenizer.symbolState add:@"j"];
    [tokenizer.symbolState add:@"chh"];
    [tokenizer.symbolState add:@"s"];
    
    // Tones
    [tokenizer.symbolState add:@"́"]; // 2
    [tokenizer.symbolState add:@"̀"]; // 3
    [tokenizer.symbolState add:@"̂"]; // 5
    [tokenizer.symbolState add:@"̄"]; // 7
    [tokenizer.symbolState add:@"̍"]; // 8
    [tokenizer.symbolState add:@"p"]; // 4, 8
    [tokenizer.symbolState add:@"t"]; // 4, 8
    [tokenizer.symbolState add:@"k"]; // 4, 8
    [tokenizer.symbolState add:@"h"]; // 4, 8

    [tokenizer enumerateTokensUsingBlock:^(PKToken *tok, BOOL *stop) {
        //NSLog(@"Token: %@\tisWord: %d", (NSString *) tok.value, tok.isWord);
    }];
    
    
}

- (void) saveHistory
{
    // Get existing history
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = @"recent.plist";
    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // if history is nil, create an empty array
    if (!array) {
        array = @[];
    }
    
    // Add entry to history, filtering array for duplicates
    NSMutableArray *newHistory = [@[] mutableCopy];
    [newHistory addObject:self.entry];
    for (Entry *entry in array) {
        if (![entry.key isEqualToString:self.entry.key]) {
            [newHistory addObject:entry];
        }
    }
    
    // Limit length of history to the maximum number of entries in settings
    NSNumber *maximumRecentEntries = [[NSUserDefaults standardUserDefaults] objectForKey:@"maximumRecentEntries"];

    if ([newHistory count] > [maximumRecentEntries intValue]) {
        newHistory = [NSMutableArray arrayWithArray:[newHistory subarrayWithRange:NSMakeRange(0, [maximumRecentEntries intValue])]];
    }
    
    // Store new history
    NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:newHistory];
    BOOL result = [newData writeToFile:filePath atomically:YES];
    if (result) {
        //NSLog(@"Successfully wrote %@ to %@. %lu items total.",self.entry.key, fileName, (unsigned long)[newHistory count]);
    } else {
        NSLog(@"Error writing the history to a file");
    }
}

-(void)addFavorite
{
    // Get existing favorites
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = @"favorites.plist";
    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // if array is nil, create an empty array
    if (!array) {
        array = @[];
    }
    
    // Add entry to favorites
    NSMutableArray *newFavorites = [array mutableCopy];
    [newFavorites insertObject:self.entry atIndex:0];
    
    // Store new favorite
    NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:newFavorites];
    BOOL result = [newData writeToFile:filePath atomically:YES];
    if (result) {
        //NSLog(@"Successfully wrote %@ to %@. %lu items total.",self.entry.key, fileName, (unsigned long)[newFavorites count]);
    } else {
        NSLog(@"Error writing the favorites to a file");
    }
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
    NSString *formattedTaiwanese = [definition.taiwanese convertToTaiwaneseOrthography];
    cell.taiwaneseLabel.text = [NSString stringWithFormat:@"%@. %@",@(indexPath.row + 1),formattedTaiwanese];
    cell.chineseLabel.text = definition.chinese;
    cell.englishLabel.text = definition.english;

    if ([definition.examples count]) {
        NSString *examplesString = @"";
        for (Example *example in definition.examples) {
            NSString *formattedTaiwanese = [example.taiwanese convertToTaiwaneseOrthography];
            examplesString = [examplesString stringByAppendingString:[NSString stringWithFormat:@"%@\n%@\n%@\n\n", formattedTaiwanese, example.chinese, example.english]];
        }
        cell.examplesLabel.text = [examplesString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    } else {
        [cell.examplesLabel removeFromSuperview];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow = 0;
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DefinitionTableViewCell" owner:self options:nil];
    DefinitionTableViewCell *cell = [topLevelObjects objectAtIndex:0];
    
    Definition *definition = self.entry.definitions[indexPath.row];
    NSString *formattedTaiwanese = [definition.taiwanese convertToTaiwaneseOrthography];
    cell.taiwaneseLabel.text = [NSString stringWithFormat:@"%@. %@",@(indexPath.row + 1),formattedTaiwanese];
    cell.chineseLabel.text = definition.chinese;
    cell.englishLabel.text = definition.english;
    
    // Taiwanese Label height calculations
    NSString *text = cell.taiwaneseLabel.text;
    CGFloat width = cell.taiwaneseLabel.frame.size.width;
    UIFont *font = cell.taiwaneseLabel.font;
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGFloat taiwaneseHeight = ceil(rect.size.height);

    // Chinese Label height calculations
    text = cell.chineseLabel.text;
    width = cell.chineseLabel.frame.size.width;
    font = cell.chineseLabel.font;
    attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font}];
    rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                        context:nil];
    CGFloat chineseHeight = ceil(rect.size.height);
    
    // English Label height calculations
    text = definition.english;
    width = cell.englishLabel.frame.size.width;
    font = cell.englishLabel.font;
    attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font}];
    rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                        context:nil];
    CGFloat englishHeight = ceil(rect.size.height);

    // Examples Label height calculations
    NSString *examplesString = @"";
    for (Example *example in definition.examples) {
        //NSLog(@"Number of examples: %d", [definition.examples count]);
        NSString *formattedTaiwanese = [example.taiwanese convertToTaiwaneseOrthography];
        examplesString = [examplesString stringByAppendingString:[NSString stringWithFormat:@"%@\n%@\n%@\n\n", formattedTaiwanese, example.chinese, example.english]];
    }
    cell.examplesLabel.text = [examplesString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    text = cell.examplesLabel.text;
    width = cell.examplesLabel.frame.size.width;
    font = cell.examplesLabel.font;
    attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font}];
    rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGFloat examplesHeight = ceil(rect.size.height);
    
    int topRowHeight = taiwaneseHeight > chineseHeight ? taiwaneseHeight:chineseHeight;
    
    if ([definition.examples count]) {
        // top space + taiwaneseHeight + inner space + englishHeight + inner space + examplesHeight + bottom space
        heightForRow = 20 + topRowHeight + 8 + englishHeight + 8 + examplesHeight + 20;
    } else {
        // top space + taiwaneseHeight + inner space + englishHeight + bottom space
        heightForRow = 20 + topRowHeight + 8 + englishHeight + 20;
    }
    
    //NSLog(@"h1: %f\th2: %f\th3: %f", englishHeight, examplesHeight, heightForRow);

    return heightForRow;
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
