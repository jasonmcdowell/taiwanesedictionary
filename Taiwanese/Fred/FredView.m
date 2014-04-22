//
//  FredView.m
//  Fred
//
//  Created by Jason McDowell on 3/4/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "FredView.h"

@interface FredView ()
@property (nonatomic) CGPoint oldPoint;
@end

@implementation FredView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.filled = NO;
        self.offset = CGPointMake(0, 0);
        
        self.minimumHeight = 0.5 * frame.size.height;
        self.minimumWidth = 0.5 * frame.size.width;
        self.maximumHeight = 1.5 * frame.size.height;
        self.maximumWidth = 1.5  * frame.size.width;
        
        self.defaultFrame = frame;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tap];
        
        UITapGestureRecognizer *tapDouble = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapDoubleGesture:)];
        tapDouble.numberOfTapsRequired = 2;
        //tapDouble.delegate = self;
        [tap requireGestureRecognizerToFail:tapDouble];
        [self addGestureRecognizer:tapDouble];
        
        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
        [self addGestureRecognizer:rotation];
        
        //UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
        //[self addGestureRecognizer:longPress];
        
        UIPanGestureRecognizer *panSingle = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resizeElement:)];
        panSingle.minimumNumberOfTouches = 1;
        panSingle.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:panSingle];
        
        UIPanGestureRecognizer *panDouble = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(translateElement:)];
        panDouble.minimumNumberOfTouches = 2;
        panDouble.maximumNumberOfTouches = 2;
        [self addGestureRecognizer:panDouble];
    }
    
    return self;
}

- (UIBezierPath *) makeUIBezierPathInRect:(CGRect) rect
{
    // abstract method
    UIBezierPath *path = [[UIBezierPath alloc] init];
    return path;
}

#pragma mark - Drawing methods

- (void)drawRect:(CGRect)rect
{
    CGFloat lineWidth = 2.0;
    UIBezierPath *path = [self makeUIBezierPathInRect:CGRectInset(rect, lineWidth, lineWidth)];
    path.lineWidth = lineWidth;
    
    [[UIColor blackColor] setFill];
    [[UIColor blackColor] setStroke];
    [path stroke];
    
    if (self.filled) {
        if (self.fillColor) {
            [self.fillColor setFill];
        } else {
            [[UIColor blackColor] setFill];
        }
    } else {
        [[UIColor whiteColor] setFill];
    }
    [path fill];
}

- (void)toggleFilling
{
    self.filled = !self.filled;
    [self setNeedsDisplay];
}

- (void) updateView
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.frame.size.width + self.offset.x;
    CGFloat height = self.frame.size.height + self.offset.y;
    
    //self.offset = CGPointZero;
    
    if (width < self.minimumWidth) {
        width = self.minimumWidth;
    }
    if (height < self.minimumHeight) {
        height = self.minimumHeight;
    }
    if (width > self.maximumWidth) {
        width = self.maximumWidth;
    }
    if (height > self.maximumHeight) {
        height = self.maximumHeight;
    }
    
    self.bounds = CGRectMake(x, y, width, height);
    
    [self setNeedsDisplay];
}

- (void) updateViewFromDefault
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.defaultFrame.size.width + self.offset.x;
    CGFloat height = self.defaultFrame.size.height + self.offset.y;
    
    //self.offset = CGPointZero;
    
    if (width < self.minimumWidth) {
        width = self.minimumWidth;
    }
    if (height < self.minimumHeight) {
        height = self.minimumHeight;
    }
    if (width > self.maximumWidth) {
        width = self.maximumWidth;
    }
    if (height > self.maximumHeight) {
        height = self.maximumHeight;
    }
    
    self.bounds = CGRectMake(x, y, width, height);
    
    [self setNeedsDisplay];
}

#pragma mark - Gesture Handling

- (void)handleTapGesture:(UITapGestureRecognizer *)gestureRecognizer;
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        int magnitude = 30;
        CGFloat x = ((float)(arc4random() % magnitude) - magnitude/2);
        CGFloat y = ((float)(arc4random() % magnitude) - magnitude/2);
        //NSLog(@"x:%f, y:%f",x,y);
        self.offset = CGPointMake(x, y);
        //self.bounds = self.defaultFrame;
        [UIView animateWithDuration:0.5 animations:^{
            [self updateView];
        }];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Tap detected.");
    }
}

- (void)handleTapDoubleGesture:(UITapGestureRecognizer *)gestureRecognizer;
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self toggleFilling];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Double Tap detected.");
    }
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)gestureRecognizer
{
    self.transform = CGAffineTransformRotate(self.transform, gestureRecognizer.rotation);
    gestureRecognizer.rotation = 0;
}

- (void)translateElement:(UIPanGestureRecognizer *)gestureRecognizer
{
    // pan gesture: translation

    CGPoint translation = [gestureRecognizer translationInView:self.superview];
	self.center = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
	[gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
    
    //    NSLog(@"center: %f,%f", self.center.x, self.center.y);
    //    NSLog(@"superview center: %f,%f", self.superview.center.x, self.superview.center.y);
    //    NSLog(@"bounds: %f,%f,%f,%f", self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width,self.bounds.size.height);
    //    NSLog(@"frame: %f,%f,%f,%f\n\n", self.frame.origin.x, self.frame.origin.y, self.frame.size.width,self.frame.size.height);
    
    CGPoint frameCenter = CGPointMake(self.defaultFrame.origin.x + self.defaultFrame.size.width/2, self.defaultFrame.origin.y + self.defaultFrame.size.height/2);
    
    CGPoint min = CGPointMake(frameCenter.x - self.minimumWidth/3, frameCenter.y - self.minimumHeight/3);
    CGPoint max = CGPointMake(frameCenter.x + self.minimumWidth/3, frameCenter.y + self.minimumHeight/3);
    
    if (self.center.x < min.x) {
        self.center = CGPointMake(min.x, self.center.y);
    }
    if (self.center.x > max.x) {
        self.center = CGPointMake(max.x, self.center.y);
    }
    if (self.center.y < min.y) {
        self.center = CGPointMake(self.center.x, min.y);
    }
    if (self.center.y > max.y) {
        self.center = CGPointMake(self.center.x, max.y);
    }
}

- (void)resizeElement:(UIPanGestureRecognizer *)gestureRecognizer
{
    // shape morphing
    
    self.offset = [gestureRecognizer translationInView:self.superview];
    [self updateView];
    
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        self.oldPoint = [gestureRecognizer locationInView:self.superview];
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        
        CGPoint newPoint = [gestureRecognizer locationInView:self.superview];
        CGFloat x = self.oldPoint.x - newPoint.x;
        CGFloat y = self.oldPoint.y - newPoint.y;
        self.oldPoint = newPoint;

        self.offset = CGPointMake(x, y);
        [self updateView];

    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        //else do cleanup
    }
    
}

@end
