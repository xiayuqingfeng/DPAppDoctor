//
//  UIApplication+ZCExtension.m
//  YQYLApp
//
//  Created by yupeng xia on 2021/1/12.
//  Copyright © 2021 zcw. All rights reserved.
//

#import "UIApplication+ZCExtension.h"
#import "AppDelegate.h"

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
        aWindow = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window;
    }
    return aWindow;
}

///获取LaunchImage启动图片
+ (NSString *)getLaunchImageName {
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    CGSize viewSize = [UIApplication sharedApplication].keyWindow.bounds.size;
    //横屏请设置成 @"Landscape"
    NSString *viewOrientation = @"Portrait";
    NSString *launchImage = nil;
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    return launchImage;
}
@end
