//
//  NSString+TaiwaneseHelpers.m
//  Taiwanese
//
//  Created by Jason McDowell on 5/21/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "NSString+TaiwaneseHelpers.h"

@implementation NSString (TaiwaneseHelpers)
- (NSString *)removedDoubledNumbers
{
    NSString *changedString = [self copy];
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"11" withString:@"1"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"22" withString:@"2"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"33" withString:@"3"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"44" withString:@"4"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"55" withString:@"5"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"77" withString:@"7"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"88" withString:@"8"];
    
    //NSLog(@"%@",changedString);
    return changedString;
}

- (NSString *)removeNumbers
{
    NSString * changedString = [self copy];
    
    NSCharacterSet *invalidSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    return [[changedString componentsSeparatedByCharactersInSet:invalidSet] componentsJoinedByString:@""];
}

- (NSString *)remove1and4
{
    NSString * changedString = [self copy];
    
    NSCharacterSet *invalidSet = [NSCharacterSet characterSetWithCharactersInString:@"14"];
    return [[changedString componentsSeparatedByCharactersInSet:invalidSet] componentsJoinedByString:@""];
}

- (BOOL)containsNumbers
{
    NSString * changedString = [self copy];
    
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    return [changedString rangeOfCharacterFromSet:numbers].location != NSNotFound;
}

- (BOOL)containsDiacritics
{
    NSString * changedString = [self copy];
    
    changedString = [changedString decomposedStringWithCanonicalMapping];
    
    //    @"\u0300" //  ̀
    //    @"\u0301" //  ́
    //    @"\u0302" //  ̂
    //    @"\u0304" //  ̄
    //    @"\u0306" //  ̆
    //    @"\u0308" //  ̈
    //    @"\u030D" //  ̍
    //    @"\u0358" //  ͘
    //    @"\u207F" // ⁿ
    
    //                                ̀      ́      ̂      ̄      ̆      ̈      ̍      ͘     ⁿ
    NSString *diacriticString = @"\u0300\u0301\u0302\u0304\u0306\u0308\u030D\u0358\u207F";
    
    NSCharacterSet *diacriticCharacters = [NSCharacterSet characterSetWithCharactersInString:diacriticString];
    
    return [changedString rangeOfCharacterFromSet:diacriticCharacters].location != NSNotFound;
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

- (NSString *)pushNumbersToEndOfSyllable
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
    //[scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@":"]];
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
    NSCharacterSet *letterCharacters = [NSCharacterSet characterSetWithCharactersInString:@":abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
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

- (NSString *) convertNumberedPehoejiToTokens
{
    NSString *changedString = [self copy];
    
    // save multicharacter symbols that overlap with other symbols. This is a very inefficient version of tokenization.
    
    NSDictionary *pehoejiSymbols4 = @{
                                      @"chhi": @"_CHHI",
                                      @"iann": @"_IANN",
                                      @"oann": @"_OANN",
                                      @"ainn": @"_AINN",
                                      @"aunn": @"_AUNN"
                                      };
    
    NSDictionary *pehoejiSymbols3 = @{
                                      @"ian": @"_IAN",
                                      @"eng": @"_ENG",
                                      @"ong": @"_ONG",
                                      @"oai": @"_OAI",
                                      @"oan": @"_OAN",
                                      @"nng": @"_NNG",
                                      @"chi": @"_CHI",
                                      @"chh": @"_CHH",
                                      @"ann": @"_ANN",
                                      @"onn": @"_ONN",
                                      @"unn": @"_UNN",
                                      @"enn": @"_ENN",
                                      @"inn": @"_INN"
                                      };
    
    NSDictionary *pehoejiSymbols2 = @{
                                      @"ap": @"_AP",
                                      @"at": @"_AT",
                                      @"ak": @"_AK",
                                      @"ah": @"_AH",
                                      @"ou": @"_OU",
                                      @"ok": @"_OK",
                                      @"ek": @"_EK",
                                      @"ai": @"_AI",
                                      @"au": @"_AU",
                                      @"am": @"_AM",
                                      @"om": @"_OM",
                                      @"ng": @"_NG",
                                      @"oa": @"_OA",
                                      @"oe": @"_OE",
                                      @"iu": @"_IU",
                                      @"ph": @"_PH",
                                      @"th": @"_TH",
                                      @"kh": @"_KH",
                                      @"ji": @"_JI",
                                      @"si": @"_SI",
                                      @"ch": @"_CH",
                                      };
    
    NSDictionary *pehoejiSymbols1 = @{
                                      @"a": @"_A",
                                      @"o": @"_O",
                                      @"e": @"_E",
                                      @"i": @"_I",
                                      @"m": @"_M",
                                      @"u": @"_U",
                                      @"p": @"_P",
                                      @"b": @"_B",
                                      @"t": @"_T",
                                      @"n": @"_N",
                                      @"l": @"_L",
                                      @"k": @"_K",
                                      @"g": @"_G",
                                      @"h": @"_H",
                                      @"j": @"_J",
                                      @"s": @"_S"
                                      };
    
    // Tokenize string
    
    // 4 character symbols
    for (NSString *key in [pehoejiSymbols4 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:pehoejiSymbols4[key]];
    }
    // 3 character symbols
    for (NSString *key in [pehoejiSymbols3 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:pehoejiSymbols3[key]];
    }
    // 2 character symbols
    for (NSString *key in [pehoejiSymbols2 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:pehoejiSymbols2[key]];
    }
    // 1 character symbols
    for (NSString *key in [pehoejiSymbols1 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:pehoejiSymbols1[key]];
    }
    
    return changedString;
    
}

- (NSString *) convertTokensToNumberedPehoeji
{
    
    NSString *changedString = [self copy];
    
    NSDictionary *pehoejiSymbols4 = @{
                                      @"_CHHI": @"chhi",
                                      @"_IANN": @"iann",
                                      @"_OANN": @"oann",
                                      @"_AINN": @"ainn",
                                      @"_AUNN": @"aunn"
                                      };
    
    NSDictionary *pehoejiSymbols3 = @{
                                      @"_IAN": @"ian",
                                      @"_ENG": @"eng",
                                      @"_ONG": @"ong",
                                      @"_OAI": @"oai",
                                      @"_OAN": @"oan",
                                      @"_NNG": @"nng",
                                      @"_CHI": @"chi",
                                      @"_CHH": @"chh",
                                      @"_ANN": @"ann",
                                      @"_ONN": @"onn",
                                      @"_UNN": @"unn",
                                      @"_ENN": @"enn",
                                      @"_INN": @"inn"
                                      };
    
    NSDictionary *pehoejiSymbols2 = @{
                                      @"_AP": @"ap",
                                      @"_AT": @"at",
                                      @"_AK": @"ak",
                                      @"_AH": @"ah",
                                      @"_OU": @"ou",
                                      @"_OK": @"ok",
                                      @"_EK": @"ek",
                                      @"_AI": @"ai",
                                      @"_AU": @"au",
                                      @"_AM": @"am",
                                      @"_OM": @"om",
                                      @"_NG": @"ng",
                                      @"_OA": @"oa",
                                      @"_OE": @"oe",
                                      @"_IU": @"iu",
                                      @"_PH": @"ph",
                                      @"_TH": @"th",
                                      @"_KH": @"kh",
                                      @"_JI": @"ji",
                                      @"_SI": @"si",
                                      @"_CH": @"ch",
                                      };
    
    NSDictionary *pehoejiSymbols1 = @{
                                      @"_A": @"a",
                                      @"_O": @"o",
                                      @"_E": @"e",
                                      @"_I": @"i",
                                      @"_M": @"m",
                                      @"_U": @"u",
                                      @"_P": @"p",
                                      @"_B": @"b",
                                      @"_T": @"t",
                                      @"_N": @"n",
                                      @"_L": @"l",
                                      @"_K": @"k",
                                      @"_G": @"g",
                                      @"_H": @"h",
                                      @"_J": @"j",
                                      @"_S": @"s"
                                      };
    
    // Replace tokens with converted symbols
    // 4 character symbols
    for (NSString *key in [pehoejiSymbols4 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:pehoejiSymbols4[key]];
    }
    // 3 character symbols
    for (NSString *key in [pehoejiSymbols3 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:pehoejiSymbols3[key]];
    }
    // 2 character symbols
    for (NSString *key in [pehoejiSymbols2 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:pehoejiSymbols2[key]];
    }
    // 1 character symbols
    for (NSString *key in [pehoejiSymbols1 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:pehoejiSymbols1[key]];
    }
    
    return changedString;
}


@end
