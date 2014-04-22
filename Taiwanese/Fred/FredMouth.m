//
//  FredMouth.m
//  Fred
//
//  Created by Jason McDowell on 3/18/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "FredMouth.h"

@implementation FredMouth

- (UIBezierPath *) makeUIBezierPathInRect: (CGRect) rect
{
    UIBezierPath *mouth = [[UIBezierPath alloc] init];
 
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGPoint topLeft = CGPointZero;
    CGPoint topRight = CGPointMake(width, 0);
    CGPoint bottomRight = CGPointMake(width, height);
    CGPoint bottomLeft = CGPointMake(0, height);
    
    [mouth moveToPoint:topLeft];
    [mouth addLineToPoint:topRight];
    [mouth addLineToPoint:bottomRight];
    [mouth addLineToPoint:bottomLeft];
    [mouth addLineToPoint:topLeft];
    [mouth closePath];
    
    CGAffineTransform centerOnOrigin = CGAffineTransformMakeTranslation(-width/2, -height/2);
    CGAffineTransform centerInRect = CGAffineTransformMakeTranslation(self.bounds.origin.x + self.bounds.size.width/2, self.bounds.origin.y + self.bounds.size.height/2);
    
    [mouth applyTransform:centerOnOrigin];
    [mouth applyTransform:centerInRect];
    return mouth;
}

@end
