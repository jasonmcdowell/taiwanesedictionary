//
//  NSString+Taiwanese.h
//  Table View Practice
//
//  Created by Jason McDowell on 3/10/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Taiwanese)
- (NSString *)pinyin;
- (NSString *)convertToTaiwaneseOrthography;
- (NSString *)convertToSearchOrthography;
- (NSString *)convertToNumberedPehoeji;

#define PEHOEJI             @"Pe̍h-ōe-jī"
#define IPA                 @"International Phonetic Alphabet"
#define REVISED_TLPA        @"Revised TLPA"
#define TLPA                @"TLPA"
#define BP                  @"BP"
#define MLT                 @"MLT"
#define DT                  @"Daī-ghî tōng-iōng pīng-im"
#define TAIWANESE_KANA      @"Taiwanese kana"
#define EXTENDED_BOPOMOFO   @"Extended Zhuyin"
#define TAILO               @"Tâi-uân lô-má-jī"
#define SOURCE              @"Source"

@end
