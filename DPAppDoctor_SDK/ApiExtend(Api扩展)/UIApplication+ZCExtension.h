//
//  UIApplication+DPExtension.h
//  YQYLApp
//
//  Created by yupeng xia on 2021/1/12.
//  Copyright © 2021 zcw. All rights reserved.
//

#import "DPAppDoctor.h"
#ifdef DPAppDoctorDebug

@interface UIApplication (DPExtension)
///获取keyWindow，iOS13废弃 [UIApplication sharedApplication].keyWindow
@property(nullable, nonatomic, readonly) UIWindow *keyWindowDP;
@end

#endif
