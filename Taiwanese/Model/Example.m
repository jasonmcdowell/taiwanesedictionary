//
//  Example.m
//  Table View Practice
//
//  Created by Jason McDowell on 3/8/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "Example.h"

@implementation Example


- initWithTaiwanese: (NSString *) taiwanese
            Chinese: (NSString *) chinese
            English: (NSString *) english
{
    self = [super init];
    
    if (self) {
        self.taiwanese = taiwanese;
        self.chinese = chinese;
        self.english = english;
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\t\ttaiwanese:%@\n\t\tchinese:%@\n\t\tenglish:%@",self.taiwanese, self.chinese, self.english];
}


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.taiwanese = [decoder decodeObjectForKey:@"taiwanese"];
        self.chinese = [decoder decodeObjectForKey:@"chinese"];
        self.english = [decoder decodeObjectForKey:@"english"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.taiwanese forKey:@"taiwanese"];
    [encoder encodeObject:self.chinese forKey:@"chinese"];
    [encoder encodeObject:self.english forKey:@"english"];
}

@end
