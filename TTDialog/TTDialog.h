//
//  TTDialog.h
//  TTDialog
//
//  Created by Matias Spinelli on 7/4/15.
//  Copyright (c) 2015 Dalmunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTDialog : UIView {
    
    @protected SEL callback;
    @protected id delegate;
}



#pragma mark - Customization

+ (void) setDefaultNibName:(NSString *)nibName;     // default is @"TTDialog"
+ (void) setShouldBounce:(BOOL)bounce;              // default is YES
+ (void) setShouldRotate:(BOOL)rotate;              // default is NO
+ (void) setSmallerToBigger:(BOOL)smallerToBigger_; // default is YES
+ (void) setAnimationDuration:(double)duration;     // defualt is 0.5

#pragma mark - Show Methods

+ (void) showDialog;

+ (void) showDialogWithNibName:(NSString *)nibName;
+ (void) showDialogWithDelegate:(id)delegate_;
+ (void) showDialogInView:(UIView*)parentVew;

+ (void) showDialogWithNibName:(NSString *)nibName andDelegate:(id)delegate_;
+ (void) showDialogWithNibName:(NSString *)nibName inView:(UIView*)parentVew;

+ (void) showDialogInView:(UIView*)parentVew withDelegate:(id)delegate_ ;


+ (void) showDialogWithNibName:(NSString *)nibName inView:(UIView*)parentVew andDelegate:(id)delegate_;

#pragma mark - Instance Methods

- (void) showDialog;
- (void) hideDialog;

@end
