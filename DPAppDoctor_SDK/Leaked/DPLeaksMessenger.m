//
//  DPLeaksMessenger.m
//  DPLeaksFinder
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "DPLeaksMessenger.h"
#ifdef DPAppDoctorDebug

static __weak UIAlertView *alertView;

@implementation DPLeaksMessenger

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    [self alertWithTitle:title message:message delegate:nil additionalButtonTitle:nil];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate additionalButtonTitle:(NSString *)additionalButtonTitle {
  
    if ([DPAppDoctorManager shareInstance].isLeaked == NO) {
        return;
    }
    
    [alertView dismissWithClickedButtonIndex:0 animated:NO];
    UIAlertView *alertViewTemp = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:delegate
                                                  cancelButtonTitle:@"忽略"
                                                  otherButtonTitles:additionalButtonTitle, nil];
    [alertViewTemp show];
    alertView = alertViewTemp;
}
@end

#endif
