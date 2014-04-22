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


@end
