//
//  NSString+Zhuyin.h
//  Taiwanese
//
//  Created by Jason McDowell on 5/22/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Zhuyin)
- (NSString *)convertNumberedPehoejiToZhuyin;
- (NSString *)convertZhuyinToNumberedPehoeji;
@end
