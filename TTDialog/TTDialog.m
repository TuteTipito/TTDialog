//
//  TTDialog.m
//  MenuHamburger
//
//  Created by Matias Spinelli on 7/4/15.
//  Copyright (c) 2015 Dalmunc. All rights reserved.
//

#import "TTDialog.h"
#import <QuartzCore/QuartzCore.h>

@interface TTDialog()

- (void)showInView:(UIView*)view;

- (void)memoryWarning:(NSNotification*) notification;

@property (nonatomic, strong) UIView * backView;

@property (nonatomic, strong) UIView * transparentView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
- (void)tapGestureTriggered:(UITapGestureRecognizer *)tapGesture;

@end

@implementation TTDialog

static NSString * defualtNibName = @"TTDialog";

static TTDialog *sharedView = nil;

+ (TTDialog*)sharedViewWithNibName:(NSString*)nibName {
        
    if(sharedView == nil || ![sharedView.nibName isEqualToString:nibName]) {
        
        if(!nibName)
            nibName = defualtNibName;
        
        sharedView = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
    
        sharedView.nibName = nibName;
        
        sharedView.layer.cornerRadius = 10;
        sharedView.userInteractionEnabled = YES;
        [sharedView setExclusiveTouch:YES];
        
        sharedView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                       UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
        
        [[NSNotificationCenter defaultCenter] addObserver:sharedView
                                                 selector:@selector(memoryWarning:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }

    return sharedView;
}


+ (void) setDefaultNibName:(NSString *)nibName {
    defualtNibName = nibName;
    
    [TTDialog sharedViewWithNibName:nibName];
    sharedView.nibName = nibName;
}

+ (void) showDialogWithNibName:(NSString *)nibName  {
    [TTDialog sharedViewWithNibName:nibName];
    sharedView.nibName = nibName;
    [self showDialog];
}

+ (void) showDialog {
    
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    
    UIView* view;
    
    if ([keyWindow respondsToSelector:@selector(rootViewController)]) {
        view = keyWindow.rootViewController.view;
        
        if (view == nil) view = keyWindow;
    }

    if (sharedView.nibName) {
        [sharedView showInView:view];
    } else {
        [[TTDialog sharedViewWithNibName:nil] showInView:view];
    }
    
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
        
#pragma mark SI LO QUIERO INVERSO...
    BOOL smallerToBigger = YES;

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
        
    BOOL shouldBounce = YES;
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.transparentView.alpha = 0.6;
                         sharedView.center = self.center;
                         sharedView.transform = CGAffineTransformMakeScale((shouldBounce ? 1.05 : 1.0), (shouldBounce ? 1.05 : 1.0));
                     }
                     completion:(shouldBounce ? animationBlock : ^(BOOL finished) {
    
    })];

    
}

- (void) hideDialog {
    
    [UIView animateWithDuration:0.6
                     animations:^{
                         self.transparentView.alpha = 0;
                         sharedView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
                     }
                     completion:^(BOOL finished){
                         sharedView.nibName = nil;
                         [self.transparentView removeFromSuperview];
                         [sharedView removeFromSuperview];
                     }];
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
