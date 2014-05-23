//
//  NSString+Taiwanese.m
//  Table View Practice
//
//  Created by Jason McDowell on 3/10/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "NSString+Taiwanese.h"
#import "NSString+TaiwaneseHelpers.h"
#import "NSString+Maryknoll.h"
#import "NSString+Pehoeji.h"
#import "NSString+Tai_Lo.h"
#import "NSString+DaiTong.h"
#import "NSString+Zhuyin.h"

@implementation NSString (Taiwanese)

- (NSString*)pinyin
{
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

- (NSString *)convertToTaiwaneseOrthography
{
    NSString *changedString = [self copy];
    
    changedString = [changedString decomposedStringWithCanonicalMapping];
    
    NSString *orthography = [[NSUserDefaults standardUserDefaults] objectForKey:@"orthography"];
    
    if ([orthography isEqualToString:PEHOEJI]) {
        return [changedString convertNumberedPehoejiToPehoeji];
    } else if ([orthography isEqualToString:IPA]) {
        return changedString;
    } else if ([orthography isEqualToString:REVISED_TLPA]) {
        return changedString;
    } else if ([orthography isEqualToString:BP]) {
        return changedString;
    } else if ([orthography isEqualToString:MLT]) {
        return changedString;
    } else if ([orthography isEqualToString:DT]) {
        return [changedString convertNumberedPehoejiToDT];
    } else if ([orthography isEqualToString:TAIWANESE_KANA]) {
        return changedString;
    } else if ([orthography isEqualToString:EXTENDED_BOPOMOFO]) {
        return [changedString convertNumberedPehoejiToZhuyin];
    } else if ([orthography isEqualToString:TAILO]) {
        return [changedString convertNumberedPehoejiToTaiLo];
    } else {
        return changedString;
    }
    
    return changedString;
}

- (NSString *)convertToSearchOrthography
{
    NSString *changedString = [self copy];
    
    changedString = [changedString convertToNumberedPehoeji];
    
    // strip numbers
    changedString = [changedString removeNumbers];
    
    return changedString;
}

- (NSString *)convertToNumberedPehoeji
{
    NSString *changedString = [self copy];
    
    changedString = [changedString decomposedStringWithCanonicalMapping];

    NSString *orthography = [[NSUserDefaults standardUserDefaults] objectForKey:@"orthography"];

    if ([orthography isEqualToString:PEHOEJI]) {
        return [changedString convertPehoejiToNumberedPehoeji];
    } else if ([orthography isEqualToString:IPA]) {
        return changedString;
    } else if ([orthography isEqualToString:REVISED_TLPA]) {
        return changedString;
    } else if ([orthography isEqualToString:BP]) {
        return changedString;
    } else if ([orthography isEqualToString:MLT]) {
        return changedString;
    } else if ([orthography isEqualToString:DT]) {
        return [changedString convertDTToNumberedPehoeji];
    } else if ([orthography isEqualToString:TAIWANESE_KANA]) {
        return changedString;
    } else if ([orthography isEqualToString:EXTENDED_BOPOMOFO]) {
        return [changedString convertZhuyinToNumberedPehoeji];
    } else if ([orthography isEqualToString:TAILO]) {
        return [changedString convertTaiLoToNumberedPehoeji];
    } else {
        return changedString;
    }
    
    return changedString;
}

@end
