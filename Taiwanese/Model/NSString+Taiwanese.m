//
//  NSString+Taiwanese.m
//  Table View Practice
//
//  Created by Jason McDowell on 3/10/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "NSString+Taiwanese.h"

@implementation NSString (Taiwanese)

- (NSString *)convertSourceToPehoeji
{
    NSString *changedString = [self copy];
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"o2+" withString:@"o+2"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"o3+" withString:@"o+3"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"o5+" withString:@"o+5"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"o7+" withString:@"o+7"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"o8+" withString:@"o+8"];
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"+" withString:@"͘"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"2" withString:@"́"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"3" withString:@"̀"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"5" withString:@"̂"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"7" withString:@"̄"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"8" withString:@"̍"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"*" withString:@"ⁿ"];
    
    //NSLog(@"%@",changedString);
    return changedString;
}

- (NSString *)convertSourceToNumberedPehoeji
{
    NSString *changedString = [self copy];
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"+" withString:@"u"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"*" withString:@"nn"];
    
    changedString = [changedString pushNumbersToEndOfSyllable];
    changedString = [changedString insertTones1And4];

    //NSLog(@"%@",changedString);
    return changedString;
}

- (NSString *)removeSourceToneMarks
{
    NSString * changedString = [self copy];

    NSCharacterSet *invalidSet = [NSCharacterSet characterSetWithCharactersInString:@"[]0123456789 +*"];
    return [[changedString componentsSeparatedByCharactersInSet:invalidSet] componentsJoinedByString:@""];
}

- (NSString *)removeColons
{
    NSString * changedString = [self copy];
    
    NSCharacterSet *invalidSet = [NSCharacterSet characterSetWithCharactersInString:@":"];
    return [[changedString componentsSeparatedByCharactersInSet:invalidSet] componentsJoinedByString:@""];
}

- (NSString *)removeDashes
{
    NSString * changedString = [self copy];
    
    NSCharacterSet *invalidSet = [NSCharacterSet characterSetWithCharactersInString:@"-"];
    return [[changedString componentsSeparatedByCharactersInSet:invalidSet] componentsJoinedByString:@" "];
}

- (NSString *)removeOuterQuotes
{
    NSString *changedString = [self copy];

    if ([changedString hasPrefix:@"\""] && [changedString hasSuffix:@"\""]) {
        //NSLog(@"Before removing outer quotes: %@", changedString);
        changedString = [changedString substringWithRange:NSMakeRange(1, [changedString length]-2)];
        //NSLog(@"After removing outer quotes: %@", changedString);

    }
    
    return changedString;
}

- (NSString *)removeOuterQuotesDebug
{
    NSString *changedString = [self copy];
    
    NSRange firstQuoteRange = [changedString rangeOfString:@"\"" options:0];
    NSRange lastQuoteRange = [changedString rangeOfString:@"\"" options:NSBackwardsSearch];
    
    if ( (firstQuoteRange.location != NSNotFound) && (lastQuoteRange.location != NSNotFound) && (lastQuoteRange.location != firstQuoteRange.location)) {
        changedString = [changedString substringWithRange:NSMakeRange(firstQuoteRange.location + 1, lastQuoteRange.location - 1)];
        
        //NSLog(@"first: %d last: %d", firstQuoteRange.location, lastQuoteRange.location);
        //NSLog(@"Before: %@ After: %@", self, changedString);
    }
    
    return changedString;
}

- (NSString *)convertOrthography
{
    NSString *changedString = [self copy];
    NSString *orthography = [[NSUserDefaults standardUserDefaults] objectForKey:@"orthography"];
    
    if ([orthography isEqualToString:PEHOEJI]) {
        return changedString;
        
    } else if ([orthography isEqualToString:IPA]) {
        return changedString;
        
    } else if ([orthography isEqualToString:REVISED_TLPA]) {
        return changedString;
        
    } else if ([orthography isEqualToString:BP]) {
        return changedString;
        
    } else if ([orthography isEqualToString:MLT]) {
        return changedString;
        
    } else if ([orthography isEqualToString:DT]) {
        return changedString;
        
    } else if ([orthography isEqualToString:TAIWANESE_KANA]) {
        return changedString;
        
    } else if ([orthography isEqualToString:EXTENDED_BOPOMOFO]) {
        return changedString;
        
    } else if ([orthography isEqualToString:TAILO]) {
        return changedString;
    } else {
        return changedString;
    }
    
    return changedString;
}

- (NSString *)replaceSpecialPehoejiCharacters {
    NSString *changedString = [self copy];
    
    //[changedString precomposedStringWithCanonicalMapping];
    [changedString decomposedStringWithCanonicalMapping];
    
    NSDictionary *specialCharacters = @{@"\u0301": @"2",
                                        @"\u0300": @"3",
                                        @"\u0302": @"5",
                                        @"\u0304": @"7",
                                        @"\u030D": @"8",
                                        @"\u0358": @"u",
                                        @"ⁿ":  @"nn"};
    
    //    NSArray *charArray = @[@"\u00C1", @"\u00E1", @"\u00C0", @"\u00E0", @"\u00C2", @"\u00E2", @"\u0100", @"\u0101", @"\u00C9", @"\u00E9", @"\u00C8", @"\u00E8", @"\u00CA", @"\u00EA", @"\u0102", @"\u0103", @"\u00CD", @"\u00ED", @"\u00CC", @"\u00EC", @"\u00CE", @"\u00EE", @"\u012A", @"\u012B", @"\u1E3E", @"\u1E3F", @"\u0143", @"\u0144", @"\u01F8", @"\u01F9", @"\u00D3", @"\u00F3", @"\u00D2", @"\u00F2", @"\u00D4", @"\u00F4", @"\u014C", @"\u014D", @"\u00DA", @"\u00FA", @"\u00D9", @"\u00F9", @"\u00DB", @"\u00FB", @"\u016A", @"\u016B"];
    //    NSMutableArray *cleanCharArray = [@[] mutableCopy];
    
    // replace all special characters
    for (NSString *key in [specialCharacters allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:specialCharacters[key]];
    }
    
    return changedString;
}

- (NSString *)pushNumbersToEndOfSyllable
{
    NSString *changedString = [self copy];
    NSMutableString *newString = [@"" mutableCopy];

    //NSLog(@"start: %@", changedString);
    //NSLog(@" ");
    
    NSCharacterSet *toneNumbers = [NSCharacterSet characterSetWithCharactersInString:@"1234578"];
    NSCharacterSet *letterCharacters = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    NSMutableCharacterSet *lettersAndTones = [toneNumbers mutableCopy];
    [lettersAndTones formUnionWithCharacterSet:letterCharacters];
    
    NSScanner *scanner = [NSScanner scannerWithString:changedString];
    [scanner setCharactersToBeSkipped:nil];
    
    while (![scanner isAtEnd]) {
        NSString *upToNextToneNumber = nil;
        NSString *currentToneNumber = nil;
        NSString *endOfSyllable = nil;
        
        // scan up to the next tone number
        [scanner scanUpToCharactersFromSet:toneNumbers intoString:&upToNextToneNumber];
        if (upToNextToneNumber) {
            [newString appendString:upToNextToneNumber];
        }
        //NSLog(@"upToNextToneNumber:\t%@\t\t'%@'", newString, upToNextToneNumber);
        
        // identify the next tone number.
        [scanner scanCharactersFromSet:toneNumbers intoString:&currentToneNumber];
        //NSLog(@"currentToneNumber:\t\t%@\t\t'%@'", newString, currentToneNumber);
        
        // scan to the end of the current syllable
        [scanner scanCharactersFromSet:letterCharacters intoString:&endOfSyllable];
        if (endOfSyllable) {
            [newString appendString:endOfSyllable];
        }
        //NSLog(@"endOfSyllable:\t\t\t%@\t\t'%@'", newString, endOfSyllable);
        
        // push the tone number to the end of the syllable
        if (currentToneNumber) {
            [newString appendString:currentToneNumber];
        }
        //NSLog(@"currentToneNumber:\t\t%@", newString);
        //NSLog(@" ");
    }
    
    return newString;
    
}

- (NSString *)insertTones1And4
{
    NSString *changedString = [self copy];
    NSMutableString *filteredString = [@"" mutableCopy];
    
    //NSLog(@"start: %@", changedString);
    //NSLog(@" ");
    
    NSCharacterSet *toneNumbers = [NSCharacterSet characterSetWithCharactersInString:@"1234578"];
    NSCharacterSet *letterCharacters = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    NSMutableCharacterSet *lettersAndTones = [toneNumbers mutableCopy];
    [lettersAndTones formUnionWithCharacterSet:letterCharacters];
    
    NSScanner *scanner = [NSScanner scannerWithString:changedString];
    [scanner setCharactersToBeSkipped:nil];
    
    while (![scanner isAtEnd]) {
        NSString *upEndOfSyllable = nil;
        NSString *upToNextLettersAndTones = nil;
        
        // scan to the end of the current syllable
        [scanner scanCharactersFromSet:lettersAndTones intoString:&upEndOfSyllable];
        if (upEndOfSyllable) {
            [filteredString appendString:upEndOfSyllable];
        }
        
        NSString *s = [changedString substringWithRange:NSMakeRange([scanner scanLocation]-1, 1)];
        //NSLog(@"'%@'", s);
        if ([s rangeOfCharacterFromSet:toneNumbers].location == NSNotFound) {
            // if the end of the string is not a number
            if ([s rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"ptkh"]].location == NSNotFound) {
                // if the end of the string is not p,t,k,h, therefore tone 1
                [filteredString appendString:@"1"];
            } else {
                // tone 4
                [filteredString appendString:@"4"];
            }
        }
        
        // scan past any delimiter character
        [scanner scanUpToCharactersFromSet:lettersAndTones intoString:&upToNextLettersAndTones];
        if (upToNextLettersAndTones) {
            [filteredString appendString:upToNextLettersAndTones];
        }
        
    }
    
    //NSLog(@"new: %@", filteredString);
    
    return filteredString;
    
}

- (NSString *)convertPehoejiToNumberedPehoeji
{
    NSString *string = [self copy];
    
    string = [string replaceSpecialPehoejiCharacters];
    string = [string pushNumbersToEndOfSyllable];
    string = [string insertTones1And4];
    
    return string;
}


- (NSString *)convertPehoejiToNumberedPehoeji2
{
    NSString *changedString = [self copy];
    
    //[changedString precomposedStringWithCanonicalMapping];
    [changedString decomposedStringWithCanonicalMapping];
    
    NSDictionary *specialCharacters = @{@"\u0301": @"2",
                                        @"\u0300": @"3",
                                        @"\u0302": @"5",
                                        @"\u0304": @"7",
                                        @"\u030D": @"8",
                                        @"\u0358": @"u",
                                             @"ⁿ":  @"nn"};
    
//    NSArray *charArray = @[@"\u00C1", @"\u00E1", @"\u00C0", @"\u00E0", @"\u00C2", @"\u00E2", @"\u0100", @"\u0101", @"\u00C9", @"\u00E9", @"\u00C8", @"\u00E8", @"\u00CA", @"\u00EA", @"\u0102", @"\u0103", @"\u00CD", @"\u00ED", @"\u00CC", @"\u00EC", @"\u00CE", @"\u00EE", @"\u012A", @"\u012B", @"\u1E3E", @"\u1E3F", @"\u0143", @"\u0144", @"\u01F8", @"\u01F9", @"\u00D3", @"\u00F3", @"\u00D2", @"\u00F2", @"\u00D4", @"\u00F4", @"\u014C", @"\u014D", @"\u00DA", @"\u00FA", @"\u00D9", @"\u00F9", @"\u00DB", @"\u00FB", @"\u016A", @"\u016B"];
//    NSMutableArray *cleanCharArray = [@[] mutableCopy];
    
    // replace all special characters
    for (NSString *key in [specialCharacters allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:specialCharacters[key]];
    }
    
    
    
    
    NSLog(@"start: %@", changedString);
    NSLog(@" ");

    NSCharacterSet *toneNumbers = [NSCharacterSet characterSetWithCharactersInString:@"23578"];
    //NSCharacterSet *endOfSyllableCharacters = [NSCharacterSet characterSetWithCharactersInString:@" -"];
    NSCharacterSet *letterCharacters = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    
    NSMutableCharacterSet *lettersAndTones = [toneNumbers mutableCopy];
    [lettersAndTones formUnionWithCharacterSet:letterCharacters];
    
    NSMutableString *newString = [@"" mutableCopy];

    NSScanner *scanner = [NSScanner scannerWithString:changedString];
    [scanner setCharactersToBeSkipped:nil];
    
    while (![scanner isAtEnd]) {
        NSString *upToNextToneNumber = nil;
        NSString *currentToneNumber = nil;
        NSString *endOfSyllable = nil;
        
        // scan up to the next tone number
        [scanner scanUpToCharactersFromSet:toneNumbers intoString:&upToNextToneNumber];
        if (upToNextToneNumber) {
            [newString appendString:upToNextToneNumber];
        }
        //NSLog(@"upToNextToneNumber:\t%@\t\t'%@'", newString, upToNextToneNumber);
        
        // identify the next tone number.
        [scanner scanCharactersFromSet:toneNumbers intoString:&currentToneNumber];
        //NSLog(@"currentToneNumber:\t\t%@\t\t'%@'", newString, currentToneNumber);
        
        // scan to the end of the current syllable
        [scanner scanCharactersFromSet:letterCharacters intoString:&endOfSyllable];
        if (endOfSyllable) {
            [newString appendString:endOfSyllable];
        }
        //NSLog(@"endOfSyllable:\t\t\t%@\t\t'%@'", newString, endOfSyllable);
        
        // push the tone number to the end of the syllable
        if (currentToneNumber) {
            [newString appendString:currentToneNumber];
        }
        //NSLog(@"currentToneNumber:\t\t%@", newString);
        //NSLog(@" ");
    }
    
    scanner = [NSScanner scannerWithString:newString];
    [scanner setCharactersToBeSkipped:nil];
    
    NSMutableString *filteredString = [@"" mutableCopy];
    while (![scanner isAtEnd]) {
        NSString *upEndOfSyllable = nil;
        NSString *upToNextLettersAndTones = nil;
        
        // scan to the end of the current syllable
        [scanner scanCharactersFromSet:lettersAndTones intoString:&upEndOfSyllable];
        if (upEndOfSyllable) {
            [filteredString appendString:upEndOfSyllable];
        }
        
        NSString *s = [newString substringWithRange:NSMakeRange([scanner scanLocation]-1, 1)];
        NSLog(@"'%@'", s);
        if ([s rangeOfCharacterFromSet:toneNumbers].location == NSNotFound) {
            // if the end of the string is not a number
            if ([s rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"ptkh"]].location == NSNotFound) {
                // if the end of the string is not p,t,k,h, therefore tone 1
                [filteredString appendString:@"1"];
            } else {
                // tone 4
                [filteredString appendString:@"4"];
            }
        }
        
        // scan past any delimiter character
        [scanner scanUpToCharactersFromSet:lettersAndTones intoString:&upToNextLettersAndTones];
        if (upToNextLettersAndTones) {
            [filteredString appendString:upToNextLettersAndTones];
        }
        
    }
    
    NSLog(@"new: %@", filteredString);
    
    return newString;

}


@end
