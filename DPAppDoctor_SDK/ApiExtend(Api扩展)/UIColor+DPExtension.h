//
//  UIColor+DPExtension.h
//  DPAppDoctor
//
//  Created by yupeng xia on 2021/4/19.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import "DPAppDoctor.h"
#ifdef DPAppDoctorDebug

@interface UIColor (DPExtension)
+ (UIColor *)dpColorWithHexString:(NSString *)hexString;

- (NSString *)dpHexStringFromColor;
@end

#endif
