//
//  TTDialog.h
//  MenuHamburger
//
//  Created by Matias Spinelli on 7/4/15.
//  Copyright (c) 2015 Dalmunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTDialog : UIView

@property (nonatomic, strong) NSString * nibName;


+ (void) showDialog;
+ (void) showDialogWithNibName:(NSString *)nibName;
+ (void) setDefaultNibName:(NSString *)nibName;

@end
