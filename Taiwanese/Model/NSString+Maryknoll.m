//
//  NSString+Maryknoll.m
//  Taiwanese
//
//  Created by Jason McDowell on 5/21/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "NSString+Maryknoll.h"
#import "NSString+TaiwaneseHelpers.h"

@implementation NSString (Maryknoll)

// This method converts to a string from the "Source" format to the "Numbered Pehoeji" format
// Source: the format of taiwanese words in Mkdictionary.xls. It has some typos.
// Numbered Pehoeji: more or less as described in the dissertation.
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
    
    changedString = [changedString removeNumbers];
    changedString = [changedString removeSourceSpecialCharacters];
    
    return changedString;
}

- (NSString *)removeSourceSpecialCharacters
{
    NSString * changedString = [self copy];
    
    NSCharacterSet *invalidSet = [NSCharacterSet characterSetWithCharactersInString:@"[] +*"];
    return [[changedString componentsSeparatedByCharactersInSet:invalidSet] componentsJoinedByString:@""];
}

@end
