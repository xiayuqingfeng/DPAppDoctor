//
//  UIView+MemoryLeak.m
//  DPLeaksFinder
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "UIView+MemoryLeak.h"
#import "NSObject+MemoryLeak.h"

#if _INTERNAL_DPLF_ENABLED

@implementation UIView (MemoryLeak)

- (BOOL)willDealloc {
    if (![super willDealloc]) {
        return NO;
    }
    
    [self willReleaseChildren:self.subviews];
    
    return YES;
}

@end

#endif
