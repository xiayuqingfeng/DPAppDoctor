//
//  DPMonitorView.m
//  DPAppDoctor
//
//  Created by yupeng xia on 2021/4/13.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import "DPMonitorView.h"
#import "DPHeaderObject.h"
#import "XLMonitorHandle.h"

@interface DPMonitorView () {
    CGFloat viewMinY;
    
    UIView *superView;

    UILabel *cpuLabel;
    UILabel *memoryLabel;
    UILabel *fpsLabel;
    UILabel *trafficLabel;
}
@end

@implementation DPMonitorView
- (id)initWithBtnMinY:(CGFloat)aBtnMinY {
    self = [super init];
    if (self) {
        viewMinY = aBtnMinY;
        
        superView = [UIApplication sharedApplication].keyWindowDP;
        self.frame = CGRectMake(0, viewMinY, DPFrameWidth(100), 0);
        self.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = NO;
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        [superView addSubview:self];

        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewMoved:)];
        [self addGestureRecognizer:panGestureRecognizer];
        
        cpuLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.frame)-5, 25)];
        cpuLabel.adjustsFontSizeToFitWidth = YES;
        cpuLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18];
        cpuLabel.textColor = [UIColor greenColor];
        cpuLabel.text = @"CPU:0%";
        [self addSubview:cpuLabel];
        
        memoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(cpuLabel.frame), CGRectGetWidth(self.frame)-5, 25)];
        memoryLabel.adjustsFontSizeToFitWidth = YES;
        memoryLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18];
        memoryLabel.textColor = [UIColor greenColor];
        memoryLabel.text = @"MS:0%MB";
        [self addSubview:memoryLabel];

        fpsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(memoryLabel.frame), CGRectGetWidth(self.frame)-5, 25)];
        fpsLabel.adjustsFontSizeToFitWidth = YES;
        fpsLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18];
        fpsLabel.textColor = [UIColor greenColor];
        fpsLabel.text = @"FPS:0%";
        [self addSubview:fpsLabel];
        
        trafficLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(fpsLabel.frame), CGRectGetWidth(self.frame)-5, 25)];
        trafficLabel.adjustsFontSizeToFitWidth = YES;
        trafficLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18];
        trafficLabel.textColor = [UIColor greenColor];
        trafficLabel.text = @"TRA:0kb";
        [self addSubview:trafficLabel];
        
        self.heightDP = trafficLabel.yMaxDP;

        [[XLMonitorHandle shareInstance] setLogStatus:YES];
        [[XLMonitorHandle shareInstance] setCpuUsageMax:35];
        arc_dp_block(cpuLabel);
        arc_dp_block(memoryLabel);
        arc_dp_block(fpsLabel);
        arc_dp_block(trafficLabel);
        [XLMonitorHandle shareInstance].aMonitorDataBlock = ^(NSDictionary * _Nonnull aMonitorData) {
            NSString *cpuValue = [NSString stringWithFormat:@"%@",aMonitorData[@"cpuUsage"]];
            weak_dp_cpuLabel.text = [NSString stringWithFormat:@"CPU:%@%%",cpuValue];
            if (cpuValue.intValue >= 85) {
                weak_dp_cpuLabel.textColor = [UIColor redColor];
            } else if (cpuValue.intValue>=60 && cpuValue.intValue<85) {
                weak_dp_cpuLabel.textColor = [UIColor yellowColor];
            } else {
                weak_dp_cpuLabel.textColor = [UIColor greenColor];
            }
            
            weak_dp_memoryLabel.text = [NSString stringWithFormat:@"MS:%@MB",aMonitorData[@"memory"]];
            
            NSString *fpsValue = [NSString stringWithFormat:@"%@",aMonitorData[@"fps"]];
            weak_dp_fpsLabel.text = [NSString stringWithFormat:@"FPS:%@",fpsValue];
            if (fpsValue.intValue >= 55) {
                weak_dp_fpsLabel.textColor = [UIColor greenColor];
            } else if (fpsValue.intValue>=50 && fpsValue.intValue<55) {
                weak_dp_fpsLabel.textColor = [UIColor yellowColor];
            } else {
                weak_dp_fpsLabel.textColor = [UIColor redColor];
            }
            
            weak_dp_trafficLabel.text = [NSString stringWithFormat:@"TRA:%@kb",aMonitorData[@"traffic"]];
        };
    }
    return self;
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (hidden == YES) {
        [[XLMonitorHandle shareInstance] stopMonitor];
    }else {
        [[XLMonitorHandle shareInstance] startMonitorFpsAndCpuUsage];
    }
}

- (void)dragViewMoved:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        UIWindow *aWindow = [UIApplication sharedApplication].keyWindowDP;
        
        CGPoint translation = [panGestureRecognizer translationInView:self];
        self.center = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
        
        CGRect aFrame = self.frame;
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
        self.frame = aFrame;
        
        [panGestureRecognizer setTranslation:CGPointZero inView:aWindow];
    }
}
@end
