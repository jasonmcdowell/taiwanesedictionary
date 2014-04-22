//
//  Example.h
//  Table View Practice
//
//  Created by Jason McDowell on 3/8/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Example : NSObject <NSCoding>
@property (strong, nonatomic) NSString *taiwanese;
@property (strong, nonatomic) NSString *chinese;
@property (strong, nonatomic) NSString *english;

- initWithTaiwanese: (NSString *) taiwanese
            Chinese: (NSString *) chinese
            English: (NSString *) english;

@end
