//
//  UIApplication+DPExtension.h
//  YQYLApp
//
//  Created by yupeng xia on 2021/1/12.
//  Copyright © 2021 zcw. All rights reserved.
//

#pragma mark /******************Debug打印******************/
#ifdef DEBUG
#define NSLog(format, ...) [[[DPAppDoctor shareInstance] valueForKey:@"aLogView"] setValue:[NSString stringWithFormat:@"[%s] %s [第%d行] %@",[[NSString stringWithFormat:@"%@",[NSDate date]] UTF8String], __FUNCTION__, __LINE__, [NSString stringWithFormat:format, ## __VA_ARGS__]] forKey:@"logOutStr"];
#else
#define NSLog(format, ...)
#endif

#pragma mark /******************强弱引用处理******************/
///弱引用类型，ARC模式使用，不可重新赋值，可以修饰对象，不可以修饰基本数据类型。
#define strong_object_dp(x) __strong typeof(x) strong_##x = x;
///弱引用类型，ARC模式使用，不可重新赋值，可以修饰对象，不可以修饰基本数据类型。
#define weak_object_dp(x)   __weak typeof(x) weak_##x = x;
///强引用类型，ARC、MRC模式使用，可以修饰对象、基本数据类型。
#define block_object_dp(x)  __block typeof(x) block_##x = x;
///防止循环引用，ARC、MRC模式使用，可以修饰对象、基本数据类型。
#define arc_block_dp(x) __block typeof(x) __weak weak_##x = x;

#define _other_dp_block(x)  __block typeof(x) weak_dp_##x = x
#define arc_dp_block(x)     __block typeof(x) __weak weak_dp_##x = x

#pragma mark /******************布局参数******************/
#define DPScreenHeight      [UIScreen mainScreen].bounds.size.height
#define DPScreenWidth       [UIScreen mainScreen].bounds.size.width

#define DPFrameWidth(a)     ((a)*(MIN(DPScreenWidth,DPScreenHeight)/375))
#define DPFrameHeight(a)    DPFrameWidth(a)

#define DPIS_iPhoneX        (((DPScreenWidth == 375 && DPScreenHeight == 812)||(DPScreenWidth == 812 && DPScreenHeight == 375) )?true:false)
#define DPIS_iPhoneXS       DPIS_iPhoneX
#define DPIS_iPhoneXR       (((DPScreenWidth == 414 && DPScreenHeight == 896)||(DPScreenWidth == 896 && DPScreenHeight == 414) )?true:false)
#define DPIS_iPhoneXS_Max   DPIS_iPhoneXR
#define DPIS_iPhoneXAll     (DPIS_iPhoneX || DPIS_iPhoneXS || DPIS_iPhoneXR || DPIS_iPhoneXS_Max)

#define DPStatusbarH        (CGRectIsEmpty([UIApplication sharedApplication].statusBarFrame)?(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)?20:(DPIS_iPhoneXAll ? 44 : 20)):CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define DPNavibarHeight     (DPIS_iPhoneXAll ? 88 : 64)

#define rgbadp(r,g,b,a)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
