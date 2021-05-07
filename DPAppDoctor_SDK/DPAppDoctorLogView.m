//
//  DPAppDoctorLogView.m
//  DPAppDoctorLogView
//
//  Created by yupeng xia on 2021/4/13.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import "DPAppDoctorLogView.h"
#ifdef DPAppDoctorDebug

@interface DPAppDoctorLogView () <UITextViewDelegate>{
    CGFloat viewMinY;
    
    UIView *superView;
    
    UIButton *openBtn;
    UITextView *countTextView;
    UITextView *searchTextView;
    UIButton *deleteCountBtn;
    UIButton *deleteSearchBtn;
    UIButton *fontBtn;
    UIButton *nextBtn;
    UIButton *searchBtn;
    
    BOOL isLogOut;
    NSMutableString *sumLogStr;
    NSArray <NSValue *>*rangArray;
    NSInteger searchIndex;
}

@property (nonatomic, strong) NSString *logOutStr;
@end

@implementation DPAppDoctorLogView
- (id)initWithBtnMinY:(CGFloat)aBtnMinY {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        viewMinY = aBtnMinY;
        isLogOut = YES;
        
        superView = [UIApplication sharedApplication].keyWindowDP;
        
        self.frame = superView.bounds;
        self.backgroundColor = [UIColor blackColor];
        self.hidden = YES;
        [superView addSubview:self];
        
        openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        openBtn.titleLabel.numberOfLines = 0;
        [openBtn setTitle:@"打\n开\n日\n志" forState:UIControlStateNormal];
        [openBtn setTitle:@"关\n闭\n日\n志" forState:UIControlStateSelected];
        [openBtn sizeToFit];
        openBtn.selected = NO;
        [openBtn addTarget:self action:@selector(openBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:openBtn];
        
        countTextView = [[UITextView alloc] init];
        countTextView.delegate = self;
        countTextView.backgroundColor = [UIColor clearColor];
        countTextView.layer.borderWidth = 1;
        countTextView.layer.borderColor = [UIColor greenColor].CGColor;
        countTextView.layer.cornerRadius = 4;
        countTextView.layoutManager.allowsNonContiguousLayout = YES;
        countTextView.textColor = [UIColor whiteColor];
        if (self.hidden == NO) {
            [countTextView becomeFirstResponder];
        }
        [self addSubview:countTextView];
        
        searchTextView = [[UITextView alloc] init];
        searchTextView.delegate = self;
        searchTextView.backgroundColor = [UIColor clearColor];
        searchTextView.layer.masksToBounds = YES;
        searchTextView.layer.borderWidth = 1;
        searchTextView.layer.borderColor = [UIColor orangeColor].CGColor;
        searchTextView.layer.cornerRadius = 4;
        searchTextView.textColor = [UIColor whiteColor];
        searchTextView.font = [UIFont systemFontOfSize:16];
        [self addSubview:searchTextView];
        
        deleteCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteCountBtn.layer.cornerRadius = 4;
        deleteCountBtn.backgroundColor = [UIColor redColor];
        deleteCountBtn.titleLabel.numberOfLines = 0;
        deleteCountBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [deleteCountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteCountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [deleteCountBtn setTitle:@"清空\n日志" forState:UIControlStateNormal];
        [deleteCountBtn addTarget:self action:@selector(deleteCountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteCountBtn];
        
        deleteSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteSearchBtn.layer.cornerRadius = 4;
        deleteSearchBtn.backgroundColor = [UIColor brownColor];
        deleteSearchBtn.titleLabel.numberOfLines = 0;
        deleteSearchBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        deleteSearchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [deleteSearchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteSearchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [deleteSearchBtn setTitle:@"清空\n搜索" forState:UIControlStateNormal];
        [deleteSearchBtn addTarget:self action:@selector(deleteSearchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteSearchBtn];
        
        fontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fontBtn.layer.cornerRadius = 4;
        fontBtn.backgroundColor = [UIColor darkGrayColor];
        fontBtn.titleLabel.numberOfLines = 0;
        fontBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [fontBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [fontBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        fontBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [fontBtn setTitle:@"上一项" forState:UIControlStateNormal];
        [fontBtn addTarget:self action:@selector(fontBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fontBtn];
        
        nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextBtn.layer.cornerRadius = 4;
        nextBtn.backgroundColor = [UIColor purpleColor];
        nextBtn.titleLabel.numberOfLines = 0;
        nextBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [nextBtn setTitle:@"下一项" forState:UIControlStateNormal];
        [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextBtn];
        
        searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.layer.cornerRadius = 4;
        searchBtn.backgroundColor = [UIColor orangeColor];
        searchBtn.titleLabel.numberOfLines = 0;
        searchBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        searchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:searchBtn];
        
        [self openBtnAction:nil];
    }
    return self;
}
- (void)openBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    
    countTextView.hidden = !openBtn.selected;
    searchTextView.hidden = !openBtn.selected;
    deleteCountBtn.hidden = !openBtn.selected;
    deleteSearchBtn.hidden = !openBtn.selected;
    nextBtn.hidden = !openBtn.selected;
    searchBtn.hidden = !openBtn.selected;
    
    if (!openBtn.selected) {
        [countTextView resignFirstResponder];
        [searchTextView resignFirstResponder];
        
        self.frame = CGRectMake(superView.widthDP-openBtn.widthDP, viewMinY, openBtn.widthDP, openBtn.heightDP);
        openBtn.frame = self.bounds;
    }else {
        self.frame = superView.bounds;
        openBtn.frame = CGRectMake(superView.widthDP-openBtn.widthDP, viewMinY, openBtn.widthDP, openBtn.heightDP);
        countTextView.frame = CGRectMake(0, DPStatusbarH, superView.widthDP-openBtn.widthDP, self.heightDP-DPStatusbarH-DPFrameHeight(140));
        searchTextView.frame = CGRectMake(0, countTextView.yMaxDP+DPFrameHeight(5), countTextView.widthDP, DPFrameHeight(70));
        
        CGFloat minY = searchTextView.yMaxDP+DPFrameHeight(5);
        CGFloat btnWidth = searchTextView.widthDP/5;
        CGFloat btnHeight = DPFrameHeight(50);
        deleteCountBtn.frame = CGRectMake(btnWidth*0, minY, btnWidth, btnHeight);
        deleteSearchBtn.frame = CGRectMake(btnWidth*1, minY, btnWidth, btnHeight);
        fontBtn.frame = CGRectMake(btnWidth*2, minY, btnWidth, btnHeight);
        nextBtn.frame = CGRectMake(btnWidth*3, minY, btnWidth, btnHeight);
        searchBtn.frame = CGRectMake(btnWidth*4, minY, btnWidth, btnHeight);
    }
    [self.superview bringSubviewToFront:self];
}
- (void)deleteCountBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    isLogOut = YES;
    sumLogStr = [@"" mutableCopy];
    countTextView.attributedText = nil;
    if (self.hidden == NO) {
        [countTextView becomeFirstResponder];
    }
    rangArray = nil;
    searchIndex = 0;
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
}
- (void)deleteSearchBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    isLogOut = YES;
    if (self.hidden == NO) {
        [countTextView becomeFirstResponder];
    }
    searchTextView.text = @"";
    rangArray = nil;
    searchIndex = 0;
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
}
- (void)nextBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    if (rangArray.count < 1) {
        return;
    }
    
    if (searchIndex >= rangArray.count) {
        searchIndex = 0;
    }
    NSRange aRange = rangArray[searchIndex].rangeValue;
    if (self.hidden == NO) {
        [countTextView becomeFirstResponder];
    }
    countTextView.selectedRange = aRange;
    [countTextView scrollRangeToVisible:aRange];
    
    [searchBtn setTitle:[NSString stringWithFormat:@"搜索\n(%ld-%ld)",(long)rangArray.count,(long)searchIndex] forState:UIControlStateNormal];
    
    searchIndex = searchIndex+1;
}
- (void)fontBtnAction:(UIButton *)button {
    button.selected = !button.selected;
    
    [UIApplication sharedApplication].keyWindow.tintColor = [UIColor purpleColor];
    
    if (rangArray.count < 1) {
        return;
    }
    
    if (searchIndex < 0) {
        searchIndex = rangArray.count-1;
    }
    NSRange aRange = rangArray[searchIndex].rangeValue;
    if (self.hidden == NO) {
        [countTextView becomeFirstResponder];
    }
    countTextView.selectedRange = aRange;
    [countTextView scrollRangeToVisible:aRange];
    
    [searchBtn setTitle:[NSString stringWithFormat:@"搜索\n(%ld-%ld)",(long)rangArray.count,(long)searchIndex] forState:UIControlStateNormal];
    
    searchIndex = searchIndex-1;
}
- (void)searchBtnAction:(UIButton *)button {
    if (searchTextView.text.length < 1) {
        return;
    }
    
    isLogOut = NO;
    
    [countTextView resignFirstResponder];
    [searchTextView resignFirstResponder];
    
    searchIndex = 0;
    rangArray = [sumLogStr dpRangeOfSubString:searchTextView.text];
    [searchBtn setTitle:[NSString stringWithFormat:@"搜索\n(%ld)",(long)rangArray.count] forState:UIControlStateNormal];
    searchIndex = 0;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:sumLogStr];
    [attr setAttributes:@{
        NSForegroundColorAttributeName:[UIColor whiteColor],
        NSFontAttributeName:[UIFont systemFontOfSize:16]
    }
                  range:NSMakeRange(0, attr.string.length)];
    for (NSValue *aRange in rangArray) {
        [attr setAttributes:@{
            NSForegroundColorAttributeName:[UIColor redColor],
            NSFontAttributeName:[UIFont systemFontOfSize:16]
        }
                      range:aRange.rangeValue];
    }
    countTextView.attributedText = attr;
}

#pragma mark <-------------Setter_methods------------->
- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (hidden) {
        [countTextView resignFirstResponder];
        [searchTextView resignFirstResponder];
    }
}

#pragma mark <-------------键盘遮罩处理------------->
- (void)keyboardWillShow:(NSNotification *)note{
    //获取键盘高度
    NSDictionary* info = [note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    if (kbSize.height > 0.01) {
        arc_block_dp(self);
        arc_block_dp(countTextView);
        arc_block_dp(searchTextView);
        arc_block_dp(deleteCountBtn);
        arc_block_dp(deleteSearchBtn);
        arc_block_dp(fontBtn);
        arc_block_dp(nextBtn);
        arc_block_dp(searchBtn);
        [UIView animateWithDuration:0.1 animations:^{
            weak_self.heightDP = [weak_self superview].heightDP-kbSize.height;
            weak_countTextView.heightDP = weak_self.heightDP-DPStatusbarH-DPFrameHeight(140);
            weak_searchTextView.yDP = weak_countTextView.yMaxDP+DPFrameHeight(5);
            
            CGFloat minY = weak_searchTextView.yMaxDP+DPFrameHeight(5);
            weak_deleteCountBtn.yDP = minY;
            weak_deleteSearchBtn.yDP = minY;
            weak_fontBtn.yDP = minY;
            weak_nextBtn.yDP = minY;
            weak_searchBtn.yDP = minY;
        }];
    }
}
- (void)keyboardWillHide:(NSNotification *)note{
    arc_block_dp(self);
    arc_block_dp(countTextView);
    arc_block_dp(searchTextView);
    arc_block_dp(deleteCountBtn);
    arc_block_dp(deleteSearchBtn);
    arc_block_dp(fontBtn);
    arc_block_dp(nextBtn);
    arc_block_dp(searchBtn);
    [UIView animateWithDuration:0.1 animations:^{
        weak_self.heightDP = [weak_self superview].heightDP;
        weak_countTextView.heightDP = weak_self.heightDP-DPStatusbarH-DPFrameHeight(140);
        weak_searchTextView.yDP = weak_countTextView.yMaxDP+DPFrameHeight(5);
        
        CGFloat minY = weak_searchTextView.yMaxDP+DPFrameHeight(5);
        weak_deleteCountBtn.yDP = minY;
        weak_deleteSearchBtn.yDP = minY;
        weak_fontBtn.yDP = minY;
        weak_nextBtn.yDP = minY;
        weak_searchBtn.yDP = minY;
    }];
}


#pragma mark <-------------UITextViewDelegate------------->
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView == searchTextView) {
        [countTextView resignFirstResponder];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)setLogOutStr:(NSString *)logOutStr {
    if (countTextView && self.hidden == NO) {
        if (sumLogStr == nil) {
            sumLogStr = [NSMutableString stringWithCapacity:0];
        }
        NSString *aStr = [NSString stringWithFormat:@"%@\n\n",logOutStr];
        [sumLogStr appendString:aStr];
        
        if (isLogOut) {
            NSDictionary *aAttrDic = @{
                NSForegroundColorAttributeName:[UIColor whiteColor],
                NSFontAttributeName:[UIFont systemFontOfSize:16]
            };
            NSAttributedString *aAttr = [[NSAttributedString alloc]initWithString:sumLogStr attributes:aAttrDic];
            countTextView.attributedText = aAttr;
        }
    }
}
@end

#endif
