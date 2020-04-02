//
//  MLeaksMessenger.m
//  MLeaksFinder
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "MLeaksMessenger.h"

static __weak UIAlertView *alertView;

@implementation MLeaksMessenger

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message {
    [self alertWithTitle:title message:message delegate:nil additionalButtonTitle:nil];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
              delegate:(id<UIAlertViewDelegate>)delegate
 additionalButtonTitle:(NSString *)additionalButtonTitle {
  
    BOOL debugValue = [[NSUserDefaults standardUserDefaults] boolForKey:@"zcwDebugValueUserDefaults"];
    if (debugValue == NO) {
        return;
    }
    
    [alertView dismissWithClickedButtonIndex:0 animated:NO];
    UIAlertView *alertViewTemp = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:delegate
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:additionalButtonTitle, nil];
    [alertViewTemp show];
    alertView = alertViewTemp;
    
    NSLog(@"%@: %@", title, message);
}

@end
