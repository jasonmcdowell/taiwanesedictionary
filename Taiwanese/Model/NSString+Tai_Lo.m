//
//  NSString+Tai_Lo.m
//  Taiwanese
//
//  Created by Jason McDowell on 5/21/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "NSString+Tai_Lo.h"
#import "NSString+TaiwaneseHelpers.h"

@implementation NSString (Tai_Lo)

- (NSString *)moveToneNumbersToTaiLo
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
                
                NSRange range = [temp rangeOfString:@"au"];
                //NSLog(@"Temp: %@", temp);
                
                if (range.location != NSNotFound) {
                    // found a main vowel, so insert tone number after this vowel
                    [temp insertString:currentToneNumber atIndex:range.location + 1];
                    //NSLog(@"Found au");
                    //NSLog(@"Temp: %@", temp);
                } else {
                    // insert the tone number after the main vowel, with priority o,a,e,u,i,n,m
                    NSArray *vowels = @[@"o", @"u", @"a", @"e", @"i", @"n", @"m"];
                    
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
                        }
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

- (NSString *)replaceSpecialTaiLoCharacters {
    NSString *changedString = [self copy];
    
    //[changedString precomposedStringWithCanonicalMapping];
    [changedString decomposedStringWithCanonicalMapping];
    
    NSDictionary *specialCharacters = @{@"\u0301": @"2",
                                        @"\u0300": @"3",
                                        @"\u0302": @"5",
                                        @"\u0304": @"7",
                                        @"\u030D": @"8"};
    
    // replace all special characters
    for (NSString *key in [specialCharacters allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:specialCharacters[key]];
    }
    
    return changedString;
}

- (NSString *)convertNumberedPehoejiToTaiLo
{
    NSString *changedString = [self copy];
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ek" withString:@"ik"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ou" withString:@"oo"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"oa" withString:@"ua"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"oe" withString:@"ue"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"eng" withString:@"ing"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ch" withString:@"ts"];
    
    changedString = [changedString moveToneNumbersToTaiLo];
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"1" withString:@""];       //
    changedString = [changedString stringByReplacingOccurrencesOfString:@"2" withString:@"\u0301"]; //  ́
    changedString = [changedString stringByReplacingOccurrencesOfString:@"3" withString:@"\u0300"]; //  ̀
    changedString = [changedString stringByReplacingOccurrencesOfString:@"4" withString:@""];       // p,t,k,h
    changedString = [changedString stringByReplacingOccurrencesOfString:@"5" withString:@"\u0302"]; //  ̂
    changedString = [changedString stringByReplacingOccurrencesOfString:@"7" withString:@"\u0304"]; //  ̄
    changedString = [changedString stringByReplacingOccurrencesOfString:@"8" withString:@"\u030D"]; //  ̍ p,t,k,h
    
    return changedString;
}

- (NSString *)convertTaiLoToNumberedPehoeji
{
    NSString *changedString = [self copy];
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ⁿ" withString:@"nn"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ik" withString:@"ek"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"oo" withString:@"ou"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ua" withString:@"oa"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ue" withString:@"oe"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ing" withString:@"eng"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"ts" withString:@"ch"];
    
    changedString = [changedString replaceSpecialTaiLoCharacters];
    changedString = [changedString pushNumbersToEndOfSyllable];
    //string = [string insertTones1And4];
    
    return changedString;
}



@end
