//
//  ZhcwCollegeSDK.m
//  ZhcwCollegeSDK
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "DPAppDoctor.h"
#ifdef DPAppDoctorDebug

#import "XLMonitorHandle.h"

#define DPScreenHeight [UIScreen mainScreen].bounds.size.height
#define DPScreenWidth [UIScreen mainScreen].bounds.size.width

#define DPIS_iPhoneX (((DPScreenWidth == 375 && DPScreenHeight == 812)||(DPScreenWidth == 812 && DPScreenHeight == 375) )?true:false)
#define DPIS_iPhoneXS DPIS_iPhoneX
#define DPIS_iPhoneXR (((DPScreenWidth == 414 && DPScreenHeight == 896)||(DPScreenWidth == 896 && DPScreenHeight == 414) )?true:false)
#define DPIS_iPhoneXS_Max DPIS_iPhoneXR
#define DPIS_iPhoneXAll (DPIS_iPhoneX || DPIS_iPhoneXS || DPIS_iPhoneXR || DPIS_iPhoneXS_Max)

#define DPStatusbarH (CGRectIsEmpty([UIApplication sharedApplication].statusBarFrame)?(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)?20:(DPIS_iPhoneXAll ? 44 : 20)):CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define DPNavibarHeight (DPIS_iPhoneXAll ? 88 : 64)

@interface DPAppDoctor (){
    
}
@property (nonatomic, strong) UIView *aWindowView;
@property (nonatomic, strong) UILabel *cpuLabel;
@property (nonatomic, strong) UILabel *memoryLabel;
@property (nonatomic, strong) UILabel *fpsLabel;
@property (nonatomic, strong) UILabel *trafficLabel;
@end

static DPAppDoctor *_zhcwTool = nil;

@implementation DPAppDoctor
- (void)setIsMonitor:(BOOL)isMonitor {
    _isMonitor = isMonitor;
    [self updateWindowView];
}

- (void)updateWindowView {
    UIWindow *aWindow = [[UIApplication sharedApplication] delegate].window;
    
    if (_isMonitor) {
        if (_aWindowView == nil) {
            self.aWindowView = [[UIView alloc] initWithFrame:CGRectMake(0, DPNavibarHeight, 100, 0)];
            _aWindowView.backgroundColor = [UIColor blackColor];
            _aWindowView.clipsToBounds = NO;
            _aWindowView.layer.cornerRadius = 15;
            _aWindowView.layer.masksToBounds = YES;
            [aWindow addSubview:_aWindowView];
            
            UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewMoved:)];
            [_aWindowView addGestureRecognizer:panGestureRecognizer];
        }

        if (_cpuLabel == nil) {
            self.cpuLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(_aWindowView.frame)-5, 25)];
            _cpuLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18];
            _cpuLabel.textColor = [UIColor redColor];
            _cpuLabel.text = @"CPU:0%";
            [_aWindowView addSubview:_cpuLabel];
        }
        
        if (_memoryLabel == nil) {
            self.memoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_cpuLabel.frame), CGRectGetWidth(_aWindowView.frame)-5, 25)];
            _memoryLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18];
            _memoryLabel.textColor = [UIColor redColor];
            _memoryLabel.text = @"MS:0%MB";
            [_aWindowView addSubview:_memoryLabel];
        }

        if (_fpsLabel == nil) {
            self.fpsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_memoryLabel.frame), CGRectGetWidth(_aWindowView.frame)-5, 25)];
            _fpsLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18];
            _fpsLabel.textColor = [UIColor redColor];
            _fpsLabel.text = @"FPS:0%";
            [_aWindowView addSubview:_fpsLabel];
        }

        if (_trafficLabel == nil) {
            self.trafficLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_fpsLabel.frame), CGRectGetWidth(_aWindowView.frame)-5, 25)];
            _trafficLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18];
            _trafficLabel.textColor = [UIColor redColor];
            _trafficLabel.text = @"TRA:0kb";
            [_aWindowView addSubview:_trafficLabel];
        }
        
        _aWindowView.frame = CGRectMake(CGRectGetWidth(aWindow.frame)-CGRectGetWidth(_aWindowView.frame), (CGRectGetHeight(aWindow.frame)-CGRectGetMaxY(_trafficLabel.frame))/2, CGRectGetWidth(_aWindowView.frame), CGRectGetMaxY(_trafficLabel.frame));

        [[XLMonitorHandle shareInstance] setLogStatus:YES];
        [[XLMonitorHandle shareInstance] setCpuUsageMax:35];
        [[XLMonitorHandle shareInstance] startMonitorFpsAndCpuUsage];
        __block typeof(self) __weak weak_self = self;
        [XLMonitorHandle shareInstance].aMonitorDataBlock = ^(NSDictionary * _Nonnull aMonitorData) {
            weak_self.cpuLabel.text = [NSString stringWithFormat:@"CPU:%@%%",aMonitorData[@"cpuUsage"]];
            weak_self.memoryLabel.text = [NSString stringWithFormat:@"MS:%@MB",aMonitorData[@"memory"]];
            weak_self.fpsLabel.text = [NSString stringWithFormat:@"FPS:%@",aMonitorData[@"fps"]];
            weak_self.trafficLabel.text = [NSString stringWithFormat:@"TRA:%@kb",aMonitorData[@"traffic"]];
            [aWindow addSubview:weak_self.aWindowView];
        };
    }else {
        [[XLMonitorHandle shareInstance] stopMonitor];
        [_aWindowView removeFromSuperview];
    }
}

- (void)dragViewMoved:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        UIWindow *aWindow = [[UIApplication sharedApplication] delegate].window;
        
        CGPoint translation = [panGestureRecognizer translationInView:_aWindowView];
        _aWindowView.center = CGPointMake(_aWindowView.center.x + translation.x, _aWindowView.center.y + translation.y);
        
        CGRect aFrame = _aWindowView.frame;
        if (CGRectGetMinX(aFrame) < 0) {
            aFrame.origin.x = 0;
        }
        if (CGRectGetMaxX(aFrame) > CGRectGetWidth(aWindow.frame)) {
            aFrame.origin.x = CGRectGetWidth(aWindow.frame)-CGRectGetWidth(aFrame);
        }
        if (CGRectGetMinY(aFrame) < 0) {
            aFrame.origin.y = 0;
        }
        if (CGRectGetMaxY(aFrame) > CGRectGetHeight(aWindow.frame)) {
            aFrame.origin.y = CGRectGetHeight(aWindow.frame)-CGRectGetHeight(aFrame);
        }
        _aWindowView.frame = aFrame;
        
        [panGestureRecognizer setTranslation:CGPointZero inView:aWindow];
    }
}

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_zhcwTool == nil) {
            _zhcwTool = [[self alloc]init];
        }
    });
    return _zhcwTool;
}
@end

#endif
