//
//  TTDialog.h
//  TTDialog
//
//  Created by Matias Spinelli on 7/4/15.
//  Copyright (c) 2015 Dalmunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTDialog : UIView

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL callback;

#pragma mark - Customization

+ (void) setDefaultNibName:(NSString *)nibName;
+ (void) setShouldBounce:(BOOL)bounce;
+ (void) setShouldRotate:(BOOL)rotate;
+ (void) setSmallerToBigger:(BOOL)smallerToBigger_;
+ (void) setAnimationDuration:(double)duration;

#pragma mark - Show Methods

+ (void) showDialogWithNibName:(NSString *)nibName;
+ (void) showDialogWithNibName:(NSString *)nibName andDelegate:(id)delegate_;
+ (void) showDialogWithNibName:(NSString *)nibName inView:(UIView*)parentVew;
+ (void) showDialogWithNibName:(NSString *)nibName inView:(UIView*)parentVew andDelegate:(id)delegate_;

#pragma mark - Instance Methods

- (void) showDialog;
- (void) hideDialog;

@end
