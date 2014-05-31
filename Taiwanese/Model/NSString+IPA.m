//
//  NSString+IPA.m
//  Taiwanese
//
//  Created by Jason McDowell on 5/22/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "NSString+IPA.h"
#import "NSString+TaiwaneseHelpers.h"

@implementation NSString (InternationalPhoneticAlphabet)

- (NSString *)convertNumberedPehoejiToIPA
{
    NSString *changedString = [self copy];
    
    changedString = [changedString convertNumberedPehoejiToTokens];
    
    NSDictionary *IPASymbols4 = @{
                                     @"_AINN": @"aĩ",
                                     @"_AUNN": @"aũ",
                                     @"_IANN": @"iã",
                                     @"_INNN": @"iñ",
                                     @"_OANN": @"uã",
                                     @"_CHHI": @"tɕʰi"
                                     };
    
    NSDictionary *IPASymbols3 = @{
                                     @"_ANN": @"ã",
                                     @"_CHI": @"tɕi",
                                     @"_CHH": @"tsʰ",
                                     @"_ENG": @"iŋ",
                                     @"_ENN": @"ẽ",
                                     @"_IAN": @"ɪɛn",
                                     @"_INN": @"ĩ",
                                     @"_ONG": @"ɔŋ",
                                     @"_ONN": @"ɔ̃",
                                     @"_OAI": @"uai",
                                     @"_OAN": @"uan",
                                     @"_NNG": @"nŋ̍",
                                     @"_UNN": @"ũ"
                                     };
    
    NSDictionary *IPASymbols2 = @{
                                     @"_AP": @"ap",
                                     @"_AT": @"at",
                                     @"_AK": @"ak",
                                     @"_AH": @"aʔ",
                                     @"_OU": @"ɔ",
                                     @"_OK": @"ɔk",
                                     @"_EK": @"ɪk",
                                     @"_AI": @"ai",
                                     @"_AU": @"au",
                                     @"_AM": @"am",
                                     @"_OM": @"ɔm",
                                     @"_NG": @"ŋ̍",
                                     @"_OA": @"ua",
                                     @"_OE": @"ue",
                                     @"_PH": @"pʰ",
                                     @"_TH": @"tʰ",
                                     @"_KH": @"kʰ",
                                     @"_JI": @"ʑi",
                                     @"_SI": @"ɕi",
                                     @"_IU": @"iu",
                                     @"_CH": @"ts"
                                     };
    
    NSDictionary *IPASymbols1 = @{
                                     @"_A": @"a",
                                     @"_O": @"o",
                                     @"_E": @"e",
                                     @"_I": @"i",
                                     @"_U": @"u",
                                     @"_M": @"m",
                                     @"_P": @"p",
                                     @"_B": @"b",
                                     @"_T": @"t",
                                     @"_N": @"n",
                                     @"_L": @"l",
                                     @"_K": @"k",
                                     @"_G": @"g",
                                     @"_H": @"h",
                                     @"_J": @"dz",
                                     @"_S": @"s"
                                     };
    
    // Replace tokens with converted symbols
    
    // 4 character symbols
    for (NSString *key in [IPASymbols4 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:IPASymbols4[key]];
    }
    // 3 character symbols
    for (NSString *key in [IPASymbols3 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:IPASymbols3[key]];
    }
    // 2 character symbols
    for (NSString *key in [IPASymbols2 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:IPASymbols2[key]];
    }
    // 1 character symbols
    for (NSString *key in [IPASymbols1 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:IPASymbols1[key]];
    }
    
    //NSLog(@"%@", changedString);
    
    //changedString = [changedString moveToneNumbersToIPA];
    
    //NSLog(@"%@", changedString);
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"1" withString:@"˥"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"2" withString:@"˥˧"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"3" withString:@"˨˩"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"4" withString:@"˩"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"5" withString:@"˧˥"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"6" withString:@"˥˧"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"7" withString:@"˧"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"8" withString:@"˥"];
    
    //NSLog(@"%@", changedString);
    //NSLog(@" ");
    
    return changedString;
}

- (NSString *)convertIPAToNumberedPehoeji
{
    NSString *changedString = [self copy];
    
    // change diacritics to numbers
    // move numbers
    
    // save multicharacter symbols that overlap with other symbols. This is a very inefficient version of tokenization.
    
    NSDictionary *IPASymbols4 = @{
                                  @"tɕʰi": @"_CHHI"
                                  };
    
    NSDictionary *IPASymbols3 = @{
                                  @"tsʰ": @"_CHH",
                                  @"tɕi": @"_CHI"
                                  };
    
    NSDictionary *IPASymbols2 = @{
                                     @"ap": @"_AP",
                                     @"at": @"_AT",
                                     @"ak": @"_AK",
                                     @"aʔ": @"_AH",
                                     @"ɔk": @"_OK",
                                     @"ɪk": @"_EK",
                                     @"ua": @"_OA",
                                     @"ue": @"_OE",
                                     @"iã": @"_IANN",
                                     @"ɪɛn": @"_IAN",
                                     @"iŋ": @"_ENG",
                                     @"uã": @"_OANN",
                                     @"uai": @"_OAI",
                                     @"uan": @"_OAN",
                                     @"nŋ̍": @"_NNG",
                                     @"iu": @"_IU",
                                     @"aĩ": @"_AINN",
                                     @"aũ": @"_AUNN",
                                     @"ɔŋ": @"_ONG",
                                     @"iñ": @"_INNN",
                                     @"ʑi": @"_JI",
                                     @"ai": @"_AI",
                                     @"au": @"_AU",
                                     @"am": @"_AM",
                                     @"ɔm": @"_OM",
                                     @"ts": @"_CH",
                                     @"ɕi": @"_SI",
                                     @"pʰ": @"_PH",
                                     @"tʰ": @"_TH",
                                     @"kʰ": @"_KH",
                                     @"dz": @"_J"
                                     };
    
    NSDictionary *IPASymbols1 = @{
                                     @"a": @"_A",
                                     @"e": @"_E",
                                     @"i": @"_I",
                                     @"o": @"_O",
                                     @"n": @"_N",
                                     @"m": @"_M",
                                     @"u": @"_U",
                                     @"p": @"_P",
                                     @"t": @"_T",
                                     @"l": @"_L",
                                     @"k": @"_K",
                                     @"h": @"_H",
                                     @"s": @"_S",
                                     @"g": @"_G",
                                     @"b": @"_B",
                                     @"ɔ": @"_OU",
                                     @"ŋ̍": @"_NG",
                                     @"ã": @"_ANN",
                                     @"ɔ̃": @"_ONN",
                                     @"ũ": @"_UNN",
                                     @"ẽ": @"_ENN",
                                     @"ĩ": @"_INN"
                                     };
    
    changedString = [changedString replaceSpecialIPACharacters];
    changedString = [changedString pushNumbersToEndOfSyllable];
    
    // Tokenize string
    // 4 character symbols
    for (NSString *key in [IPASymbols4 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:IPASymbols4[key]];
    }
    
    // 3 character symbols
    for (NSString *key in [IPASymbols3 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:IPASymbols3[key]];
    }
    
    // 2 character symbols
    for (NSString *key in [IPASymbols2 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:IPASymbols2[key]];
    }
    // 1 character symbols
    for (NSString *key in [IPASymbols1 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:IPASymbols1[key]];
    }
    
    changedString = [changedString convertTokensToNumberedPehoeji];
    
    //NSLog(@"%@", changedString);
    //NSLog(@" ");
    return changedString;
}

- (NSString *)moveToneNumbersToIPA
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
                
                NSRange range = [temp rangeOfString:@"ㄚㄨ"];
                //NSLog(@"Temp: %@", temp);
                
                if (range.location != NSNotFound) {
                    // found a main vowel, so insert tone number after this vowel
                    [temp insertString:currentToneNumber atIndex:range.location + 1];
                    //NSLog(@"Found au");
                    //NSLog(@"Temp: %@", temp);
                } else {
                    // insert the tone number after the main vowel, with priority o,a,e,u,i,n,m
                    NSArray *vowels = @[@"o", @"a", @"e", @"u", @"i", @"n", @"m"];
                    
                    for (NSString *vowel in vowels) {
                        NSRange range;
                        range = [temp rangeOfString:vowel];
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

- (NSString *)replaceSpecialIPACharacters {
    NSString *changedString = [self copy];
    
    //[changedString precomposedStringWithCanonicalMapping];
    [changedString decomposedStringWithCanonicalMapping];
    
    changedString = [changedString stringByReplacingOccurrencesOfString:@"˥˧" withString:@"2"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"˨˩" withString:@"3"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"˧˥" withString:@"5"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"˥" withString:@"1"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"˩" withString:@"4"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"˧" withString:@"7"];
    changedString = [changedString stringByReplacingOccurrencesOfString:@"˥" withString:@"8"];
    
    return changedString;
}


@end
