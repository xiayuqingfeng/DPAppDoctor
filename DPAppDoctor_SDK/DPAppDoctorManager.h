//
//  DPAppDoctorManager.h
//  DPAppDoctorManager
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "DPAppDoctor.h"
#ifdef DPAppDoctorDebug

@interface DPAppDoctorManager : NSObject
///DIY1自定义block函数
@property (nonatomic, copy) void(^DPdiyBlock)(BOOL isDiy);
///DIY2自定义block函数
@property (nonatomic, copy) void(^DPdiyBlockOne)(BOOL isDiy);

///是否显示测试模块: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isShowTest;

///日志打印开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isLogOut;
///内存泄露监测开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isLeaked;
///CPU、GPU、FPS监测开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isMonitor;
///UI布局开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isViewColor;
///diy1开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isDiy;
///diy2开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isDiyOne;

+ (instancetype)shareInstance;
@end

#endif
