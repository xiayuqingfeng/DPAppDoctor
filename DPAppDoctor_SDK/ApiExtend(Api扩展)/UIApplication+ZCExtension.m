//
//  UIApplication+ZCExtension.m
//  YQYLApp
//
//  Created by yupeng xia on 2021/1/12.
//  Copyright © 2021 zcw. All rights reserved.
//

#import "UIApplication+ZCExtension.h"

@implementation UIApplication (DPExtension)
///获取keyWindow，iOS13废弃 [UIApplication sharedApplication].keyWindow
- (UIWindow *)keyWindowDP {
    UIWindow *aWindow = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in self.connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        aWindow = window;
                        break;
                    }
                }
            }
        }
    }else {
        aWindow = [UIApplication sharedApplication].keyWindow;
    }
    if (aWindow == nil || !aWindow.isKeyWindow) {
        aWindow = [[UIApplication sharedApplication] delegate].window;
    }
    return aWindow;
}
@end
