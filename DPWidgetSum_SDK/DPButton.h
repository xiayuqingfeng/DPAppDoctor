//
//  DPButton.h
//  DPWidgetSum
//
//  Created by xiayupeng on 15/9/11.
//  Copyright (c) 2018年 zcw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DPButtonType){
    //文字+图片(或者只有一个) 左右结构
    ///整体垂直居中,水平居中: 左Icon右Text
    DPButtonType_Center_IconLeft_TextRight = 0,
    ///整体垂直居中,水平居中: 左Text右Icon
    DPButtonType_Center_IconRight_TextLeft,
    
    ///整体垂直居中,水平居左: 左Icon右text
    DPButtonType_Left_IconLeft_TextRight,
    ///整体垂直居中,水平居左: 左Text右Icon
    DPButtonType_Left_IconRight_TextLeft,
    
    ///整体垂直居中,水平居右: 左Icon右text
    DPButtonType_Right_IconLeft_TextRight,
    ///整体垂直居中,水平居右: 左Text右Icon
    DPButtonType_Right_IconRight_TextLeft,
    
    //文字+图片(或者只有一个) 上下结构
    ///整体垂直居中,水平居中: 上Icon下Text
    DPButtonType_Center_IconTop_TextBottom,
    ///整体垂直居中,水平居中: 上Text下Icon
    DPButtonType_Center_IconBottom_TextTop
};

@interface DPButton : UIButton
///获取 或 修改图片与文字的布局类型
@property(nonatomic,assign) DPButtonType imageTextButtonType;
///获取 或 修改按钮的frame: frame.size.width<=0 宽度自适应, frame.size.height<=0 高度自适应;
@property(nonatomic,assign) CGRect currentFrame;
///获取 或 修改图片与文字之间的间距
@property(nonatomic,assign) CGFloat imageTextGap;
///获取 或 修改按钮显示内容区域距离边框上下左右的距离,仅在"按钮宽、高自适应" 或 "按钮靠左布局、靠右布局"生效
@property(nonatomic,assign) UIEdgeInsets sideEdgeInsets;
///获取 或 修改Text
@property(nonatomic,strong) NSString *deployText;
///获取 或 修改Font
@property(nonatomic,strong) UIFont *deployFont;
///获取 或 修改图片大小自定,内部从新裁剪图片修改大小. 默认 CGSizeMake(0, 0), 图片为原始尺寸
@property(nonatomic,assign) CGSize imageSize;
///获取 或 修改按钮的图片
@property(nonatomic,strong) id imageName;
@property(nonatomic,strong) id heightImageName;
@property(nonatomic,strong) id selectedImageName;
///获取 或 修改按钮的背景颜色
@property(nonatomic,strong) UIColor *backGroundColor;
@property(nonatomic,strong) UIColor *backGroundHightColor;
@property(nonatomic,strong) UIColor *backGroundSelectedColor;

///自定义布局按钮 aImageTextType:图片与文字的布局类型枚举值, aGap:图片与文字之间的间距, aImage和text 均可为空
+ (id)buttonWithFrame:(CGRect)frame imageTextType:(DPButtonType)aImageTextType gap:(CGFloat)aGap image:(id)aImage text:(NSString*)aText font:(UIFont*)aFont textColor:(UIColor*)aTextColor;

///自定义布局按钮 aImageTextType:图片与文字的布局类型枚举值, aGap:图片与文字之间的间距, aImage和text 均可为空, sideEdgeInsets:显示内容四周间距
+ (id)buttonWithFrame:(CGRect)frame imageTextType:(DPButtonType)aImageTextType gap:(CGFloat)aGap image:(id)aImage text:(NSString*)aText font:(UIFont*)aFont textColor:(UIColor*)aTextColor sideEdgeInsets:(UIEdgeInsets)aSideEdgeInsets;

///自定义布局按钮 aImageTextType:图片与文字的布局类型枚举值, aGap:图片与文字之间的间距, aImage和text 均可为空, sideEdgeInsets:显示内容四周间距, imageSize:修改图片大小
+ (id)buttonWithFrame:(CGRect)frame imageTextType:(DPButtonType)aImageTextType gap:(CGFloat)aGap image:(id)aImage text:(NSString*)aText font:(UIFont*)aFont textColor:(UIColor*)aTextColor imageSize:(CGSize)aImageSize;

/*!
 *  自定义布局按钮,基础函数
 *
 *  @param aImageTextType:图片与文字的布局类型枚举值
 *  @param aGap:图片与文字之间的间距
 *  @param aNormalImage/aHeightImage/aSelectedImage:默认/高亮/选中状态的图片,类型可为 "UIImage" or "NSString"
 *  @param text:按钮字符串
 *  @param textColor/heightTextColor/selectedTextColor:默认/高亮/选中状态的按钮字体颜色
 *  @param backGroundColor/backGroundHightColor/backGroundSelectedColor:默认/高亮/选中状态的按钮背景颜色
 *  @param sideEdgeInsets:按钮显示内容区域距离边框上下左右的距离,仅在"按钮宽、高自适应" 或 "按钮靠左布局、靠右布局"生效
 *  @param imageSize:图片大小自定,内部从新裁剪图片修改大小. 默认 CGSizeMake(0, 0), 图片为原始尺寸
 */
+ (id)buttonWithFrame:(CGRect)frame imageTextType:(DPButtonType)aImageTextType gap:(CGFloat)aGap normalImage:(id)aNormalImage heightImage:(id)aHeightImage selectedImage:(id)aSelectedImage text:(NSString*)aText font:(UIFont*)aFont textColor:(UIColor*)aTextColor heightTextColor:(UIColor*)aHeightTextColor selectedTextColor:(UIColor*)aSelectedTextColor backGroundColor:(UIColor*)aBackGroundColor backGroundHightColor:(UIColor*)aBackGroundHightColor backGroundSelectedColor:(UIColor*)aBackGroundSelectedColor sideEdgeInsets:(UIEdgeInsets)aSideEdgeInsets imageSize:(CGSize)aImageSize;
@end
