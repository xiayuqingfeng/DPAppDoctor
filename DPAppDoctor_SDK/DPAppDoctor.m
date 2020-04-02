//
//  ZhcwCollegeSDK.m
//  ZhcwCollegeSDK
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "DPAppDoctor.h"

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
@property (nonatomic, strong) UILabel *gpuLabel;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@end

static DPAppDoctor *_zhcwTool = nil;

@implementation DPAppDoctor
- (void)setIsCPU:(BOOL)isCPU {
    _isCPU = isCPU;
    [self updateWindowView];
}

- (void)setIsGPU:(BOOL)isGPU {
    _isGPU = isGPU;
    [self updateWindowView];
}

- (void)updateWindowView {
    UIWindow *aWindow = [[UIApplication sharedApplication] delegate].window;
    
    if (_aWindowView == nil) {
        self.aWindowView = [[UIView alloc] initWithFrame:CGRectMake(0, DPNavibarHeight, 100, 0)];
        _aWindowView.backgroundColor = [UIColor blackColor];
        _aWindowView.clipsToBounds = NO;
        _aWindowView.layer.cornerRadius = 15;
        _aWindowView.layer.masksToBounds = YES;
        
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewMoved:)];
        [_aWindowView addGestureRecognizer:self.panGestureRecognizer];
    }
    
    CGFloat maxY = 0;
    if (_cpuLabel == nil) {
        self.cpuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_aWindowView.frame), 40)];
        _cpuLabel.font = [UIFont systemFontOfSize:18];
        _cpuLabel.textColor = [UIColor redColor];
        _cpuLabel.text = @"CPU:0%";
        [_aWindowView addSubview:_cpuLabel];
        
    }
    if (_isCPU == YES) {
        maxY = CGRectGetMaxY(_cpuLabel.frame);
        [_aWindowView addSubview:_cpuLabel];
    }else {
        maxY = 0;
        [_cpuLabel removeFromSuperview];
    }
    
    if (_gpuLabel == nil) {
        self.gpuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY, CGRectGetWidth(_aWindowView.frame), 40)];
        _gpuLabel.font = [UIFont systemFontOfSize:18];
        _gpuLabel.textColor = [UIColor redColor];
        _gpuLabel.text = @"GPU:0%";
        [_aWindowView addSubview:_gpuLabel];
        
    }
    if (_isGPU == YES) {
        maxY = CGRectGetMaxY(_gpuLabel.frame);
        [_aWindowView addSubview:_gpuLabel];
    }else {
        maxY = 0;
        [_gpuLabel removeFromSuperview];
    }
    
    __block typeof(self) __weak weak_self = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weak_self.aWindowView.frame = CGRectMake(CGRectGetWidth(aWindow.frame)-CGRectGetWidth(weak_self.aWindowView.frame), (CGRectGetHeight(aWindow.frame)-maxY)/2, CGRectGetWidth(weak_self.aWindowView.frame), maxY);
        [aWindow addSubview:weak_self.aWindowView];
    });
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
