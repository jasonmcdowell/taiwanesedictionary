//
//  Entry.h
//  Taiwanese Dictionary
//
//  Created by Jason McDowell on 2/27/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definition.h"

@interface Entry : NSObject <NSCoding>

@property (strong, nonatomic) NSMutableArray *definitions;
@property (strong, nonatomic) NSString *key;

- (Entry *) initWithKey:(NSString *)key;
- (Entry *) initWithKey: (NSString *) key Definitions:(NSArray *)definitions;
- (void) addDefinition: (Definition *) definition;



@end
