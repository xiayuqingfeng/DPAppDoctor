//
//  UITabBarController+MemoryLeak.m
//  MLeaksFinder
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "UITabBarController+MemoryLeak.h"
#import "NSObject+MemoryLeak.h"

#if _INTERNAL_MLF_ENABLED

@implementation UITabBarController (MemoryLeak)

- (BOOL)willDealloc {
    if (![super willDealloc]) {
        return NO;
    }
    
    [self willReleaseChildren:self.viewControllers];
    
    return YES;
}

@end

#endif
