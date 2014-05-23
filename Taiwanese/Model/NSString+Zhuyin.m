//
//  NSString+Zhuyin.m
//  Taiwanese
//
//  Created by Jason McDowell on 5/22/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "NSString+Zhuyin.h"
#import "NSString+TaiwaneseHelpers.h"

@implementation NSString (Zhuyin)

- (NSString *)convertNumberedPehoejiToZhuyin
{
    NSString *changedString = [self copy];
    
    changedString = [changedString convertNumberedPehoejiToTokens];
    
    NSDictionary *ZhuyinSymbols4 = @{
                                 @"_AINN": @"ㆮ",
                                 @"_AUNN": @"ㆯ",
                                 @"_IANN": @"ㄧㆩ",
                                 @"_INNN": @"ㆳ",
                                 @"_OANN": @"ㄛㆩ",
                                 @"_CHHI": @"ㄑ"
                                 };
    
    NSDictionary *ZhuyinSymbols3 = @{
                                 @"_ANN": @"ㆧ",
                                 @"_CHI": @"ㄐ",
                                 @"_CHH": @"ㄘ",
                                 @"_ENG": @"ㄧㄥ",
                                 @"_ENN": @"ㆥ",
                                 @"_IAN": @"ㄧㄢ",
                                 @"_INN": @"ㆪ",
                                 @"_ONG": @"ㆲ",
                                 @"_ONN": @"ㆩ",
                                 @"_OAI": @"ㄨㄞ",
                                 @"_OAN": @"ㄨㄢ",
                                 @"_NNG": @"ㄋㆭ",
                                 @"_UNN": @"ㆫ"
                                 };
    
    NSDictionary *ZhuyinSymbols2 = @{
                                 @"_AP": @"ㄚㆴ",
                                 @"_AT": @"ㄚㆵ",
                                 @"_AK": @"ㄚㆶ",
                                 @"_AH": @"ㄚㆷ",
                                 @"_OU": @"ㆦ",
                                 @"_OK": @"ㆦㆶ",
                                 @"_EK": @"ㄧㆶ",
                                 @"_AI": @"ㄞ",
                                 @"_AU": @"ㄠ",
                                 @"_AM": @"ㆰ",
                                 @"_OM": @"ㆱ",
                                 @"_NG": @"ㆭ",
                                 @"_OA": @"ㄨㄚ",
                                 @"_OE": @"ㄨㆤ",
                                 @"_PH": @"ㄆ",
                                 @"_TH": @"ㄊ",
                                 @"_KH": @"ㄎ",
                                 @"_JI": @"ㆢ",
                                 @"_SI": @"ㄒ",
                                 @"_IU": @"ㄧㄨ",
                                 @"_CH": @"ㄗ"
                                 };
    
    NSDictionary *ZhuyinSymbols1 = @{
                                 @"_A": @"ㄚ",
                                 @"_O": @"ㄛ",
                                 @"_E": @"ㆤ",
                                 @"_I": @"ㄧ",
                                 @"_M": @"ㆬ",
                                 @"_U": @"ㄨ",
                                 @"_P": @"ㄅ",
                                 @"_B": @"ㆠ",
                                 @"_T": @"ㄉ",
                                 @"_N": @"ㄋ",
                                 @"_L": @"ㄌ",
                                 @"_K": @"ㄍ",
                                 @"_G": @"ㆣ",
                                 @"_H": @"ㄏ",
                                 @"_J": @"ㆡ",
                                 @"_S": @"ㄙ"
                                 };
    
    
    
    
    // Replace tokens with converted symbols
    
    // 4 character symbols
    for (NSString *key in [ZhuyinSymbols4 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:ZhuyinSymbols4[key]];
    }
    // 3 character symbols
    for (NSString *key in [ZhuyinSymbols3 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:ZhuyinSymbols3[key]];
    }
    // 2 character symbols
    for (NSString *key in [ZhuyinSymbols2 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:ZhuyinSymbols2[key]];
    }
    // 1 character symbols
    for (NSString *key in [ZhuyinSymbols1 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:ZhuyinSymbols1[key]];
    }
    
    //NSLog(@"%@", changedString);
    
    changedString = [changedString moveToneNumbersToZhuyin];
    
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

- (NSString *)convertZhuyinToNumberedPehoeji
{
    NSString *changedString = [self copy];
    
    // change diacritics to numbers
    // move numbers
    
    
    // save multicharacter symbols that overlap with other symbols. This is a very inefficient version of tokenization.
    
    NSDictionary *ZhuyinSymbols2 = @{
                                 @"ㄚㆴ": @"_AP",
                                 @"ㄚㆵ": @"_AT",
                                 @"ㄚㆶ": @"_AK",
                                 @"ㄚㆷ": @"_AH",
                                 @"ㆦㆶ": @"_OK",
                                 @"ㄧㆶ": @"_EK",
                                 @"ㄨㄚ": @"_OA",
                                 @"ㄨㆤ": @"_OE",
                                 @"ㄧㆩ": @"_IANN",
                                 @"ㄧㄢ": @"_IAN",
                                 @"ㄧㄥ": @"_ENG",
                                 @"ㄛㆩ": @"_OANN",
                                 @"ㄨㄞ": @"_OAI",
                                 @"ㄨㄢ": @"_OAN",
                                 @"ㄋㆭ": @"_NNG",
                                 @"ㄧㄨ": @"_IU"
                                 };
    
    NSDictionary *ZhuyinSymbols1 = @{
                                 @"ㄚ": @"_A",
                                 @"ㆤ": @"_E",
                                 @"ㄧ": @"_I",
                                 @"ㆬ": @"_M",
                                 @"ㄨ": @"_U",
                                 @"ㄅ": @"_P",
                                 @"ㄉ": @"_T",
                                 @"ㄋ": @"_N",
                                 @"ㄌ": @"_L",
                                 @"ㄍ": @"_K",
                                 @"ㄏ": @"_H",
                                 @"ㆡ": @"_J",
                                 @"ㄙ": @"_S",
                                 @"ㆣ": @"_G",
                                 @"ㆠ": @"_B",
                                 @"ㄛ": @"_O",
                                 @"ㄘ": @"_CHH",
                                 @"ㄆ": @"_PH",
                                 @"ㄊ": @"_TH",
                                 @"ㄎ": @"_KH",
                                 @"ㆦ": @"_OU",
                                 @"ㄗ": @"_CH",
                                 @"ㄐ": @"_CHI",
                                 @"ㄒ": @"_SI",
                                 @"ㄑ": @"_CHHI",
                                 @"ㆢ": @"_JI",
                                 @"ㄞ": @"_AI",
                                 @"ㄠ": @"_AU",
                                 @"ㆰ": @"_AM",
                                 @"ㆱ": @"_OM",
                                 @"ㆭ": @"_NG",
                                 @"ㆧ": @"_ANN",
                                 @"ㆩ": @"_ONN",
                                 @"ㆫ": @"_UNN",
                                 @"ㆥ": @"_ENN",
                                 @"ㆪ": @"_INN",
                                 @"ㆮ": @"_AINN",
                                 @"ㆯ": @"_AUNN",
                                 @"ㆲ": @"_ONG",
                                 @"ㆳ": @"_INNN"
                                 };
    
    changedString = [changedString replaceSpecialZhuyinCharacters];
    changedString = [changedString pushNumbersToEndOfSyllable];
    
    // Tokenize string
    // 2 character symbols
    for (NSString *key in [ZhuyinSymbols2 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:ZhuyinSymbols2[key]];
    }
    // 1 character symbols
    for (NSString *key in [ZhuyinSymbols1 allKeys]) {
        changedString = [changedString stringByReplacingOccurrencesOfString:key withString:ZhuyinSymbols1[key]];
    }
    
    changedString = [changedString convertTokensToNumberedPehoeji];
    
    //NSLog(@"%@", changedString);
    //NSLog(@" ");
    return changedString;
}

- (NSString *)moveToneNumbersToZhuyin
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

- (NSString *)replaceSpecialZhuyinCharacters {
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
