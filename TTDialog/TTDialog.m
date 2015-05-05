//
//  TTDialog.m
//  TTDialog
//
//  Created by Matias Spinelli on 7/4/15.
//  Copyright (c) 2015 Dalmunc. All rights reserved.
//

#import "TTDialog.h"
#import <QuartzCore/QuartzCore.h>

@interface TTDialog()

//@property (nonatomic, assign) id delegate;

- (void)showInView:(UIView*)view;
- (void)memoryWarning:(NSNotification*) notification;

@property (nonatomic, strong) NSString * nibName;
@property (nonatomic, strong) UIView * parentView;

@property (nonatomic, strong) UIView * backView;

@property (nonatomic, strong) UIView * transparentView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
- (void)tapGestureTriggered:(UITapGestureRecognizer *)tapGesture;

@end

@implementation TTDialog

static NSString * defualtNibName = @"TTDialog";
static BOOL shouldBounce = YES;
static BOOL shouldRotate = NO;
static BOOL smallerToBigger = YES;
static double animationDuration = 0.5;

static TTDialog *sharedView = nil;

+ (TTDialog*)sharedViewWithNibName:(NSString*)nibName inView:(UIView*)parentVew andDelegate:(id)delegate_{
        
    if(sharedView == nil || ![sharedView.nibName isEqualToString:nibName]) {
        
        if(!nibName)
            nibName = defualtNibName;
        
        sharedView = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
    
        sharedView.nibName = nibName;
        sharedView.parentView = parentVew;
        
        sharedView.layer.cornerRadius = 10;
        sharedView.userInteractionEnabled = YES;
        [sharedView setExclusiveTouch:YES];
        
        NSLog(@"height width : { %f : %f }",sharedView.frame.size.height,sharedView.frame.size.width);
        
        sharedView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                       UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
        
        [[NSNotificationCenter defaultCenter] addObserver:sharedView
                                                 selector:@selector(memoryWarning:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }

    return sharedView;
}

#pragma mark - Customization

+ (void) setDefaultNibName:(NSString *)nibName {
    defualtNibName = nibName;
}

+ (void) setShouldBounce:(BOOL)bounce {
    shouldBounce = bounce;
}

+ (void) setShouldRotate:(BOOL)rotate {
    shouldRotate = rotate;
}

+ (void) setSmallerToBigger:(BOOL)smallerToBigger_ {
    smallerToBigger = smallerToBigger_;
}

+ (void) setAnimationDuration:(double)duration {
    animationDuration = duration;
}

- (void) setDelegate:(id)delegate_ {
    delegate = delegate_;
}

#pragma mark - Show Methods

+ (void) showDialog {
    [self showDialogWithNibName:nil inView:nil andDelegate:nil];
}

+ (void) showDialogInView:(UIView*)parentVew {
    [self showDialogWithNibName:nil inView:parentVew andDelegate:nil];
}

+ (void) showDialogInView:(UIView*)parentVew withDelegate:(id)delegate_ {
    [self showDialogWithNibName:nil inView:parentVew andDelegate:nil];
}

+ (void) showDialogWithDelegate:(id)delegate_ {
    [self showDialogWithNibName:nil inView:nil andDelegate:delegate_];
}

+ (void) showDialogWithNibName:(NSString *)nibName {
    [self showDialogWithNibName:nibName inView:nil andDelegate:nil];
}

+ (void) showDialogWithNibName:(NSString *)nibName andDelegate:(id)delegate_ {
    [self showDialogWithNibName:nibName inView:nil andDelegate:delegate_];
}

+ (void) showDialogWithNibName:(NSString *)nibName inView:(UIView*)parentVew {
    [self showDialogWithNibName:nibName inView:parentVew andDelegate:nil];
}


+ (void) showDialogWithNibName:(NSString *)nibName inView:(UIView*)parentVew andDelegate:(id)delegate_ {
    [TTDialog sharedViewWithNibName:nibName inView:parentVew andDelegate:delegate_];
    [sharedView showDialog];
    [sharedView setDelegate:delegate_];
}

#pragma mark - Instance Methods

- (void) showDialog {
    
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView* view;
    
    if (sharedView.parentView) {
        view = sharedView.parentView;
    } else {
        if ([keyWindow respondsToSelector:@selector(rootViewController)]) {
            view = keyWindow.rootViewController.view;
            
            if (view == nil) view = keyWindow;
        }
    }

    [sharedView showInView:view];

}

- (void)showInView:(UIView*)view {

    self.backView = view;
    
    self.transparentView = [[UIView alloc] init];
    
    [self.transparentView  setBackgroundColor:[UIColor blackColor]];
    [self.transparentView  setAlpha:0.6];
    [self.transparentView  setExclusiveTouch:YES];
    [self.transparentView  setUserInteractionEnabled:YES];
    
    [self.transparentView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    
    [self.transparentView setFrame:view.frame];
    
    [self.transparentView addGestureRecognizer:self.tapGesture];
    self.tapGesture.enabled = YES;
    
    [self.backView addSubview:self.transparentView];
    
    
    if(![sharedView isDescendantOfView:view]) {
        [self.backView addSubview:sharedView];
    }
    
    
    sharedView.center = CGPointMake(floor(CGRectGetWidth(self.backView.bounds)/2), floor(CGRectGetHeight(self.backView.bounds)/2));


    if (smallerToBigger) {
        sharedView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } else {
        sharedView.transform = CGAffineTransformMakeScale(2.3, 2.3);
    }
    
    void (^animationBlock)(BOOL) = ^(BOOL finished) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             sharedView.transform = CGAffineTransformMakeScale(0.90, 0.90);
                         }
                         completion:^(BOOL finished){
                             
                             [UIView animateWithDuration:0.2
                                              animations:^{
                                                  sharedView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                                            }
                                              completion:^(BOOL finished){
                                                  
                                                  [UIView animateWithDuration:0.1
                                                                   animations:^{
                                                                       sharedView.transform = CGAffineTransformIdentity;
                                                                   }
                                                                   completion:^(BOOL finished){
                                                                   
                                                                   }];
                                              }];
                         }];
    };
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         if (shouldRotate)
                             sharedView.transform = CGAffineTransformMakeRotation(M_PI);

                         self.transparentView.alpha = 0.6;
                         sharedView.center = self.center;
                         sharedView.transform = CGAffineTransformMakeScale((shouldBounce ? 1.05 : 1.0), (shouldBounce ? 1.05 : 1.0));
                     }
                     completion:(shouldBounce ? animationBlock : ^(BOOL finished) {
    
    })];

    
}

- (void) hideDialog {
    
    [UIView animateWithDuration:animationDuration
                     animations:^{

                         if (shouldRotate)
                             sharedView.transform = CGAffineTransformMakeRotation(M_PI);

                         self.transparentView.alpha = 0;
                         sharedView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
                     }
                     completion:^(BOOL finished){
                         

                         [self callback];
                         
                         sharedView.nibName = nil;
                         [self.transparentView removeFromSuperview];
                         [sharedView removeFromSuperview];
                         
                     }];
}

- (void) callbackDialog {
    
    if ([delegate respondsToSelector:callback]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [delegate performSelector:callback];
            #pragma clang diagnostic pop
    }
    
}

#pragma mark - Gestures

- (UITapGestureRecognizer *)tapGesture {
    
    if (!_tapGesture)
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTriggered:)];
    
    return _tapGesture;
}


- (void)tapGestureTriggered:(UITapGestureRecognizer *)tapGesture {
    
    if (tapGesture.state == UIGestureRecognizerStateEnded)
        [self hideDialog];
    
}

#pragma mark - MemoryWarning

- (void)memoryWarning:(NSNotification *)notification {
    if (sharedView.superview == nil) {
        sharedView = nil;
    }
}


@end
