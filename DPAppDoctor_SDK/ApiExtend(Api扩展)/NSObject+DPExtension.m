//
//  NSObject+DPExtension.m
//  DPAppDoctor
//
//  Created by yupeng xia on 2021/4/17.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import "NSObject+DPExtension.h"
#import <objc/runtime.h>

@implementation NSObject (DPExtension)
static void *idInfoKey;
- (id)idInfo{
    return objc_getAssociatedObject(self, &idInfoKey);
}
- (void)setIdInfo:(id)idInfo{
    return objc_setAssociatedObject(self, &idInfoKey, idInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
