//
//  DPAppDoctorViewColorView.m
//  DPAppDoctorViewColorView
//
//  Created by yupeng xia on 2021/4/13.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import "DPAppDoctorViewColorView.h"
#ifdef DPAppDoctorDebug

#import "DPAppDoctor.h"

@interface DPAppDoctorViewColorView () {
    CGFloat viewMinY;
    
    UIView *superView;

    UIButton *viewBtn;
    UIButton *labelBtn;
    UIButton *buttonBtn;
    UIButton *textViewBtn;
    UIButton *textFieldBtn;
}
@end

@implementation DPAppDoctorViewColorView
- (id)initWithBtnMinY:(CGFloat)aBtnMinY {
    self = [super init];
    if (self) {
        viewMinY = aBtnMinY;

        superView = [UIApplication sharedApplication].keyWindowDP;
        
        self.frame = CGRectMake(0, viewMinY, DPFrameWidth(150), 0);
        self.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = NO;
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        [superView addSubview:self];

        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewMoved:)];
        [self addGestureRecognizer:panGestureRecognizer];

        CGFloat btnHeight = DPFrameHeight(25);

        viewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        viewBtn.frame = CGRectMake(0, btnHeight*0, self.widthDP, btnHeight);
        viewBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        viewBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [viewBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [viewBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [viewBtn setTitle:@"viewColor(打开)" forState:UIControlStateNormal];
        [viewBtn setTitle:@"viewColor(关闭)" forState:UIControlStateSelected];
        [viewBtn addTarget:self action:@selector(viewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:viewBtn];
        
        labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        labelBtn.frame = CGRectMake(0, btnHeight*1, self.widthDP, btnHeight);
        labelBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        labelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [labelBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [labelBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [labelBtn setTitle:@"labelColor(打开)" forState:UIControlStateNormal];
        [labelBtn setTitle:@"labelColor(关闭)" forState:UIControlStateSelected];
        [labelBtn addTarget:self action:@selector(labelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:labelBtn];
        
        buttonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBtn.frame = CGRectMake(0, btnHeight*2, self.widthDP, btnHeight);
        buttonBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        buttonBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [buttonBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [buttonBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [buttonBtn setTitle:@"buttonColor(打开)" forState:UIControlStateNormal];
        [buttonBtn setTitle:@"buttonColor(关闭)" forState:UIControlStateSelected];
        [buttonBtn addTarget:self action:@selector(buttonBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonBtn];
        
        textViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        textViewBtn.frame = CGRectMake(0, btnHeight*3, self.widthDP, btnHeight);
        textViewBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        textViewBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [textViewBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [textViewBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [textViewBtn setTitle:@"textViewColor(打开)" forState:UIControlStateNormal];
        [textViewBtn setTitle:@"textViewColor(关闭)" forState:UIControlStateSelected];
        [textViewBtn addTarget:self action:@selector(textViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:textViewBtn];
        
        textFieldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        textFieldBtn.frame = CGRectMake(0, btnHeight*4, self.widthDP, btnHeight);
        textFieldBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        textFieldBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [textFieldBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [textFieldBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [textFieldBtn setTitle:@"textFieldColor(打开)" forState:UIControlStateNormal];
        [textFieldBtn setTitle:@"textFieldColor(关闭)" forState:UIControlStateSelected];
        [textFieldBtn addTarget:self action:@selector(textFieldBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:textFieldBtn];
        
        self.heightDP = textFieldBtn.yMaxDP;
        
        [self setButtonSelect];
    }
    return self;
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
- (void)viewBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    [self setColorSetDic];
}
- (void)labelBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    [self setColorSetDic];
}
- (void)textViewBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    [self setColorSetDic];
}
- (void)buttonBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    [self setColorSetDic];
}
- (void)textFieldBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    [self setColorSetDic];
}

- (void)setButtonSelect {
    NSDictionary *colorDic = [[DPAppDoctorManager shareInstance] valueForKey:@"colorSetDic"];
    if (colorDic != nil) {
        viewBtn.selected = ((NSString *)[colorDic objectForKey:@"UIView"]).integerValue;
        labelBtn.selected = ((NSString *)[colorDic objectForKey:@"UILabel"]).integerValue;
        buttonBtn.selected = ((NSString *)[colorDic objectForKey:@"UIButton"]).integerValue;
        textViewBtn.selected = ((NSString *)[colorDic objectForKey:@"UITextView"]).integerValue;
        textFieldBtn.selected = ((NSString *)[colorDic objectForKey:@"UITextField"]).integerValue;
    }
}

- (void)setColorSetDic {
    NSDictionary *aDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"colorSetDic"];
    if (aDic == nil) {
        aDic = @{};
    }
    NSMutableDictionary *aMutaDic = [NSMutableDictionary dictionaryWithDictionary:aDic];
    [aMutaDic setValue:viewBtn.selected ? @"1" : @"0" forKey:@"UIView"];
    [aMutaDic setValue:labelBtn.selected ? @"1" : @"0" forKey:@"UILabel"];
    [aMutaDic setValue:buttonBtn.selected ? @"1" : @"0" forKey:@"UIButton"];
    [aMutaDic setValue:textViewBtn.selected ? @"1" : @"0" forKey:@"UITextView"];
    [aMutaDic setValue:textFieldBtn.selected ? @"1" : @"0" forKey:@"UITextField"];
    
    [[DPAppDoctorManager shareInstance] setValue:aMutaDic forKey:@"colorSetDic"];
    
    [[NSUserDefaults standardUserDefaults] setValue:aMutaDic forKey:@"colorSetDic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dpChangeViewColor" object:nil];
}
@end

#endif
