//
//  CustomImageTextButton.h
//  DPWidgetSum
//
//  Created by xiayupeng on 15/9/11.
//  Copyright (c) 2018年 zcw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPButton.h"

typedef NS_ENUM(NSInteger,CustomImageTextButtonType){
    //文字+图片(或者只有一个) 左右结构
    ///整体垂直居中,水平居中: 左Icon右Text
    CustomImageTextButtonType_Center_IconLeft_TextRight = 0,
    ///整体垂直居中,水平居中: 左Text右Icon
    CustomImageTextButtonType_Center_IconRight_TextLeft,
    
    ///整体垂直居中,水平居左: 左Icon右text
    CustomImageTextButtonType_Left_IconLeft_TextRight,
    ///整体垂直居中,水平居左: 左Text右Icon
    CustomImageTextButtonType_Left_IconRight_TextLeft,
    
    ///整体垂直居中,水平居右: 左Icon右text
    CustomImageTextButtonType_Right_IconLeft_TextRight,
    ///整体垂直居中,水平居右: 左Text右Icon
    CustomImageTextButtonType_Right_IconRight_TextLeft,
    
    //文字+图片(或者只有一个) 上下结构
    ///整体垂直居中,水平居中: 上Icon下Text
    CustomImageTextButtonType_Center_IconTop_TextBottom,
    ///整体垂直居中,水平居中: 上Text下Icon
    CustomImageTextButtonType_Center_IconBottom_TextTop
};

@interface CustomImageTextButton : DPButton

///纯文字 Button
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor heightTextColor:(UIColor*)heightTextColor backGroundColor:(UIColor*)backGroundColor backGroundHightColor:(UIColor*)backGroundHightColor sideGap:(CGFloat)sideGap __deprecated_msg("当前类已经弃用,请使用 DPButton.h 类函数 -buttonWithFrame:(CGRect)frame");
///图片+文字 Button
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType imageTextGap:(CGFloat)imageTextGap imageName:(id)imageName heightImageName:(id)heightImageName text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor heightTextColor:(UIColor*)heightTextColor backGroundColor:(UIColor*)backGroundColor backGroundHightColor:(UIColor*)backGroundHightColor sideGap:(CGFloat)sideGap __deprecated_msg("当前类已经弃用,请使用 DPButton.h 类函数 -buttonWithFrame:(CGRect)frame");
///图片+文字 限制图片大小 Button
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType imageTextGap:(CGFloat)imageTextGap imageName:(id)imageName heightImageName:(id)heightImageName text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor heightTextColor:(UIColor*)heightTextColor backGroundColor:(UIColor*)backGroundColor backGroundHightColor:(UIColor*)backGroundHightColor sideGap:(CGFloat)sideGap imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight __deprecated_msg("当前类已经弃用,请使用 DPButton.h 类函数 -buttonWithFrame:(CGRect)frame");
///图片+文字 selected Button
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType imageTextGap:(CGFloat)imageTextGap imageName:(id)imageName selectedImageName:(id)selectedImageName text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor selectedTextColor:(UIColor*)selectedTextColor backGroundColor:(UIColor*)backGroundColor backGroundSelectedColor:(UIColor*)backGroundSelectedColor sideGap:(CGFloat)sideGap __deprecated_msg("当前类已经弃用,请使用 DPButton.h 类函数 -buttonWithFrame:(CGRect)frame");
///图片+文字 限制图片大小 selected Button
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType imageTextGap:(CGFloat)imageTextGap imageName:(id)imageName selectedImageName:(id)selectedImageName text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor selectedTextColor:(UIColor*)selectedTextColor backGroundColor:(UIColor*)backGroundColor backGroundSelectedColor:(UIColor*)backGroundSelectedColor sideGap:(CGFloat)sideGap imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight __deprecated_msg("当前类已经弃用,请使用 DPButton.h 类函数 -buttonWithFrame:(CGRect)frame");

///基础函数
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType imageTextGap:(CGFloat)imageTextGap imageName:(id)imageName heightImageName:(id)heightImageName selectedImageName:(id)selectedImageName text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor heightTextColor:(UIColor*)heightTextColor selectedTextColor:(UIColor*)selectedTextColor backGroundColor:(UIColor*)backGroundColor backGroundHightColor:(UIColor*)backGroundHightColor backGroundSelectedColor:(UIColor*)backGroundSelectedColor sideGap:(CGFloat)sideGap imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight __deprecated_msg("当前类已经弃用,请使用 DPButton.h 类函数 -buttonWithFrame:(CGRect)frame");
@end
