//
//  NSString+Taiwanese.h
//  Table View Practice
//
//  Created by Jason McDowell on 3/10/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Taiwanese)
- (NSString *)convertSourceToPehoeji;
- (NSString *)convertOrthography;
- (NSString *)removeSourceToneMarks;
- (NSString *)removeOuterQuotes;
- (NSString *)removeOuterQuotesDebug;
- (NSString *)removeColons;
- (NSString *)removeDashes;
- (NSString *)convertPehoejiToNumberedPehoeji;
- (NSString *)convertSourceToNumberedPehoeji;
- (NSString *)removedDoubledNumbers;
- (NSString *)convertNumberedPehoejiToPehoeji;
- (NSString *)convertNumberedPehoejiToDT;

#define PEHOEJI             @"Pe̍h-ōe-jī"
#define IPA                 @"IPA"
#define REVISED_TLPA        @"Revised TLPA"
#define TLPA                @"TLPA"
#define BP                  @"BP"
#define MLT                 @"MLT"
#define DT                  @"DT"
#define TAIWANESE_KANA      @"Taiwanese kana"
#define EXTENDED_BOPOMOFO   @"Extended bopomofo"
#define TAILO               @"Tâi-lô"
#define SOURCE              @"Source"

@end
