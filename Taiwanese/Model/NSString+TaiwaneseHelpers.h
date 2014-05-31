//
//  NSString+TaiwaneseHelpers.h
//  Taiwanese
//
//  Created by Jason McDowell on 5/21/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TaiwaneseHelpers)
- (NSString *)removeOuterQuotes;
- (NSString *)removeOuterQuotesDebug;
- (NSString *)removeColons;
- (NSString *)removeWhitespace;
- (NSString *)removeDashes;
- (NSString *)removeNumbers;
- (NSString *)remove1and4;
- (NSString *)removedDoubledNumbers;
- (NSString *)insertTones1And4;
- (NSString *)pushNumbersToEndOfSyllable;
- (NSString *) convertNumberedPehoejiToTokens;
- (NSString *) convertTokensToNumberedPehoeji;

- (BOOL)containsNumbers;
- (BOOL)containsDiacritics;

@end
