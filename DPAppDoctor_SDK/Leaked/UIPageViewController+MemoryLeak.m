//
//  UIPageViewController+MemoryLeak.m
//  DPLeaksFinder
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "UIPageViewController+MemoryLeak.h"
#ifdef DPAppDoctorDebug

#import "DPLeakedHeader.h"

@implementation UIPageViewController (MemoryLeak)

- (BOOL)willDealloc {
    if (![super willDealloc]) {
        return NO;
    }
    
    [self willReleaseChildren:self.viewControllers];
    
    return YES;
}

@end

#endif
