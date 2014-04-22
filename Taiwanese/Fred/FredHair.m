//
//  FredHair.m
//  Fred
//
//  Created by Jason McDowell on 3/18/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "FredHair.h"

@implementation FredHair

- (UIBezierPath *) makeUIBezierPathInRect:(CGRect) rect
{
    UIBezierPath *hair = [[UIBezierPath alloc] init];
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;

    CGPoint topLeft = CGPointZero;
    CGPoint topRight = CGPointMake(width, 0);
    CGPoint bottomRight = CGPointMake(width, height);
    CGPoint bottomLeft = CGPointMake(0, height);
    
    [hair moveToPoint:topLeft];
    [hair addLineToPoint:topRight];
    [hair addLineToPoint:bottomRight];
    [hair addLineToPoint:bottomLeft];
    [hair addLineToPoint:topLeft];
    [hair closePath];
    
    CGAffineTransform centerOnOrigin = CGAffineTransformMakeTranslation(-width/2, -height/2);
    CGAffineTransform centerInRect = CGAffineTransformMakeTranslation(self.bounds.origin.x + self.bounds.size.width/2, self.bounds.origin.y + self.bounds.size.height/2);
    [hair applyTransform:centerOnOrigin];
    [hair applyTransform:centerInRect];
    
    return hair;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.minimumWidth = 0.75 * frame.size.width;
        self.minimumHeight = 0.85 * frame.size.height;
        self.maximumHeight = 1.10 * frame.size.height;
    }
    
    return self;
}

@end
