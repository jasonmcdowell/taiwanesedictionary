//
//  FredFace.m
//  Fred
//
//  Created by Jason McDowell on 3/18/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "FredFace.h"

@implementation FredFace

- (UIBezierPath *) makeUIBezierPathInRect:(CGRect) rect
{
    CGFloat faceWidth = rect.size.width;
    CGFloat faceTopWidth = faceWidth*2.0/5.0;
    CGFloat faceCornerRadius = (faceWidth - faceTopWidth) / 2.0;
    CGFloat faceSideHeight = rect.size.height - 2*faceCornerRadius;

    UIBezierPath *face = [[UIBezierPath alloc] init];
    
    CGPoint leftSideTop = CGPointZero;
    CGPoint leftSideBottom = CGPointMake(leftSideTop.x, faceSideHeight);
    
    CGPoint topLeft = CGPointMake(faceCornerRadius,-faceCornerRadius);
    CGPoint topRight = CGPointMake(topLeft.x + faceTopWidth, topLeft.y);
    
    CGPoint rightSideTop = CGPointMake(faceWidth,leftSideTop.y);
    CGPoint rightSideBottom = CGPointMake(rightSideTop.x, faceSideHeight);
    
    CGPoint bottomLeft = CGPointMake(faceCornerRadius,rightSideBottom.y + faceCornerRadius);
    CGPoint bottomRight = CGPointMake(bottomLeft.x + faceTopWidth, bottomLeft.y);
    
    CGPoint arcTopLeft = CGPointMake(topLeft.x, leftSideTop.y);
    CGPoint arcTopRight = CGPointMake(topRight.x, rightSideTop.y);
    CGPoint arcBottomLeft = CGPointMake(bottomLeft.x, leftSideBottom.y);
    CGPoint arcBottomRight = CGPointMake(bottomRight.x, rightSideBottom.y);
    
    [face moveToPoint:leftSideTop];
    [face addArcWithCenter:arcTopLeft radius:faceCornerRadius startAngle:M_PI endAngle:3*M_PI_2 clockwise:YES];
    [face addLineToPoint:topRight];
    [face addArcWithCenter:arcTopRight radius:faceCornerRadius startAngle:3*M_PI_2 endAngle:0 clockwise:YES];
    [face addLineToPoint:rightSideBottom];
    [face addArcWithCenter:arcBottomRight radius:faceCornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [face addLineToPoint:bottomLeft];
    [face addArcWithCenter:arcBottomLeft radius:faceCornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [face addLineToPoint:leftSideTop];
    [face closePath];
    
    CGAffineTransform centerOnOrigin = CGAffineTransformMakeTranslation(-faceWidth/2, -faceSideHeight/2);
    CGAffineTransform centerInRect = CGAffineTransformMakeTranslation(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height/2);
    [face applyTransform:centerOnOrigin];
    [face applyTransform:centerInRect];
    
    return face;
}

@end
