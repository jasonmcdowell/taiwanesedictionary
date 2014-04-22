//
//  FredEye.m
//  Fred
//
//  Created by Jason McDowell on 3/17/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "FredEye.h"

@implementation FredEye

- (UIBezierPath *) makeUIBezierPathInRect:(CGRect) rect
{    
    UIBezierPath *eye = [[UIBezierPath alloc] init];
    
    CGFloat eyeHeight = rect.size.height - rect.size.width;
    CGFloat eyeWidth = rect.size.width;

    CGPoint topLeft = CGPointZero;
    //CGPoint topRight = CGPointMake(self.eyeWidth, 0);
    //CGPoint bottomLeft = CGPointMake(self.eyeWidth, self.eyeHeight);
    CGPoint bottomRight = CGPointMake(eyeWidth, eyeHeight);
    
    CGPoint topArcCenter = CGPointMake(eyeWidth/2, 0);
    CGPoint bottomArcCenter = CGPointMake(eyeWidth/2, eyeHeight);
    
    [eye moveToPoint:topLeft];
    [eye addArcWithCenter:topArcCenter radius:eyeWidth/2 startAngle:M_PI endAngle:0 clockwise:YES];
    [eye addLineToPoint:bottomRight];
    [eye addArcWithCenter:bottomArcCenter radius:eyeWidth/2 startAngle:0 endAngle:M_PI clockwise:YES];
    [eye addLineToPoint:topLeft];
    [eye closePath];
    
    CGAffineTransform centerOnOrigin = CGAffineTransformMakeTranslation(-eyeWidth/2, -eyeHeight/2);
    CGAffineTransform centerInRect = CGAffineTransformMakeTranslation(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height/2);
    [eye applyTransform:centerOnOrigin];
    [eye applyTransform:centerInRect];
    
    return eye;
}

@end
