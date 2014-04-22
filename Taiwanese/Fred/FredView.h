//
//  FredView.h
//  Fred
//
//  Created by Jason McDowell on 3/4/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FredView : UIView
@property (nonatomic) BOOL filled;
@property (nonatomic) CGPoint offset;
@property (strong, nonatomic) UIColor *fillColor;
@property (nonatomic) CGFloat minimumWidth;
@property (nonatomic) CGFloat minimumHeight;
@property (nonatomic) CGFloat maximumWidth;
@property (nonatomic) CGFloat maximumHeight;
@property (nonatomic) CGRect defaultFrame;

- (void)toggleFilling;
- (UIBezierPath *) makeUIBezierPathInRect:(CGRect) rect;
- (void) updateView;
- (void) updateViewFromDefault;

@end
