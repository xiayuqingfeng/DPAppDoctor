//
//  CustomImageTextButton.h
//  DPWidgetSum
//
//  Created by xiayupeng on 15/9/11.
//  Copyright (c) 2018年 zcw. All rights reserved.
//

#import "CustomImageTextButton.h"
@interface CustomImageTextButton(){
    
}
@end

@implementation CustomImageTextButton
///纯文字 Button
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor heightTextColor:(UIColor*)heightTextColor backGroundColor:(UIColor*)backGroundColor backGroundHightColor:(UIColor*)backGroundHightColor sideGap:(CGFloat)sideGap{
    
    return [self customButtonWithFrame:frame ImageTextType:textButtonType imageTextGap:0 imageName:@"" heightImageName:@"" selectedImageName:@"" text:text font:font textColor:textColor  heightTextColor:heightTextColor selectedTextColor:heightTextColor backGroundColor:backGroundColor backGroundHightColor:backGroundHightColor backGroundSelectedColor:backGroundHightColor sideGap:sideGap imageWidth:0 imageHeight:0];
}
///图片+文字 Button
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType imageTextGap:(CGFloat)imageTextGap imageName:(id)imageName heightImageName:(id)heightImageName text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor heightTextColor:(UIColor*)heightTextColor backGroundColor:(UIColor*)backGroundColor backGroundHightColor:(UIColor*)backGroundHightColor sideGap:(CGFloat)sideGap{
    
    return [self customButtonWithFrame:frame ImageTextType:textButtonType imageTextGap:imageTextGap imageName:imageName heightImageName:heightImageName selectedImageName:heightImageName text:text font:font textColor:textColor  heightTextColor:heightTextColor selectedTextColor:heightTextColor backGroundColor:backGroundColor backGroundHightColor:backGroundHightColor backGroundSelectedColor:backGroundHightColor sideGap:sideGap imageWidth:0 imageHeight:0];
}
///图片+文字 限制图片大小 Button
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType imageTextGap:(CGFloat)imageTextGap imageName:(id)imageName heightImageName:(id)heightImageName text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor heightTextColor:(UIColor*)heightTextColor backGroundColor:(UIColor*)backGroundColor backGroundHightColor:(UIColor*)backGroundHightColor sideGap:(CGFloat)sideGap imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight{
    
    return [self customButtonWithFrame:frame ImageTextType:textButtonType imageTextGap:imageTextGap imageName:imageName heightImageName:heightImageName selectedImageName:heightImageName text:text font:font textColor:textColor  heightTextColor:heightTextColor selectedTextColor:heightTextColor backGroundColor:backGroundColor backGroundHightColor:backGroundHightColor backGroundSelectedColor:backGroundHightColor sideGap:sideGap imageWidth:imageWidth imageHeight:imageHeight];
}
///图片+文字 selected Button
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType imageTextGap:(CGFloat)imageTextGap imageName:(id)imageName selectedImageName:(id)selectedImageName text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor selectedTextColor:(UIColor*)selectedTextColor backGroundColor:(UIColor*)backGroundColor backGroundSelectedColor:(UIColor*)backGroundSelectedColor sideGap:(CGFloat)sideGap{
    
    return [self customButtonWithFrame:frame ImageTextType:textButtonType imageTextGap:imageTextGap imageName:imageName selectedImageName:selectedImageName text:text font:font textColor:textColor selectedTextColor:selectedTextColor backGroundColor:backGroundColor backGroundSelectedColor:backGroundSelectedColor sideGap:sideGap imageWidth:0 imageHeight:0];
}
///图片+文字 限制图片大小 selected Button
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType imageTextGap:(CGFloat)imageTextGap imageName:(id)imageName selectedImageName:(id)selectedImageName text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor selectedTextColor:(UIColor*)selectedTextColor backGroundColor:(UIColor*)backGroundColor backGroundSelectedColor:(UIColor*)backGroundSelectedColor sideGap:(CGFloat)sideGap imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight{
    
    return [self customButtonWithFrame:frame ImageTextType:textButtonType imageTextGap:imageTextGap imageName:imageName heightImageName:selectedImageName selectedImageName:selectedImageName text:text font:font textColor:textColor  heightTextColor:selectedTextColor selectedTextColor:selectedTextColor backGroundColor:backGroundColor backGroundHightColor:backGroundSelectedColor backGroundSelectedColor:backGroundSelectedColor sideGap:sideGap imageWidth:imageWidth imageHeight:imageHeight];
}
///基础函数
+(id)customButtonWithFrame:(CGRect)frame ImageTextType:(CustomImageTextButtonType)textButtonType imageTextGap:(CGFloat)imageTextGap imageName:(id)imageName heightImageName:(id)heightImageName selectedImageName:(id)selectedImageName text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor heightTextColor:(UIColor*)heightTextColor selectedTextColor:(UIColor*)selectedTextColor backGroundColor:(UIColor*)backGroundColor backGroundHightColor:(UIColor*)backGroundHightColor backGroundSelectedColor:(UIColor*)backGroundSelectedColor sideGap:(CGFloat)sideGap imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight{
    
    UIEdgeInsets aEdgeInsets = UIEdgeInsetsZero;
    if (textButtonType == CustomImageTextButtonType_Center_IconLeft_TextRight     ||
        textButtonType == CustomImageTextButtonType_Center_IconRight_TextLeft     ||
        textButtonType == CustomImageTextButtonType_Left_IconLeft_TextRight       ||
        textButtonType == CustomImageTextButtonType_Left_IconRight_TextLeft       ||
        textButtonType == CustomImageTextButtonType_Right_IconLeft_TextRight      ||
        textButtonType == CustomImageTextButtonType_Right_IconRight_TextLeft) {
        
        aEdgeInsets = UIEdgeInsetsMake(0, sideGap, 0, sideGap);
    }else if (textButtonType == CustomImageTextButtonType_Center_IconTop_TextBottom ||
              textButtonType == CustomImageTextButtonType_Center_IconBottom_TextTop) {
        
        aEdgeInsets = UIEdgeInsetsMake(sideGap, 0, sideGap, 0);
    }
    return [self buttonWithFrame:frame imageTextType:(DPButtonType)textButtonType gap:imageTextGap normalImage:imageName heightImage:heightImageName selectedImage:selectedImageName text:text font:font textColor:textColor heightTextColor:heightTextColor selectedTextColor:selectedTextColor backGroundColor:backGroundColor backGroundHightColor:backGroundHightColor backGroundSelectedColor:backGroundSelectedColor sideEdgeInsets:aEdgeInsets imageSize:CGSizeMake(imageWidth, imageHeight)];
}
@end
