//
//  ViewController.m
//  test
//
//  Created by yupeng xia on 2018/12/17.
//  Copyright © 2018 yupeng xia. All rights reserved.
//

#import "ViewController.h"
#import "IQKeyBoardManager.h"
#import "DPButton.h"

@interface ViewController (){
    DPButton *sectionTitleButton;
}

@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeButton:nil];
}

- (IBAction)makeButton:(id)sender {
    [sectionTitleButton removeFromSuperview];
    sectionTitleButton = nil;
    
    CGRect newFram = CGRectMake(30, 30, _widthField.text.floatValue, _heightField.text.floatValue);
    UIEdgeInsets newEdgeInsets = UIEdgeInsetsMake(_topField.text.floatValue, _leftField.text.floatValue, _bottomField.text.floatValue, _rightField.text.floatValue);
    
    sectionTitleButton = [DPButton buttonWithFrame:newFram imageTextType:[self getLayoutType] gap:_gapField.text.floatValue normalImage:_currentImage.image heightImage:_currentImage.image selectedImage:_currentImage.image text:_textStrField.text font:[UIFont systemFontOfSize:_textFontField.text.floatValue] textColor:[UIColor blackColor] heightTextColor:[UIColor blackColor] selectedTextColor:[UIColor blackColor] backGroundColor:[UIColor orangeColor] backGroundHightColor:[UIColor orangeColor] backGroundSelectedColor:[UIColor orangeColor] sideEdgeInsets:newEdgeInsets imageSize:CGSizeMake(_imageWidthField.text.floatValue, _imageHeightField.text.floatValue)];
    
    [self.view addSubview:sectionTitleButton];
    
    [sectionTitleButton setBackgroundColor:[UIColor clearColor]];
    sectionTitleButton.titleLabel.backgroundColor = [UIColor purpleColor];
    sectionTitleButton.imageView.backgroundColor = [UIColor redColor];
}
- (IBAction)updateButton:(id)sender {
    if (_widthField.text.floatValue != sectionTitleButton.frame.size.width || _heightField.text.floatValue != sectionTitleButton.frame.size.height) {
        sectionTitleButton.frame = CGRectMake(sectionTitleButton.frame.origin.x, sectionTitleButton.frame.origin.y, _widthField.text.floatValue, _heightField.text.floatValue);
    }
    
    if ([self getLayoutType] != sectionTitleButton.imageTextButtonType) {
        sectionTitleButton.imageTextButtonType = [self getLayoutType];
    }
    
    if (_gapField.text.floatValue != sectionTitleButton.imageTextGap) {
        sectionTitleButton.imageTextGap = _gapField.text.floatValue;
    }
    
    UIEdgeInsets newEdgeInsets = UIEdgeInsetsMake(_topField.text.floatValue, _leftField.text.floatValue, _bottomField.text.floatValue, _rightField.text.floatValue);
    if (!UIEdgeInsetsEqualToEdgeInsets(newEdgeInsets, sectionTitleButton.sideEdgeInsets)) {
        sectionTitleButton.sideEdgeInsets = newEdgeInsets;
    }
    
    if (![sectionTitleButton.deployText isEqualToString:_textStrField.text]) {
        sectionTitleButton.deployText = _textStrField.text;
    }
    
    if (sectionTitleButton.deployFont != [UIFont systemFontOfSize:_textFontField.text.floatValue]) {
        sectionTitleButton.deployFont = [UIFont systemFontOfSize:_textFontField.text.floatValue];
    }
    
    if (!CGSizeEqualToSize(sectionTitleButton.imageSize, CGSizeMake(_imageWidthField.text.floatValue, _imageHeightField.text.floatValue))) {
        sectionTitleButton.imageSize = CGSizeMake(_imageWidthField.text.floatValue, _imageHeightField.text.floatValue);
    }
    
    if (sectionTitleButton.imageName != _currentImage.image) {
        sectionTitleButton.imageName = _currentImage.image;
    }
    
    if (sectionTitleButton.heightImageName != _currentImage.image) {
        sectionTitleButton.heightImageName = _currentImage.image;
    }
    
    if (sectionTitleButton.selectedImageName != _currentImage.image) {
        sectionTitleButton.selectedImageName = _currentImage.image;
    }
}
- (IBAction)changeImageAction:(id)sender {
    NSInteger number = (arc4random() % 3)+1;
    UIImage *buttonImage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",number]];
    _currentImage.image = buttonImage;
}
- (IBAction)layoutButton:(id)sender {
    UIButton *button = sender;
    for (int i = 0; i < 8; i++) {
        UIButton *currentButton = [self.view viewWithTag:501+i];
        if (currentButton == button) {
            currentButton.selected = YES;
        }else{
            currentButton.selected = NO;
        }
    }
}
- (DPButtonType)getLayoutType{
    for (int i = 0; i < 8; i++) {
        UIButton *currentButton = [self.view viewWithTag:501+i];
        if (currentButton.selected == YES) {
            return (DPButtonType)currentButton.tag-501;
        }
    }
    return DPButtonType_Center_IconLeft_TextRight;
}
@end
