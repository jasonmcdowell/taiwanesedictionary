//
//  NSString+IPA.m
//  Taiwanese
//
//  Created by Jason McDowell on 5/22/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "NSString+IPA.h"
#import "NSString+TaiwaneseHelpers.h"

@implementation NSString (IPA)

- (NSString *)convertNumberedPehoejiToDT
{
    NSString *changedString = [self copy];
    
    changedString = [changedString convertNumberedPehoejiToTokens];
    
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
                                 @"_JI": @"ri",
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
    
    
    
    
    // Replace tokens with converted symbols
    
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
    
    //NSLog(@"%@", changedString);
    
    changedString = [changedString moveToneNumbersToDT];
    
    //NSLog(@"%@", changedString);
    
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
    
    //NSLog(@"%@", changedString);
    //NSLog(@" ");
    return changedString;
}

- (NSString *)convertDTToNumberedPehoeji
{
    NSString *changedString = [self copy];
    
    // change diacritics to numbers
    // move numbers
    
    
    // save multicharacter symbols that overlap with other symbols. This is a very inefficient version of tokenization.
    
    NSDictionary *DTSymbols4 = @{
                                 @"iann": @"_IANN",
                                 @"uann": @"_OANN"
                                 };
    
    NSDictionary *DTSymbols3 = @{
                                 @"ian": @"_IAN",
                                 @"ing": @"_ENG",
                                 @"ong": @"_ONG",
                                 @"uai": @"_OAI",
                                 @"uan": @"_OAN",
                                 @"nng": @"_NNG",
                                 @"onn": @"_ONN"
                                 };
    
    NSDictionary *DTSymbols2 = @{
                                 @"ap": @"_AP",
                                 @"at": @"_AT",
                                 @"ak": @"_AK",
                                 @"ah": @"_AH",
                                 @"ok": @"_OK",
                                 @"ik": @"_EK",
                                 @"ai": @"_AI",
                                 @"au": @"_AU",
                                 @"am": @"_AM",
                                 @"om": @"_OM",
                                 @"ng": @"_NG",
                                 @"ua": @"_OA",
                                 @"ue": @"_OE",
                                 @"iu": @"_IU",
                                 @"zi": @"_CHI",
                                 @"si": @"_SI",
                                 @"gh": @"_G",
                                 @"bh": @"_B",
                                 @"or": @"_O",
                                 @"ci": @"_CHHI",
                                 @"ri": @"_JI",
                                 @"nn": @"_NN"
                                 };
    
    NSDictionary *DTSymbols1 = @{
                                 @"a": @"_A",
                                 @"e": @"_E",
                                 @"i": @"_I",
                                 @"m": @"_M",
                                 @"u": @"_U",
                                 @"b": @"_P",
                                 @"d": @"_T",
                                 @"n": @"_N",
                                 @"l": @"_L",
                                 @"g": @"_K",
                                 @"h": @"_H",
                                 @"r": @"_J",
                                 @"s": @"_S",
                                 @"c": @"_CHH",
                                 @"p": @"_PH",
                                 @"t": @"_TH",
                                 @"k": @"_KH",
                                 @"o": @"_OU",
                                 @"z": @"_CH"
                                 };
    
    changedString = [changedString replaceSpecialDTCharacters];
    changedString = [changedString pushNumbersToEndOfSyllable];
    
    // Tokenize string
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
    
    changedString = [changedString convertTokensToNumberedPehoeji];
    
    //NSLog(@"%@", changedString);
    //NSLog(@" ");
    return changedString;
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

- (NSString *)replaceSpecialDTCharacters {
    NSString *changedString = [self copy];
    
    //[changedString precomposedStringWithCanonicalMapping];
    [changedString decomposedStringWithCanonicalMapping];
    
    NSDictionary *specialCharacters = @{@"\u0300": @"2",
                                        @"\u0302": @"3",
                                        @"t\u0304": @"t4",
                                        @"k\u0304": @"k4",
                                        @"p\u0304": @"p4",
                                        @"h\u0304": @"h4",
                                        @"\u0306": @"5",
                                        @"\u0304": @"7",
                                        @"ⁿ":  @"nn"};
    
    for (NSString *key in [specialCharacters allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:specialCharacters[key]];
    }
    
    return changedString;
}


@end
