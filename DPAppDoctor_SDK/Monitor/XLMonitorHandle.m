//
//  XLMonitorHandle.m
//  MonitorCpuUsage
//
//  Created by HeXiuLian on 2019/4/25.
//  Copyright © 2019 HeXiuLian. All rights reserved.
//

#import "XLMonitorHandle.h"
#ifdef DPAppDoctorDebug

#include <sys/sysctl.h>
#include <mach/mach.h>
#import <QuartzCore/QuartzCore.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#import "SMCallStack.h"
#import "CheckNetWorkBytes.h"

#define CPUMONITORRATE  90

@interface XLMonitorHandle ()
//屏幕刷新频率定时器
@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) BOOL logStatus;

//监测数据存储数组
@property (nonatomic, strong) NSMutableArray *monitorDataArr;
@property (nonatomic, strong) NSString *trafficValue;

@end

@implementation XLMonitorHandle

+ (instancetype)shareInstance {
    static XLMonitorHandle *instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[XLMonitorHandle alloc] init];
    });
    return instace;
}

#pragma mark <--------------外部调用函数-------------->
//开始监测
- (void)startMonitorFpsAndCpuUsage {
    if (_displayLink) {
        [_displayLink invalidate];
        self.displayLink = nil;
    }
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(__startMonitor:)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
//停止监测
- (void)stopMonitor {
    [_displayLink invalidate];
    self.displayLink = nil;
}
//清除监测数据
- (void)clearMonitorData {
    [_monitorDataArr removeAllObjects];
}
//获取监测数据
- (NSArray *)getCpuUsageData {
    return [_monitorDataArr copy];
}
//CPU使用率警戒值, 默认 90
- (void)setCpuUsageMax:(CGFloat)cpuUsageMax {
    _cpuUsageMax = cpuUsageMax;
}
//是否打印监测日志
- (void)setLogStatus:(BOOL)logStatus {
    _logStatus = logStatus;
}

#pragma mark <--------------公用功能函数-------------->
//统计监测数据
- (void)__startMonitor:(CADisplayLink *)displayLink {
    if (!_monitorDataArr) {
        self.monitorDataArr = [NSMutableArray new];
    }
    
    static NSTimeInterval lastTime = 0;
    static int frameCount = 0;
    if (lastTime == 0) {
        lastTime = displayLink.timestamp;
        return;
    }
    //累计帧数
    frameCount++;
    //累计时间
    NSTimeInterval passTime = displayLink.timestamp - lastTime;
    //1秒左右获取一次帧数
    if (passTime > 1) {
        //帧数 = 总帧数/时间
        NSString *fps = [NSString stringWithFormat:@"%.0f",round(frameCount/passTime)];
        //重置
        lastTime = displayLink.timestamp;
        frameCount = 0;
        
        NSString *indexStr = [NSString stringWithFormat:@"%lu",(unsigned long)_monitorDataArr.count];
        
        UIViewController *VC = [self getCurrentVC];
        NSString *vcName = NSStringFromClass([VC class]);
        vcName = vcName ? vcName : @"nil";
        
        NSDictionary *dict = @{@"index":indexStr,
                               @"cpuUsage":[self cpuUsageInfo],
                               @"fps":fps,
                               @"memory":[self getMemoryInfo],
                               @"traffic":[CheckNetWorkBytes getNetWorkBytesPerSecond],
                               @"arrThreadInfo":[self getThreadInfo],
                               @"time":[self getCurrentDate],
                               @"vcName":vcName
        };
        [_monitorDataArr addObject:dict];

        if (self.logStatus) {
            NSLog(@"DPAppDoctorLog: %@",dict);
        }
        
        if(self.aMonitorDataBlock) {
            self.aMonitorDataBlock(dict);
        }
    }
}
//获取CPU使用量
- (NSString *)cpuUsageInfo {
    NSString *cpuUsageInfo = @"-1";
    kern_return_t kr;
    //任务信息
    task_info_data_t tinfo;
    //任务个数
    mach_msg_type_number_t task_info_count;
    //最大1024
    task_info_count = TASK_INFO_MAX;
    //获取当前执行的任务信息和个数
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    //判断是否获取成功
    if (kr != KERN_SUCCESS) {
        cpuUsageInfo = @"-1";
    }
    //基础任务
    task_basic_info_t      basic_info;
    //线程数组
    thread_array_t        thread_list;
    //线程个数
    mach_msg_type_number_t thread_count;
    //线程信息
    thread_info_data_t    thinfo;
    //线程信息个数
    mach_msg_type_number_t thread_info_count;
    //基础线程信息
    thread_basic_info_t basic_info_th;
    //存储运行的线程
    uint32_t stat_thread = 0;
    
    basic_info = (task_basic_info_t)tinfo;
    //获取当前执行的线程数组和个数
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    //判断是否成功
    if (kr != KERN_SUCCESS) {
        cpuUsageInfo = @"-1";
    }
    
    if (thread_count > 0) {
        stat_thread += thread_count;
    }
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    //遍历所有线程
    for (j = 0; j < (int)thread_count; j++) {
        //线程信息最大个数
        thread_info_count = THREAD_INFO_MAX;
        //获取线程的基础信息和信息个数
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        //判断是否成功
        if (kr != KERN_SUCCESS) {
            cpuUsageInfo = @"-1";
        }
        //转换基础信息类型
        basic_info_th = (thread_basic_info_t)thinfo;
        //判断不是闲置线程信息
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            //使用时间计算
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->user_time.microseconds + basic_info_th->system_time.microseconds;
            //使用率计算
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
    }
    //释放指针
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    //成功
    assert(kr == KERN_SUCCESS);
    //返回CPU使用率
    cpuUsageInfo = [NSString stringWithFormat:@"%.0f",roundf(tot_cpu)];
    return cpuUsageInfo;
}
//获取内存使用量
- (NSString *)getMemoryInfo {
    NSString *memoryInfo = @"-1";
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if (kernelReturn == KERN_SUCCESS) {
        int64_t memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
        memoryInfo = [NSString stringWithFormat:@"%.1f",memoryUsageInByte/1024.0/1024.0];
    }
    return memoryInfo;
}
//流量统计
- (NSString *)getTraffic {
    NSString *oldTrafficValue = _trafficValue;
    
    BOOL success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    int WiFiSent = 0;
    int WiFiReceived = 0;
    int WWANSent = 0;
    int WWANReceived = 0;
    NSString *name=[[NSString alloc]init];
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            
            if (cursor->ifa_addr->sa_family == AF_LINK) {
                //wifi消耗流量
                if ([name hasPrefix:@"en"]) {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                }
                
                //移动网络消耗流量
                if ([name hasPrefix:@"pdp_ip0"]) {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    
    self.trafficValue = [NSString stringWithFormat:@"%d",WiFiSent+WiFiReceived+WWANSent+WWANReceived];
    oldTrafficValue = [NSString stringWithFormat:@"%.0f",([_trafficValue intValue]-[oldTrafficValue intValue])/1024.0];
    return oldTrafficValue;
}
//获取超过内存超过警戒值的线程
- (NSMutableArray *)getThreadInfo {
    //int
    const task_t this_task = mach_task_self();
    //int 组成的数组比如 thread[1] = 5635
    thread_act_array_t threads;
    //mach_msg_type_number_t 是 int 类型
    mach_msg_type_number_t thread_count = 0;
    //根据当前 task 获取所有线程
    task_threads(this_task, &threads, &thread_count);
    
    NSMutableArray *arrThreadInfo = [NSMutableArray new];
    for (int i = 0; i < thread_count; i++) {
        thread_info_data_t threadInfo;
        thread_basic_info_t threadBaseInfo;
        mach_msg_type_number_t threadInfoCount = THREAD_INFO_MAX;
        if (thread_info((thread_act_t)threads[i], THREAD_BASIC_INFO, (thread_info_t)threadInfo, &threadInfoCount) == KERN_SUCCESS) {
            threadBaseInfo = (thread_basic_info_t)threadInfo;
            if (!(threadBaseInfo->flags & TH_FLAGS_IDLE)) {
                integer_t cpuUsage = threadBaseInfo->cpu_usage / 10;
                _cpuUsageMax = _cpuUsageMax > 0 ? _cpuUsageMax : CPUMONITORRATE;
                if (cpuUsage > _cpuUsageMax) {
                    //cup 消耗大于设置值时打印和记录堆栈
                    NSString *reStr = smStackOfThread(threads[i]);
                    [arrThreadInfo addObject:reStr];
                }
            }
        }
    }
    return arrThreadInfo;
}
//获取当前系统时间
- (NSString *)getCurrentDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
//获取当前屏幕显示的VC
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [window subviews].lastObject;
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = [self getTopControllerWithVC:nextResponder];
    } else {
        result = window.rootViewController;
    }
    return result;
}
// 获取最顶层正在显示的VC
- (UIViewController *)getTopControllerWithVC:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        vc = nav.viewControllers.lastObject;
        return [self getTopControllerWithVC:vc];
    } else if ([vc isKindOfClass: [UITabBarController class]]) {
        UITabBarController *tabVC = (UITabBarController *)vc;
        vc = tabVC.viewControllers[tabVC.selectedIndex];
        return [self getTopControllerWithVC:vc];
    } else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.childViewControllers.count > 0) {
            vc = vc.childViewControllers.lastObject;
            return [self getTopControllerWithVC:vc];
        }
    }
    return vc;
}
@end

#endif
