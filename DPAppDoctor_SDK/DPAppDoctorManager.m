//
//  DPAppDoctorManager.m
//  DPAppDoctorManager
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "DPAppDoctorManager.h"
#ifdef DPAppDoctorDebug

#import "DPAppDoctorLogView.h"
#import "DPAppDoctorMonitorView.h"
#import "DPAppDoctorViewColorView.h"

@interface DPAppDoctorManager (){
    
}
//测试项选择模块
@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, strong) UIButton *logBtn;
@property (nonatomic, strong) UIButton *leakedBtn;
@property (nonatomic, strong) UIButton *monitorBtn;
@property (nonatomic, strong) UIButton *viewColorBtn;
@property (nonatomic, strong) UIButton *otherBtn;

//日志View
@property (nonatomic, strong) DPAppDoctorLogView *aLogView;
//性能检测View
@property (nonatomic, strong) DPAppDoctorMonitorView *aMonitorView;
//控件颜色View
@property (nonatomic, strong) DPAppDoctorViewColorView *aViewColorView;

///颜色设置
@property (nonatomic, strong) NSDictionary *colorSetDic;
@end

static DPAppDoctorManager *_zhcwTool = nil;
@implementation DPAppDoctorManager
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_zhcwTool == nil) {
            _zhcwTool = [[self alloc]init];
        }
    });
    return _zhcwTool;
}

- (id)init {
    self = [super init];
    if (self) {
        self.colorSetDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"colorSetDic"];
    }
    return self;
}

//测试项选择模块
- (void)updateTestView {
    UIWindow *aWindow = [UIApplication sharedApplication].keyWindowDP;
    if (_isShowTest) {
        _testView.hidden = NO;
        
        if (_testView == nil) {
            self.testView = [[UIView alloc] init];
            _testView.yDP = DPFrameHeight(100);
            _testView.backgroundColor = DPRgba(0, 0, 0, 1);
            _testView.clipsToBounds = YES;
            [aWindow addSubview:_testView];
            
            //拖动
            UIPanGestureRecognizer *testViewTap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(testViewTapAction:)];
            [_testView addGestureRecognizer:testViewTap];
            
            self.titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _titleBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_titleBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [_titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [_titleBtn setTitle:@"Test" forState:UIControlStateNormal];
            [_titleBtn setTitle:@"Test(关闭)" forState:UIControlStateHighlighted];
            [_titleBtn setTitle:@"Test(关闭)" forState:UIControlStateSelected];
            [_titleBtn addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_testView addSubview:_titleBtn];
            
            self.logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _logBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_logBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_logBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [_logBtn setTitle:@"日志打印(打开)" forState:UIControlStateNormal];
            [_logBtn setTitle:@"日志打印(关闭)" forState:UIControlStateSelected];
            [_logBtn addTarget:self action:@selector(logBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_testView addSubview:_logBtn];
         
            self.leakedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _leakedBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_leakedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_leakedBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [_leakedBtn setTitle:@"内存泄露监测(打开)" forState:UIControlStateNormal];
            [_leakedBtn setTitle:@"内存泄露监测(关闭)" forState:UIControlStateSelected];
            [_leakedBtn addTarget:self action:@selector(leakedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_testView addSubview:_leakedBtn];
            
            self.monitorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _monitorBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_monitorBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_monitorBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [_monitorBtn setTitle:@"C、G、F监测(打开)" forState:UIControlStateNormal];
            [_monitorBtn setTitle:@"C、G、F监测(关闭)" forState:UIControlStateSelected];
            [_monitorBtn addTarget:self action:@selector(monitorBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_testView addSubview:_monitorBtn];
            
            self.viewColorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _viewColorBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_viewColorBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_viewColorBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [_viewColorBtn setTitle:@"UI布局(打开)" forState:UIControlStateNormal];
            [_viewColorBtn setTitle:@"UI布局(关闭)" forState:UIControlStateSelected];
            [_viewColorBtn addTarget:self action:@selector(viewColorBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_testView addSubview:_viewColorBtn];
            
            self.otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _otherBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_otherBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_otherBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [_otherBtn setTitle:@"DIY(打开)" forState:UIControlStateNormal];
            [_otherBtn setTitle:@"DIY(关闭)" forState:UIControlStateSelected];
            [_otherBtn addTarget:self action:@selector(otherBtnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_testView addSubview:_otherBtn];
        }
        
        if (_titleBtn.selected == NO) {
            _testView.frame = CGRectMake(_testView.superview.widthDP-DPFrameWidth(50), _testView.yDP, DPFrameWidth(50), DPFrameHeight(30));
            _titleBtn.frame = _testView.bounds;
        }else {
            _testView.frame = CGRectMake(_testView.superview.widthDP-DPFrameWidth(150), _testView.yDP, DPFrameWidth(150), DPFrameHeight(30)*6);
            _titleBtn.frame = CGRectMake(0, DPFrameHeight(30)*0, _testView.widthDP, DPFrameHeight(30));
            _logBtn.frame = CGRectMake(0, DPFrameHeight(30)*1, _testView.widthDP, DPFrameHeight(30));
            _leakedBtn.frame = CGRectMake(0, DPFrameHeight(30)*2, _testView.widthDP, DPFrameHeight(30));
            _monitorBtn.frame = CGRectMake(0, DPFrameHeight(30)*3, _testView.widthDP, DPFrameHeight(30));
            _viewColorBtn.frame = CGRectMake(0, DPFrameHeight(30)*4, _testView.widthDP, DPFrameHeight(30));
            _otherBtn.frame = CGRectMake(0, DPFrameHeight(30)*5, _testView.widthDP, DPFrameHeight(30));
        }
        [_testView setDPRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft radius:5 borderCorners:DPBorderDirectionAllCorners borderWidth:0 borderColor:nil];
    }else {
        _testView.hidden = YES;
    }
    
    [self logBtnAction:nil];
    [self leakedBtnAction:nil];
    [self monitorBtnAction:nil];
    [self viewColorBtnAction:nil];
    [self otherBtnBtnAction:nil];
}
//拖动
- (void)testViewTapAction:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        UIWindow *aWindow = [UIApplication sharedApplication].keyWindowDP;
        
        CGPoint translation = [panGestureRecognizer translationInView:_testView];
        _testView.centerYDP = _testView.center.y + translation.y;
        
        if (_testView.yDP < 0) {
            _testView.yDP = 0;
        }
        if (_testView.yMaxDP > aWindow.heightDP) {
            _testView.yMaxDP = aWindow.heightDP-_testView.heightDP;
        }
        [panGestureRecognizer setTranslation:CGPointZero inView:aWindow];
    }
}
- (void)titleBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    [self updateTestView];
}
- (void)logBtnAction:(UIButton *)button {
    BOOL bol = NO;
    if (button == nil) {
        bol = [[NSUserDefaults standardUserDefaults] boolForKey:@"logBtn"];
    }else {
        button.selected = !button.selected;
        bol = button.selected;
        [[NSUserDefaults standardUserDefaults] setBool:bol forKey:@"logBtn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    self.isLogOut = bol;
}
- (void)leakedBtnAction:(UIButton *)button {
    BOOL bol = NO;
    if (button == nil) {
        bol = [[NSUserDefaults standardUserDefaults] boolForKey:@"leakedBtn"];
    }else {
        button.selected = !button.selected;
        bol = button.selected;
        [[NSUserDefaults standardUserDefaults] setBool:bol forKey:@"leakedBtn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    self.isLeaked = bol;
}
- (void)monitorBtnAction:(UIButton *)button {
    BOOL bol = NO;
    if (button == nil) {
        bol = [[NSUserDefaults standardUserDefaults] boolForKey:@"monitorBtn"];
    }else {
        button.selected = !button.selected;
        bol = button.selected;
        [[NSUserDefaults standardUserDefaults] setBool:bol forKey:@"monitorBtn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    self.isMonitor = bol;
}
- (void)viewColorBtnAction:(UIButton *)button {
    BOOL bol = NO;
    if (button == nil) {
        bol = [[NSUserDefaults standardUserDefaults] boolForKey:@"viewColorBtn"];
    }else {
        button.selected = !button.selected;
        bol = button.selected;
        [[NSUserDefaults standardUserDefaults] setBool:bol forKey:@"viewColorBtn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    self.isViewColor = bol;
}
- (void)otherBtnBtnAction:(UIButton *)button {
    BOOL bol = NO;
    if (button == nil) {
        bol = [[NSUserDefaults standardUserDefaults] boolForKey:@"otherBtn"];
    }else {
        button.selected = !button.selected;
        bol = button.selected;
        [[NSUserDefaults standardUserDefaults] setBool:bol forKey:@"otherBtn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    self.isDiy = bol;
}

#pragma mark <-------------Setter_methods------------->
- (void)setIsShowTest:(BOOL)isShowTest {
    _isShowTest = isShowTest;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateTestView];
    });
}
- (void)setIsLogOut:(BOOL)isLogOut {
    _isLogOut = isLogOut;
    self.logBtn.selected = _isLogOut;
    
    if (_aLogView == nil) {
        self.aLogView = [[DPAppDoctorLogView alloc] initWithBtnMinY:[UIApplication sharedApplication].keyWindowDP.heightDP/2];
    }
    _aLogView.hidden = !_isLogOut;
}
- (void)setIsLeaked:(BOOL)isLeaked {
    _isLeaked = isLeaked;
    self.leakedBtn.selected = _isLeaked;
}
- (void)setIsMonitor:(BOOL)isMonitor {
    _isMonitor = isMonitor;
    self.monitorBtn.selected = _isMonitor;
    
    if (_aMonitorView == nil) {
        self.aMonitorView = [[DPAppDoctorMonitorView alloc] initWithBtnMinY:[UIApplication sharedApplication].keyWindowDP.heightDP/2-120];
    }
    _aMonitorView.hidden = !_isMonitor;
}
- (void)setIsViewColor:(BOOL)isViewColor {
    _isViewColor = isViewColor;
    self.viewColorBtn.selected = _isViewColor;
    
    if (_aViewColorView == nil) {
        self.aViewColorView = [[DPAppDoctorViewColorView alloc] initWithBtnMinY:[UIApplication sharedApplication].keyWindowDP.heightDP/2+60];
    }
    _aViewColorView.hidden = !_isViewColor;
}
- (void)setIsDiy:(BOOL)isDiy {
    _isDiy = isDiy;
    self.otherBtn.selected = _isDiy;
    
    if (self.DPdiyBlock) {
        self.DPdiyBlock(_isDiy);
    }
}
@end

#endif
