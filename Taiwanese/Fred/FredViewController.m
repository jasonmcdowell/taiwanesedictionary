//
//  FredViewController.m
//  Fred
//
//  Created by Jason McDowell on 3/4/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import "FredViewController.h"
#import "FredView.h"
#import "FredHair.h"
#import "FredFace.h"
#import "FredNose.h"
#import "FredMouth.h"
#import "FredEye.h"

@interface FredViewController ()
@property (strong, nonatomic) UIView *fred;
@end

@implementation FredViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self becomeFirstResponder];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.unit = 4.5;
    
    self.eyeWidth = 8*self.unit;
    self.eyeHeight = 4*self.eyeWidth;
    
    self.noseLength = 2*self.eyeWidth;
    self.noseWidth = 1.5*self.eyeWidth;
    self.noseHeight = 1*self.eyeWidth;
    
    self.mouthHeight = 3*self.unit;
    self.mouthWidth = 2*self.eyeWidth;
    
    self.faceWidth = 5*self.eyeWidth;
    self.faceSideHeight = 6*self.eyeWidth;
    self.faceHeight = 9*self.eyeWidth;
    self.faceTopWidth = 2*self.eyeWidth;
    self.faceCornerRadius = (self.faceWidth - self.faceTopWidth)/2;
    
    self.hairWidth = 3*self.unit;
    self.hairLength = self.faceSideHeight + 1.5*self.eyeWidth + self.faceCornerRadius/2;
    
    self.thickness = 3.0;
    
    [self initializeFred];

    [self attachGestureHandlers];

}

//- (BOOL)prefersStatusBarHidden {return YES;}

- (void) initializeFred
{
    self.fred = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.fred];
    self.fred.backgroundColor = [UIColor clearColor];
    
    CGRect faceFrame = CGRectMake(0, 0, self.faceWidth, self.faceHeight);
    CGRect leftEyeFrame = CGRectMake(self.eyeWidth, 1.5*self.eyeWidth, self.eyeWidth, self.eyeHeight);
    CGRect rightEyeFrame = CGRectMake(3*self.eyeWidth, 1.5*self.eyeWidth, self.eyeWidth, self.eyeHeight);
    CGRect noseFrame = CGRectMake(self.faceWidth/2 - self.noseWidth/2, self.faceSideHeight, self.noseWidth, self.noseHeight);
    CGRect mouthFrame = CGRectMake(self.faceWidth/2 - self.mouthWidth/2, self.faceCornerRadius + self.faceSideHeight, self.mouthWidth, self.mouthHeight);
    CGRect hairFrame = CGRectMake(self.faceWidth/2 - self.hairWidth/2, -self.faceCornerRadius/2 - self.eyeWidth/2, self.hairWidth, self.hairLength);
    
    CGFloat centerX = self.view.bounds.size.width/2;
    CGFloat centerY = self.view.bounds.size.height/2;
    
    CGAffineTransform moveToCenter = CGAffineTransformMakeTranslation(centerX - self.faceWidth/2, centerY - self.faceHeight/2);
    
    faceFrame = CGRectApplyAffineTransform(faceFrame, moveToCenter);
    leftEyeFrame = CGRectApplyAffineTransform(leftEyeFrame, moveToCenter);
    rightEyeFrame = CGRectApplyAffineTransform(rightEyeFrame, moveToCenter);
    noseFrame = CGRectApplyAffineTransform(noseFrame, moveToCenter);
    mouthFrame = CGRectApplyAffineTransform(mouthFrame, moveToCenter);
    hairFrame = CGRectApplyAffineTransform(hairFrame, moveToCenter);
    
    FredFace *face = [[FredFace alloc] initWithFrame:faceFrame];
    FredEye *leftEye = [[FredEye alloc] initWithFrame:leftEyeFrame];
    FredEye *rightEye = [[FredEye alloc] initWithFrame:rightEyeFrame];
    FredNose *nose = [[FredNose alloc] initWithFrame:noseFrame];
    FredMouth *mouth = [[FredMouth alloc] initWithFrame:mouthFrame];
    
    leftEye.filled = YES;
    rightEye.filled = YES;
    nose.filled = YES;
    mouth.filled = YES;
    
    for (int i = -3; i <= 3; i++) {
        FredHair *hair = [[FredHair alloc] initWithFrame:hairFrame];
        [self.fred addSubview:hair];
        hair.layer.anchorPoint = CGPointMake(0.5, 1.0);
        //NSLog(@"anchor point: %f, %f", test.layer.anchorPoint.x, test.layer.anchorPoint.y);
        CGAffineTransform rotation = CGAffineTransformMakeRotation(i*M_PI_2/18);
        CGAffineTransform translation = CGAffineTransformMakeTranslation(0, 4*self.eyeWidth);
        hair.transform = CGAffineTransformConcat(rotation,translation);
    }
    
    [self.fred addSubview:face];
    [self.fred addSubview:leftEye];
    [self.fred addSubview:rightEye];
    [self.fred addSubview:nose];
    [self.fred addSubview:mouth];
    
    //self.fred.center = CGPointMake(self.fred.center.x, self.fred.center.y);
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Gesture Handling

- (void)attachGestureHandlers
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    [self.view addGestureRecognizer:pinch];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tap];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
    [self.view addGestureRecognizer:rotation];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.view addGestureRecognizer:longPress];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
    self.fred.transform = CGAffineTransformScale(self.fred.transform, gestureRecognizer.scale, gestureRecognizer.scale);
    gestureRecognizer.scale = 1;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:self.fred.superview];
	self.fred.center = CGPointMake(self.fred.center.x + translation.x, self.fred.center.y + translation.y);
	[gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.fred.superview];
    
    if (self.fred.center.x < 0) {
        self.fred.center = CGPointMake(0, self.fred.center.y);
    }
    if (self.fred.center.x > self.view.bounds.size.width) {
        self.fred.center = CGPointMake(self.view.bounds.size.width, self.fred.center.y);
    }
    if (self.fred.center.y < 0) {
        self.fred.center = CGPointMake(self.fred.center.x, 0);
    }
    if (self.fred.center.y > self.view.bounds.size.height) {
        self.fred.center = CGPointMake(self.fred.center.x, self.view.bounds.size.height);
    }
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)gestureRecognizer
{
    self.fred.transform = CGAffineTransformRotate(self.fred.transform, gestureRecognizer.rotation);
    gestureRecognizer.rotation = 0;
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    //NSLog(@"Long Press is detected");
    for (FredView *view in self.fred.subviews) {
        int magnitude = 20;
        CGFloat x = ((float)(arc4random() % magnitude) - magnitude/2);
        CGFloat y = ((float)(arc4random() % magnitude) - magnitude/2);
        //NSLog(@"x:%f, y:%f",x,y);
        view.offset = CGPointMake(x, y);
        [UIView animateWithDuration:0.5
                         animations:^{
                             [view updateViewFromDefault];
                         }];
    }
}


- (void)handleTapGesture:(UITapGestureRecognizer *)gestureRecognizer;
{
    for (FredView *view in self.fred.subviews) {
        int magnitude = 20;
        CGFloat x = ((float)(arc4random() % magnitude) - magnitude/2);
        CGFloat y = ((float)(arc4random() % magnitude) - magnitude/2);
        //NSLog(@"x:%f, y:%f",x,y);
        view.offset = CGPointMake(x, y);
        [UIView animateWithDuration:0.5
                         animations:^{
                             [view updateViewFromDefault];
                         }];
    }
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer;
{
    //NSLog(@"left");
    NSUInteger options = UIViewAnimationOptionTransitionFlipFromRight;
    CGAffineTransform transform = CGAffineTransformMakeScale(-1.0, 1.0);
    [self flipFredWithOptions:options Transform:transform];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gestureRecognizer;
{
    //NSLog(@"right");
    NSUInteger options = UIViewAnimationOptionTransitionFlipFromLeft;
    CGAffineTransform transform = CGAffineTransformMakeScale(-1.0, 1.0);
    [self flipFredWithOptions:options Transform:transform];
}

- (void)handleSwipeUp:(UISwipeGestureRecognizer *)gestureRecognizer;
{
    //NSLog(@"up");
    NSUInteger options = UIViewAnimationOptionTransitionFlipFromTop;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0, -1.0);
    [self flipFredWithOptions:options Transform:transform];
}

- (void)handleSwipeDown:(UISwipeGestureRecognizer *)gestureRecognizer;
{
    //NSLog(@"down");
    NSUInteger options = UIViewAnimationOptionTransitionFlipFromBottom;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0, -1.0);
    [self flipFredWithOptions:options Transform:transform];
}

- (void) flipFredWithOptions:(NSUInteger) options Transform: (CGAffineTransform) transform
{
    [UIView transitionWithView:self.fred
                      duration:0.5
                       options:options
                    animations:^{
                        FredView *feature = self.fred.subviews[8];
                        BOOL newState = !feature.hidden;
                        [(FredView *) self.fred.subviews[8] setHidden: newState];
                        [(FredView *) self.fred.subviews[9] setHidden: newState];
                        [(FredView *) self.fred.subviews[10] setHidden: newState];
                        [(FredView *) self.fred.subviews[11] setHidden: newState];
                        self.fred.transform = CGAffineTransformConcat(self.fred.transform, transform);
                    }
                    completion:NULL];
}


#pragma mark - Motion Events

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        //NSLog(@"Shake is detected");
        [UIView animateWithDuration:0.5 animations:^{
        }];
        for (FredView *view in self.fred.subviews) {
            [view removeFromSuperview];
        }
        [self.fred removeFromSuperview];
        [self initializeFred];
    }
}

@end
