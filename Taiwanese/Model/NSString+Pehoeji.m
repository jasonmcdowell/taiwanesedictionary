//
//  NSString+Pehoeji.m
//  Taiwanese
//
//  Created by Jason McDowell on 5/21/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "NSString+Pehoeji.h"
#import "NSString+TaiwaneseHelpers.h"

@implementation NSString (Pehoeji)

- (NSString *)convertNumberedPehoejiToPehoeji
{
    NSString *changedString = [self copy];
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ou" withString:@"o\u0358"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ng" withString:@"NG"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"nn" withString:@"ⁿ"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"NG" withString:@"ng"];
    
    changedString = [changedString moveToneNumbersToPehoeji];
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"1" withString:@""];       //
    changedString = [changedString stringByReplacingOccurrencesOfString:@"2" withString:@"\u0301"]; //  ́
    changedString = [changedString stringByReplacingOccurrencesOfString:@"3" withString:@"\u0300"]; //  ̀
    changedString = [changedString stringByReplacingOccurrencesOfString:@"4" withString:@""];       // p,t,k,h
    changedString = [changedString stringByReplacingOccurrencesOfString:@"5" withString:@"\u0302"]; //  ̂
    changedString = [changedString stringByReplacingOccurrencesOfString:@"7" withString:@"\u0304"]; //  ̄
    changedString = [changedString stringByReplacingOccurrencesOfString:@"8" withString:@"\u030D"]; //  ̍ p,t,k,h
    
    //NSLog(@"%@",changedString);
    return changedString;
}

- (NSString *)convertPehoejiToNumberedPehoeji
{
    NSString *string = [self copy];
    
    string = [string replaceSpecialPehoejiCharacters];
    string = [string pushNumbersToEndOfSyllable];
    //string = [string insertTones1And4];
    
    return string;
}

- (NSString *)moveToneNumbersToPehoeji
{
    NSString *changedString = [self copy];
    NSMutableString *newString = [@"" mutableCopy];
    
    //NSLog(@"start: %@", changedString);
    //NSLog(@" ");
    
    NSCharacterSet *toneNumbers = [NSCharacterSet characterSetWithCharactersInString:@"1234578"];
    NSCharacterSet *letterCharacters = [NSCharacterSet characterSetWithCharactersInString:@":abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    NSMutableCharacterSet *lettersAndTones = [toneNumbers mutableCopy];
    [lettersAndTones formUnionWithCharacterSet:letterCharacters];
    
    NSScanner *scanner = [NSScanner scannerWithString:changedString];
    [scanner setCharactersToBeSkipped:nil];
    
    while (![scanner isAtEnd]) {
        NSString *upToNextToneNumber = nil;
        NSString *currentToneNumber = nil;
        NSMutableString *temp;
        
        // scan up to the next tone number
        [scanner scanUpToCharactersFromSet:toneNumbers intoString:&upToNextToneNumber];
        temp = [NSMutableString stringWithString:upToNextToneNumber];
        //NSLog(@"upToNextToneNumber:\t%@\t\t'%@'", newString, upToNextToneNumber);
        
        // identify the next tone number.
        [scanner scanCharactersFromSet:toneNumbers intoString:&currentToneNumber];
        //NSLog(@"currentToneNumber:\t\t%@\t\t'%@'", newString, currentToneNumber);
        
        // we should be at the end of the syllable.
        
        if (temp) {
            if (currentToneNumber) {
                // insert the tone number after the main vowel, with priority o,a,e,u,i,n,m
                NSArray *vowels = @[@"o", @"a", @"e", @"u", @"i", @"n", @"m"];
                
                for (NSString *vowel in vowels) {
                    NSRange range;
                    if ([vowel isEqualToString:@"n"]) {
                        range = [temp rangeOfString:vowel options:NSBackwardsSearch];
                    } else {
                        range = [temp rangeOfString:vowel];
                    }
                    if (range.location != NSNotFound) {
                        // found a main vowel, so insert tone number after this vowel
                        [temp insertString:currentToneNumber atIndex:range.location + 1];
                        break;
                    } else {
                        // check for other vowels
                    }
                }
            }
            [newString appendString:temp];
        }
        
        //NSLog(@"endOfSyllable:\t\t\t%@\t\t'%@'", newString, endOfSyllable);
        
        // push the tone number to the end of the syllable
        
        //NSLog(@"currentToneNumber:\t\t%@", newString);
        //NSLog(@" ");
    }
    
    return newString;
    
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


@end



