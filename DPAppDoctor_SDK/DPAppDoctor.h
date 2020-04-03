//
//  ZhcwCollegeSDK.h
//  ZhcwCollegeSDK
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#define DPAppDoctorDebug DEBUG

#ifdef DPAppDoctorDebug

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DPAppDoctor : NSObject
///内存泄露监测开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isLeaked;
///CPU、GPU、FPS监测开关: YES 打开, NO 关闭, 默认 NO;
@property (nonatomic, assign) BOOL isMonitor;

+ (instancetype)shareInstance;
@end

#endif
