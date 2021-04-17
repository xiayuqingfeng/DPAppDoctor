//
//  ZhcwCollegeSDK.h
//  ZhcwCollegeSDK
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#ifdef DEBUG
#define DPAppDoctorDebug 1
#endif

#ifdef DPAppDoctorDebug

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DPExtension.h"
#import "DPNormal.h"

@interface DPAppDoctor : NSObject
+ (instancetype)shareInstance;

///是否显示测试模块: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isShowTest;
///是否打开所有监测项: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isOpenAll;

///日志打印开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isLogOut;
///内存泄露监测开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isLeaked;
///CPU、GPU、FPS监测开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isMonitor;
///UI布局开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isViewColor;
///diy开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isDiy;
@end

#endif
