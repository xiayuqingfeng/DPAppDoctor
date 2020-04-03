//
//  XLMonitorHandle.h
//  MonitorCpuUsage
//
//  Created by HeXiuLian on 2019/4/25.
//  Copyright © 2019 HeXiuLian. All rights reserved.
//

#import "DPAppDoctor.h"
#ifdef DPAppDoctorDebug

typedef void(^MonitorDataBlock)(NSDictionary *monitorData);

@interface XLMonitorHandle : NSObject
@property (nonatomic, copy) MonitorDataBlock aMonitorDataBlock;
///CPU使用率警戒值, 默认 90
@property (nonatomic, assign) CGFloat cpuUsageMax;

+ (instancetype)shareInstance;
///开始监测
- (void)startMonitorFpsAndCpuUsage;
///停止监测
- (void)stopMonitor;
///清除监测数据
- (void)clearMonitorData;
///获取监测数据
- (NSArray *)getCpuUsageData;
///是否打印监测日志
- (void)setLogStatus:(BOOL)logStatus;
@end

#endif
