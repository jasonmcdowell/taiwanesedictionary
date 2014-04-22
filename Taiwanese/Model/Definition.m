//
//  Definition.m
//  Taiwanese Dictionary
//
//  Created by Jason McDowell on 2/27/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "Definition.h"

@implementation Definition

- initWithTaiwanese: (NSString *) taiwanese
            Chinese: (NSString *) chinese
            English: (NSString *) english
            Search: (NSString *) search
           Examples: (NSMutableArray *) examples
{
    self = [super init];
    
    if (self) {
        self.taiwanese = taiwanese;
        self.chinese = chinese;
        self.english = english;
        self.search = search;
        self.examples = examples;
    }
    
    return self;
}

- (NSMutableArray *)examples
{
    if (!_examples) {
        _examples = [[NSMutableArray alloc] init];
    }
    
    return _examples;
}

- (void) addExample: (Example *) example
{
    if (example) {
        [self.examples addObject:example];
        //NSLog(@"added example:\n%@", example);
    }
    
}

- (NSString *)taiwanese
{
    if (!_taiwanese) {
        _taiwanese = @"";
    }
    
    return _taiwanese;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\ttaiwanese:%@\n\tchinese:%@\n\tenglish:%@\n\texamples:\n%@",self.taiwanese, self.chinese, self.english, self.examples];
}

-(BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[Definition class]]) {
        Definition *obj = object;
        if ([self.taiwanese isEqualToString:obj.taiwanese] &&
            [self.chinese isEqualToString:obj.chinese] &&
            [self.english isEqualToString:obj.english]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.taiwanese = [decoder decodeObjectForKey:@"taiwanese"];
        self.chinese = [decoder decodeObjectForKey:@"chinese"];
        self.english = [decoder decodeObjectForKey:@"english"];
        self.search = [decoder decodeObjectForKey:@"search"];
        self.examples = [decoder decodeObjectForKey:@"examples"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.taiwanese forKey:@"taiwanese"];
    [encoder encodeObject:self.chinese forKey:@"chinese"];
    [encoder encodeObject:self.english forKey:@"english"];
    [encoder encodeObject:self.search forKey:@"search"];
    [encoder encodeObject:self.examples forKey:@"examples"];
}

@end
