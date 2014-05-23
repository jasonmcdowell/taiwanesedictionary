//
//  NSString+Pehoeji.h
//  Taiwanese
//
//  Created by Jason McDowell on 5/21/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Pehoeji)
- (NSString *)convertPehoejiToNumberedPehoeji;
- (NSString *)convertNumberedPehoejiToPehoeji;
@end
