//
//  Definition.h
//  Taiwanese Dictionary
//
//  Created by Jason McDowell on 2/27/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Example.h"

@interface Definition : NSObject <NSCoding>

@property (strong, nonatomic) NSString *taiwanese;
@property (strong, nonatomic) NSString *chinese;
@property (strong, nonatomic) NSString *english;
@property (strong, nonatomic) NSString *search;
@property (strong, nonatomic) NSMutableArray *examples;

- (Definition *) initWithTaiwanese: (NSString *) taiwanese
                           Chinese: (NSString *) chinese
                           English: (NSString *) english
                           Search: (NSString *) search
                          Examples: (NSMutableArray *) examples;

- (void) addExample: (Example *) example;

@end
