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

- (NSString *)convertNumberedPehoejiToDT
{
    NSString *changedString = [self copy];
    
    // save multicharacter symbols that overlap with other symbols. This is a very inefficient version of tokenization.

    NSDictionary *pehoejiSymbols4 = @{
                                      @"chhi": @"_CHHI",
                                      @"iann": @"_IANN",
                                      @"oan": @"_OANN"
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
                                      @"onn": @"_ONN"
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
                                      @"nn": @"_NN"
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

    NSLog(@"%@", changedString);
    
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
    
    NSDictionary *DTSymbols4 = @{
                                 @"_CHHI": @"ci",
                                 @"_IANN": @"iaⁿ",
                                 @"_OANN": @"uaⁿ"
                                 };
    
    NSDictionary *DTSymbols3 = @{
                                 @"_IAN": @"ian",
                                 @"_ENG": @"ing",
                                 @"_ONG": @"ong",
                                 @"_OAI": @"uai",
                                 @"_OAN": @"uan",
                                 @"_NNG": @"nng",
                                 @"_CHI": @"zi",
                                 @"_CHH": @"c",
                                 @"_ONN": @"oⁿ"
                                 };
    
    NSDictionary *DTSymbols2 = @{
                                 @"_AP": @"ap",
                                 @"_AT": @"at",
                                 @"_AK": @"ak",
                                 @"_AH": @"ah",
                                 @"_OU": @"o",
                                 @"_OK": @"ok",
                                 @"_EK": @"ik",
                                 @"_AI": @"ai",
                                 @"_AU": @"au",
                                 @"_AM": @"am",
                                 @"_OM": @"om",
                                 @"_NG": @"ng",
                                 @"_OA": @"ua",
                                 @"_OE": @"ue",
                                 @"_IU": @"iu",
                                 @"_PH": @"p",
                                 @"_TH": @"t",
                                 @"_KH": @"k",
                                 @"_JI": @"r",
                                 @"_SI": @"si",
                                 @"_CH": @"z",
                                 @"_NN": @"ⁿ"
                                 };
    
    NSDictionary *DTSymbols1 = @{
                                 @"_A": @"a",
                                 @"_O": @"or",
                                 @"_E": @"e",
                                 @"_I": @"i",
                                 @"_M": @"m",
                                 @"_U": @"u",
                                 @"_P": @"b",
                                 @"_B": @"bh",
                                 @"_T": @"d",
                                 @"_N": @"n",
                                 @"_L": @"l",
                                 @"_K": @"g",
                                 @"_G": @"gh",
                                 @"_H": @"h",
                                 @"_J": @"r",
                                 @"_S": @"s"
                                 };
    
    NSLog(@"%@", changedString);
    
    // 4 character symbols
    for (NSString *key in [DTSymbols4 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:DTSymbols4[key]];
    }
    // 3 character symbols
    for (NSString *key in [DTSymbols3 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:DTSymbols3[key]];
    }
    // 2 character symbols
    for (NSString *key in [DTSymbols2 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:DTSymbols2[key]];
    }
    // 1 character symbols
    for (NSString *key in [DTSymbols1 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:DTSymbols1[key]];
    }
    
    NSLog(@"%@", changedString);

    
    changedString = [changedString moveToneNumbersToDT];
    
    NSLog(@"%@", changedString);
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"1" withString:@""];       //
    changedString = [changedString stringByReplacingOccurrencesOfString:@"2" withString:@"\u0300"]; //  ̀
    changedString = [changedString stringByReplacingOccurrencesOfString:@"3" withString:@"\u0302"]; //  ̂
    changedString = [changedString stringByReplacingOccurrencesOfString:@"4" withString:@"\u0304"]; //  ̄
    changedString = [changedString stringByReplacingOccurrencesOfString:@"5" withString:@"\u0306"]; //  ̆
    changedString = [changedString stringByReplacingOccurrencesOfString:@"6" withString:@"\u0308"]; //  ̈
    changedString = [changedString stringByReplacingOccurrencesOfString:@"7" withString:@"\u0304"]; //  ̄
    changedString = [changedString stringByReplacingOccurrencesOfString:@"8" withString:@""];       //
    changedString = [changedString stringByReplacingOccurrencesOfString:@"9" withString:@"\u0301"]; //  ́
    //changedString = [changedString stringByReplacingOccurrencesOfString:@"10" withString:@"\u02da"];// ˚
    
    NSLog(@"%@", changedString);
    NSLog(@" ");
    return changedString;
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

- (NSString *)moveToneNumbersToDT
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

- (NSString *)convertPehoejiToNumberedPehoeji
{
    NSString *string = [self copy];
    
    string = [string replaceSpecialPehoejiCharacters];
    string = [string pushNumbersToEndOfSyllable];
    string = [string insertTones1And4];
    
    return string;
}


@end
