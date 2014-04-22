//
//  Entry.m
//  Taiwanese Dictionary
//
//  Created by Jason McDowell on 2/27/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "Entry.h"

@implementation Entry

- (Entry *) initWithKey:(NSString *)key
{
    self = [super init];
    
    if (self) {
        self.key = key;
        self.definitions = [[NSMutableArray alloc] initWithArray:@[]];
    }
    
    return self;
}

- (Entry *) initWithKey: (NSString *) key Definitions:(NSMutableArray *)definitions
{
    self = [super init];
    
    if (self) {
        self.definitions = definitions;
        self.key = key;
    }
    
    return self;
}

- (void) addDefinition: (Definition *) definition
{
    if (definition) {
        [self.definitions addObject:definition];
    }
}

- (NSString *)description
{
    NSMutableString *string = [NSMutableString stringWithFormat:@"\n%@:\n", self.key];
    for (Definition* definition in self.definitions) {
        [string appendFormat:@"%@\n\n", [definition description]];
    }
    
    return [string copy];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.definitions = [decoder decodeObjectForKey:@"definitions"];
        self.key = [decoder decodeObjectForKey:@"key"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.definitions forKey:@"definitions"];
    [encoder encodeObject:self.key forKey:@"key"];
}


@end
