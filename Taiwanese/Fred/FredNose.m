//
//  FredNose.m
//  Fred
//
//  Created by Jason McDowell on 3/18/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "FredNose.h"

@implementation FredNose

- (UIBezierPath *) makeUIBezierPathInRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat cornerY = height/7;
    CGFloat tanTheta = (height-cornerY)/(width/2);

    CGFloat cornerX = cornerY * tanTheta;
    CGFloat middleY = (width/2 - cornerX) * tanTheta;
    
    UIBezierPath *nose = [[UIBezierPath alloc] init];
    CGPoint point1 = CGPointMake(0,cornerY);
    CGPoint point2 = CGPointMake(cornerX,0);
    CGPoint point3 = CGPointMake(width/2,middleY);
    CGPoint point4 = CGPointMake(width - cornerX, 0);
    CGPoint point5 = CGPointMake(width, cornerY);
    CGPoint point6 = CGPointMake(width/2,height);
    
    [nose moveToPoint:point1];
    [nose addLineToPoint:point2];
    [nose addLineToPoint:point3];
    [nose addLineToPoint:point4];
    [nose addLineToPoint:point5];
    [nose addLineToPoint:point6];
    [nose addLineToPoint:point1];
    [nose closePath];

    CGAffineTransform centerOnOrigin = CGAffineTransformMakeTranslation(-width/2, -height/2);
    CGAffineTransform centerInRect = CGAffineTransformMakeTranslation(self.bounds.origin.x + self.bounds.size.width/2, self.bounds.origin.y + self.bounds.size.height/2);
    
    [nose applyTransform:centerOnOrigin];
    [nose applyTransform:centerInRect];
    
    return nose;
}

@end
