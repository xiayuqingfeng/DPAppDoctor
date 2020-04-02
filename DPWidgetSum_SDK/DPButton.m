//
//  DPButton.h
//  DPWidgetSum
//
//  Created by xiayupeng on 15/9/11.
//  Copyright (c) 2018年 zcw. All rights reserved.
//

#import "DPButton.h"
@interface DPButton(){
    
}
@end

@implementation DPButton
+ (id)buttonWithFrame:(CGRect)frame imageTextType:(DPButtonType)aImageTextType gap:(CGFloat)aGap image:(id)aImage text:(NSString*)aText font:(UIFont*)aFont textColor:(UIColor*)aTextColor{
    return [DPButton buttonWithFrame:frame imageTextType:aImageTextType gap:aGap normalImage:aImage heightImage:aImage selectedImage:aImage text:aText font:aFont textColor:aTextColor heightTextColor:aTextColor selectedTextColor:aTextColor backGroundColor:[UIColor clearColor] backGroundHightColor:[UIColor clearColor] backGroundSelectedColor:[UIColor clearColor] sideEdgeInsets:UIEdgeInsetsZero imageSize:CGSizeZero];
}

+ (id)buttonWithFrame:(CGRect)frame imageTextType:(DPButtonType)aImageTextType gap:(CGFloat)aGap image:(id)aImage text:(NSString*)aText font:(UIFont*)aFont textColor:(UIColor*)aTextColor sideEdgeInsets:(UIEdgeInsets)aSideEdgeInsets{
    return [DPButton buttonWithFrame:frame imageTextType:aImageTextType gap:aGap normalImage:aImage heightImage:aImage selectedImage:aImage text:aText font:aFont textColor:aTextColor heightTextColor:aTextColor selectedTextColor:aTextColor backGroundColor:[UIColor clearColor] backGroundHightColor:[UIColor clearColor] backGroundSelectedColor:[UIColor clearColor] sideEdgeInsets:aSideEdgeInsets imageSize:CGSizeZero];
}

+ (id)buttonWithFrame:(CGRect)frame imageTextType:(DPButtonType)aImageTextType gap:(CGFloat)aGap image:(id)aImage text:(NSString*)aText font:(UIFont*)aFont textColor:(UIColor*)aTextColor imageSize:(CGSize)aImageSize{
    return [DPButton buttonWithFrame:frame imageTextType:aImageTextType gap:aGap normalImage:aImage heightImage:aImage selectedImage:aImage text:aText font:aFont textColor:aTextColor heightTextColor:aTextColor selectedTextColor:aTextColor backGroundColor:[UIColor clearColor] backGroundHightColor:[UIColor clearColor] backGroundSelectedColor:[UIColor clearColor] sideEdgeInsets:UIEdgeInsetsZero imageSize:aImageSize];
}

+ (id)buttonWithFrame:(CGRect)frame imageTextType:(DPButtonType)aImageTextType gap:(CGFloat)aGap normalImage:(id)aNormalImage heightImage:(id)aHeightImage selectedImage:(id)aSelectedImage text:(NSString*)aText font:(UIFont*)aFont textColor:(UIColor*)aTextColor heightTextColor:(UIColor*)aHeightTextColor selectedTextColor:(UIColor*)aSelectedTextColor backGroundColor:(UIColor*)aBackGroundColor backGroundHightColor:(UIColor*)aBackGroundHightColor backGroundSelectedColor:(UIColor*)aBackGroundSelectedColor sideEdgeInsets:(UIEdgeInsets)aSideEdgeInsets imageSize:(CGSize)aImageSize{
    
    DPButton* button = [super buttonWithType:UIButtonTypeCustom];
    if(button){
        button.frame = frame;
        
        //设置按钮布局
        button.imageTextButtonType = aImageTextType;
        
        //设置按钮宽高自适应
        button.currentFrame = frame;
        
        //设置按钮内容间隙
        button.imageTextGap = aGap;
        button.sideEdgeInsets = aSideEdgeInsets;
        
        //设置按钮背景
        [button setBackgroundColor:[UIColor clearColor]];
        button.backGroundColor = aBackGroundColor;
        button.backGroundHightColor = aBackGroundHightColor;
        button.backGroundSelectedColor = aBackGroundSelectedColor;

        //设置字体
        [button setTitleColor:aTextColor forState:UIControlStateNormal];
        [button setTitleColor:aHeightTextColor forState:UIControlStateHighlighted];
        [button setTitleColor:aSelectedTextColor forState:UIControlStateSelected];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.deployFont = aFont;
        button.deployText = aText;
        
        //设置图片
        button.imageSize = aImageSize;
        button.imageName = aNormalImage;
        button.heightImageName = aHeightImage;
        button.selectedImageName = aSelectedImage;
        
        [button layoutSubviews];
    }
    return button;
}

#pragma mark <--------------按钮属性修改-------------->
///获取 或 修改图片与文字的布局类型
- (void)setImageTextButtonType:(DPButtonType)imageTextButtonType{
    _imageTextButtonType = imageTextButtonType;
    
    [self layoutSubviews];
}
///获取 或 修改按钮的frame: frame.size.width<=0 宽度自适应, frame.size.height<=0 高度自适应;
- (void)setCurrentFrame:(CGRect)currentFrame{
    _currentFrame = currentFrame;
    
    [self layoutSubviews];
}
///获取 或 修改图片与文字之间的间距
- (void)setImageTextGap:(CGFloat)imageTextGap{
    _imageTextGap = imageTextGap;
    
    [self layoutSubviews];
}
///按钮整体内容，显示内容区域距离边框的距离,上下左右
- (void)setSideEdgeInsets:(UIEdgeInsets)sideEdgeInsets{
    _sideEdgeInsets = sideEdgeInsets;
    
    [self layoutSubviews];
}
///获取 或 修改Text
- (void)setDeployText:(NSString *)deployText{
    _deployText = deployText;
    [self setTitle:_deployText forState:(UIControlStateNormal)];
    [self setTitle:_deployText forState:(UIControlStateHighlighted)];
    [self setTitle:_deployText forState:(UIControlStateSelected)];
    
    [self layoutSubviews];
}
///获取 或 修改Font
- (void)setDeployFont:(UIFont *)deployFont{
    _deployFont = deployFont;
    self.titleLabel.font = _deployFont;
    
    [self layoutSubviews];
}
///获取 或 修改图片 size: 默认 CGSizeMake(0, 0), 图片原始尺寸
- (void)setImageSize:(CGSize)imageSize{
    _imageSize = imageSize;
    UIImage *imageNormal = [DPButton makeImage:_imageName imageWidth:_imageSize.width imageHeight:_imageSize.height];
    UIImage *imageHighlighted = [DPButton makeImage:_heightImageName imageWidth:_imageSize.width imageHeight:_imageSize.height];
    UIImage *imageSelected = [DPButton makeImage:_selectedImageName imageWidth:_imageSize.width imageHeight:_imageSize.height];
    if (imageNormal) {
        [self setImage:imageNormal forState:UIControlStateNormal];
    }
    if (imageHighlighted) {
        [self setImage:imageHighlighted forState:UIControlStateHighlighted];
    }
    if (imageSelected) {
        [self setImage:imageSelected forState:UIControlStateSelected];
    }
    
    [self layoutSubviews];
}
///获取 或 修改按钮的图片
- (void)setImageName:(id)imageName{
    _imageName = imageName;
    [self setImageSize:_imageSize];
}
- (void)setHeightImageName:(id)heightImageName{
    _heightImageName = heightImageName;
    [self setImageSize:_imageSize];
}
- (void)setSelectedImageName:(id)selectedImageName{
    _selectedImageName = selectedImageName;
    [self setImageSize:_imageSize];
}
///获取 或 修改按钮的背景颜色
- (void)setBackGroundColor:(id)backGroundColor{
    _backGroundColor = backGroundColor;
    [DPButton setButtonBackgroundColor:_backGroundColor forState:UIControlStateNormal button:self];
}
- (void)setBackGroundHightColor:(id)backGroundHightColor{
    _backGroundHightColor = backGroundHightColor;
    [DPButton setButtonBackgroundColor:_backGroundHightColor forState:UIControlStateHighlighted button:self];
}
- (void)setBackGroundSelectedColor:(id)backGroundSelectedColor{
    _backGroundSelectedColor = backGroundSelectedColor;
    [DPButton setButtonBackgroundColor:_backGroundSelectedColor forState:UIControlStateSelected button:self];
}

#pragma mark <--------------按钮重定义-------------->
//重定义 titleLabel 显示区域
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGRect currentRect = [self titleOrImageRectForContentRect:contentRect type:0];
    return currentRect;
}
//重定义 imagView 显示区域
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect currentRect = [self titleOrImageRectForContentRect:contentRect type:1];
    return currentRect;
}
///aType: 0 文字布局, 1 图片布局
- (CGRect)titleOrImageRectForContentRect:(CGRect)contentRect type:(NSInteger)aType{
    //当前按钮大小
    CGSize contentSize = contentRect.size;
    
    //当前图片大小
    CGSize imageSize = CGSizeZero;
    UIImage *image = [self imageForState:UIControlStateNormal];
    if (image) {
        imageSize = image.size;
    }

    //当前文字大小
    CGSize sizeText = [DPButton sizeWithFont:_deployFont adjustSize:CGSizeMake(10000, _deployFont.lineHeight) alignment:NSTextAlignmentLeft str:_deployText];
    
    /********计算图片、文字显示区域大小********/
    CGSize currentContentSize = CGSizeZero;
    //计算文字、图片显示区域大小
    if (_imageTextButtonType == DPButtonType_Center_IconLeft_TextRight     ||
        _imageTextButtonType == DPButtonType_Center_IconRight_TextLeft     ||
        _imageTextButtonType == DPButtonType_Left_IconLeft_TextRight       ||
        _imageTextButtonType == DPButtonType_Left_IconRight_TextLeft       ||
        _imageTextButtonType == DPButtonType_Right_IconLeft_TextRight      ||
        _imageTextButtonType == DPButtonType_Right_IconRight_TextLeft) {
        //文字图片左右排版
        
        if (_currentFrame.size.width > 0 && _currentFrame.size.height > 0) {
            //设置按钮宽度、高度固定
            if (_imageTextButtonType == DPButtonType_Center_IconLeft_TextRight     ||
                _imageTextButtonType == DPButtonType_Center_IconRight_TextLeft) {
                currentContentSize = CGSizeMake(contentSize.width, contentSize.height);
            }else{
                currentContentSize = CGSizeMake(contentSize.width-_sideEdgeInsets.left-_sideEdgeInsets.right, contentSize.height);
            }

            if (imageSize.width+sizeText.width+_imageTextGap > currentContentSize.width) {
                imageSize.width = MIN(imageSize.width, (currentContentSize.width-_imageTextGap)/2);
                sizeText.width = MIN(sizeText.width, (currentContentSize.width-_imageTextGap)/2);
            }else{
                imageSize.width = imageSize.width;
                sizeText.width = sizeText.width;
            }
            
            imageSize.height = MIN(imageSize.height, currentContentSize.height);
            sizeText.height = MIN(sizeText.height, currentContentSize.height);
        }else if (_currentFrame.size.width > 0 && _currentFrame.size.height == 0) {
            //设置按钮宽度固定、高度自适应
            if (_imageTextButtonType == DPButtonType_Center_IconLeft_TextRight     ||
                _imageTextButtonType == DPButtonType_Center_IconRight_TextLeft) {
                currentContentSize = CGSizeMake(contentSize.width, 0);
            }else{
                currentContentSize = CGSizeMake(contentSize.width-_sideEdgeInsets.left-_sideEdgeInsets.right, 0);
            }
            
            if (imageSize.width+sizeText.width+_imageTextGap > currentContentSize.width) {
                imageSize.width = MIN(imageSize.width, (currentContentSize.width-_imageTextGap)/2);
                sizeText.width = MIN(sizeText.width, (currentContentSize.width-_imageTextGap)/2);
            }else{
                imageSize.width = imageSize.width;
                sizeText.width = sizeText.width;
            }
            
            imageSize.height = imageSize.height;
            sizeText.height = sizeText.height;
            
            currentContentSize.height = MAX(imageSize.height, sizeText.height)+_sideEdgeInsets.top+_sideEdgeInsets.bottom;
            if (self.frame.size.height != currentContentSize.height) {
                CGRect aFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, currentContentSize.height);
                [self setFrame:aFrame];
            }
        }else if (_currentFrame.size.width == 0 && _currentFrame.size.height > 0) {
            //设置按钮宽度自适应、高度固定
            currentContentSize = CGSizeMake(0, contentSize.height);
            
            imageSize.width = imageSize.width;
            imageSize.height = MIN(imageSize.height, currentContentSize.height);
            
            sizeText.width = sizeText.width;
            sizeText.height = MIN(sizeText.height, currentContentSize.height);
            
            currentContentSize.width = imageSize.width+sizeText.width+_imageTextGap+_sideEdgeInsets.left+_sideEdgeInsets.right;
            if (self.frame.size.width != currentContentSize.width) {
                CGRect aFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, currentContentSize.width, self.frame.size.height);
                [self setFrame:aFrame];
            }
        }else{
            //设置按钮宽度自适应、高度自适应
            currentContentSize = CGSizeMake(0, 0);
            
            imageSize.width = imageSize.width;
            imageSize.height = imageSize.height;
            
            sizeText.width = sizeText.width;
            sizeText.height = sizeText.height;
            
            currentContentSize.width = imageSize.width+_imageTextGap+sizeText.width+_sideEdgeInsets.left+_sideEdgeInsets.right;
            currentContentSize.height = MAX(imageSize.height, sizeText.height)+_sideEdgeInsets.top+_sideEdgeInsets.bottom;
            if (self.frame.size.width != currentContentSize.width || self.frame.size.height != currentContentSize.height) {
                CGRect aFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, currentContentSize.width, currentContentSize.height);
                [self setFrame:aFrame];
            }
        }
        
    }else if (_imageTextButtonType == DPButtonType_Center_IconTop_TextBottom ||
              _imageTextButtonType == DPButtonType_Center_IconBottom_TextTop) {
        //文字图片上下排版
        
        if (_currentFrame.size.width > 0 && _currentFrame.size.height > 0) {
            //设置按钮宽度、高度固定
            currentContentSize = CGSizeMake(contentSize.width, contentSize.height);
            
            imageSize.width = MIN(imageSize.width, currentContentSize.width);
            sizeText.width = MIN(sizeText.width, currentContentSize.width);
            
            if (imageSize.height+sizeText.height+_imageTextGap > currentContentSize.height) {
                imageSize.height = MIN(imageSize.height, (currentContentSize.height-_imageTextGap)/2);
                sizeText.height = MIN(sizeText.height, (currentContentSize.height-_imageTextGap)/2);
            }else{
                imageSize.height = imageSize.height;
                sizeText.height = sizeText.height;
            }
        }else if (_currentFrame.size.width > 0 && _currentFrame.size.height == 0) {
            //设置按钮宽度固定、高度自适应
            currentContentSize = CGSizeMake(contentSize.width, 0);
            
            imageSize.width = MIN(imageSize.width, currentContentSize.width);
            imageSize.height = imageSize.height;
            
            sizeText.width = MIN(sizeText.width, currentContentSize.width);
            sizeText.height = sizeText.height;
            
            currentContentSize.height = imageSize.height+sizeText.height+_imageTextGap+_sideEdgeInsets.top+_sideEdgeInsets.bottom;
            if (self.frame.size.height != currentContentSize.height) {
                CGRect aFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, currentContentSize.height);
                [self setFrame:aFrame];
            }
        }else if (_currentFrame.size.width == 0 && _currentFrame.size.height > 0) {
            //设置按钮宽度自适应、高度固定
            currentContentSize = CGSizeMake(0, contentSize.height);
            
            imageSize.width = imageSize.width;
            sizeText.width = sizeText.width;
            
            if (imageSize.height+sizeText.height+_imageTextGap > currentContentSize.height) {
                imageSize.height = MIN(imageSize.height, (currentContentSize.height-_imageTextGap)/2);
                sizeText.height = MIN(sizeText.height, (currentContentSize.height-_imageTextGap)/2);
            }else{
                imageSize.height = imageSize.height;
                sizeText.height = sizeText.height;
            }
            
            currentContentSize.width = MAX(imageSize.width, sizeText.width)+_sideEdgeInsets.left+_sideEdgeInsets.right;
            if (self.frame.size.width != currentContentSize.width) {
                CGRect aFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, currentContentSize.width, self.frame.size.height);
                [self setFrame:aFrame];
            }
        }else{
            //设置按钮宽度自适应、高度自适应
            currentContentSize = CGSizeMake(0, 0);
            
            imageSize.width = imageSize.width;
            imageSize.height = imageSize.height;
            
            sizeText.width = sizeText.width;
            sizeText.height = sizeText.height;
            
            currentContentSize.width = MAX(imageSize.width, sizeText.width)+_sideEdgeInsets.left+_sideEdgeInsets.right;
            currentContentSize.height = imageSize.height+sizeText.height+_imageTextGap+_sideEdgeInsets.top+_sideEdgeInsets.bottom;
            if (self.frame.size.width != currentContentSize.width || self.frame.size.height != currentContentSize.height) {
                CGRect aFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, currentContentSize.width, currentContentSize.height);
                [self setFrame:aFrame];
            }
        }
        
    }
    
    /********不限制不偏大小,图片显示区域,按照云图宽高比等比改变大小********/
    if (image && CGSizeEqualToSize(_imageSize,CGSizeZero)) {
        if (image.size.width/image.size.height != imageSize.width/imageSize.height) {
            if (imageSize.width/image.size.width < imageSize.height/image.size.height) {
                //图片宽度改变比例大,高度按照宽的等比改变
                imageSize.height = image.size.height*(imageSize.width/image.size.width);
            }else{
                //图片高度改变比例大,宽度按照宽的等比改变
                imageSize.width = image.size.width*(imageSize.height/image.size.height);
            }
        }
    }

    CGRect imageReturnFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGRect labelReturnFrame = CGRectMake(0, 0, sizeText.width, sizeText.height);
    
    /********计算文字,图片显示区域 minX 坐标********/
    switch (_imageTextButtonType) {
        case DPButtonType_Center_IconLeft_TextRight:{
            ///整体垂直居中,水平居中: 左Icon右Text
            if (_currentFrame.size.width <= 0) {
                imageReturnFrame.origin.x = _sideEdgeInsets.left;
            }else{
                imageReturnFrame.origin.x = (self.frame.size.width-imageSize.width-sizeText.width-_imageTextGap)/2;
            }
            labelReturnFrame.origin.x = CGRectGetMaxX(imageReturnFrame)+_imageTextGap;
        }
            break;
        case DPButtonType_Center_IconRight_TextLeft:{
            ///整体垂直居中,水平居中: 左Text右Icon
            if (_currentFrame.size.width <= 0) {
                labelReturnFrame.origin.x = _sideEdgeInsets.left;
            }else{
                labelReturnFrame.origin.x = (self.frame.size.width-sizeText.width-imageSize.width-_imageTextGap)/2;
            }
            imageReturnFrame.origin.x = CGRectGetMaxX(labelReturnFrame)+_imageTextGap;
        }
            break;
        case DPButtonType_Left_IconLeft_TextRight:{
            ///整体垂直居中,水平居左: 左Icon右text
            imageReturnFrame.origin.x = _sideEdgeInsets.left;
            labelReturnFrame.origin.x = CGRectGetMaxX(imageReturnFrame)+_imageTextGap;
        }
            break;
        case DPButtonType_Left_IconRight_TextLeft:{
            ///整体垂直居中,水平居左: 左Text右Icon
            labelReturnFrame.origin.x = _sideEdgeInsets.left;
            imageReturnFrame.origin.x = CGRectGetMaxX(labelReturnFrame)+_imageTextGap;
        }
            break;
        case DPButtonType_Right_IconLeft_TextRight:{
            ///整体垂直居中,水平居右: 左Icon右text
            labelReturnFrame.origin.x = self.frame.size.width-_sideEdgeInsets.right-sizeText.width;
            imageReturnFrame.origin.x = labelReturnFrame.origin.x-_imageTextGap-imageSize.width;
        }
            break;
        case DPButtonType_Right_IconRight_TextLeft:{
            ///整体垂直居中,水平居右: 左Text右Icon
            imageReturnFrame.origin.x = self.frame.size.width-_sideEdgeInsets.right-imageSize.width;
            labelReturnFrame.origin.x = imageReturnFrame.origin.x-_imageTextGap-sizeText.width;
        }
            break;
        case DPButtonType_Center_IconTop_TextBottom:{
            ///整体垂直居中,水平居中: 上Icon下Text
            if (_currentFrame.size.height <= 0) {
                imageReturnFrame.origin.y = _sideEdgeInsets.top;
            }else{
                imageReturnFrame.origin.y = (self.frame.size.height-imageSize.height-sizeText.height-_imageTextGap)/2;
            }
            labelReturnFrame.origin.y = CGRectGetMaxY(imageReturnFrame)+_imageTextGap;
        }
            break;
        case DPButtonType_Center_IconBottom_TextTop:{
            ///整体垂直居中,水平居中: 上Text下Icon
            if (_currentFrame.size.height <= 0) {
                labelReturnFrame.origin.y = _sideEdgeInsets.top;
            }else{
                labelReturnFrame.origin.y = (self.frame.size.height-sizeText.height-imageSize.height-_imageTextGap)/2;
            }
            imageReturnFrame.origin.y = CGRectGetMaxY(labelReturnFrame)+_imageTextGap;
        }
            break;
        default: break;
    }
    
    /********计算文字,图片显示区域 minY 坐标********/
    if (_imageTextButtonType == DPButtonType_Center_IconLeft_TextRight     ||
        _imageTextButtonType == DPButtonType_Center_IconRight_TextLeft     ||
        _imageTextButtonType == DPButtonType_Left_IconLeft_TextRight       ||
        _imageTextButtonType == DPButtonType_Left_IconRight_TextLeft       ||
        _imageTextButtonType == DPButtonType_Right_IconLeft_TextRight      ||
        _imageTextButtonType == DPButtonType_Right_IconRight_TextLeft) {
        //文字图片左右排版
        if (_currentFrame.size.height > 0) {
            imageReturnFrame.origin.y = (self.frame.size.height-imageSize.height)/2;
            labelReturnFrame.origin.y = (self.frame.size.height-sizeText.height)/2;
        }else{
            if (imageSize.height >= sizeText.height) {
                imageReturnFrame.origin.y = _sideEdgeInsets.top;
                labelReturnFrame.origin.y = CGRectGetMidY(imageReturnFrame)-labelReturnFrame.size.height/2;
            }else{
                labelReturnFrame.origin.y = _sideEdgeInsets.top;
                imageReturnFrame.origin.y = CGRectGetMidY(labelReturnFrame)-imageReturnFrame.size.height/2;
            }
        }
    }else if (_imageTextButtonType == DPButtonType_Center_IconTop_TextBottom ||
              _imageTextButtonType == DPButtonType_Center_IconBottom_TextTop) {
        //文字图片上下排版
        if (_currentFrame.size.width > 0) {
            imageReturnFrame.origin.x = (self.frame.size.width-imageSize.width)/2;
            labelReturnFrame.origin.x = (self.frame.size.width-sizeText.width)/2;
        }else{
            if (imageSize.width >= sizeText.width) {
                imageReturnFrame.origin.x = _sideEdgeInsets.left;
                labelReturnFrame.origin.x = CGRectGetMidX(imageReturnFrame)-labelReturnFrame.size.width/2;
            }else{
                labelReturnFrame.origin.x = _sideEdgeInsets.left;
                imageReturnFrame.origin.x = CGRectGetMidX(labelReturnFrame)-imageReturnFrame.size.width/2;
            }
        }
    }
    
    if (aType == 0) {
        return labelReturnFrame;
    }else if (aType == 1) {
        return imageReturnFrame;
    }else{
        return contentRect;
    }
}

#pragma mark <--------------公共函数-------------->
///裁剪图片大小
+ (UIImage *)makeImage:(id)imageName imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight{
    UIImage * aImage = nil;
    if (imageName) {
        if ([imageName isKindOfClass:[UIImage class]]) {
            aImage = imageName;
        }else if ([imageName isKindOfClass:[NSString class]]) {
            aImage = [UIImage imageNamed:imageName];
        }
        if (imageWidth == 0) {
            imageWidth = aImage.size.width;
        }
        if (imageHeight == 0) {
            imageHeight = aImage.size.height;
        }
        if (aImage) {
            if (imageWidth>0 && imageHeight>0) {
                CGSize size = CGSizeMake(imageWidth, imageHeight);
                // 创建一个bitmap的context
                // 并把它设置成为当前正在使用的context
                //Determine whether the screen is retina
                if([[UIScreen mainScreen] scale] == 2.0){
                    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
                }else{
                    UIGraphicsBeginImageContext(size);
                }
                // 绘制改变大小的图片
                [aImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
                // 从当前context中创建一个改变大小后的图片
                aImage = UIGraphicsGetImageFromCurrentImageContext();
                // 使当前的context出堆栈
                UIGraphicsEndImageContext();
            }
        }
    }
    return aImage;
}

///获取 或 修改按钮点击状态背景颜色
+ (void)setButtonBackgroundColor:(UIColor *)color forState:(UIControlState)state button:(UIButton *)aButton{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [aButton setBackgroundImage:backgroundColorImage forState:state];
}
///计算字符串size
+ (CGSize)sizeWithFont:(UIFont*)font adjustSize:(CGSize)boundingSize alignment:(NSTextAlignment)alignment str:(NSString *)str{
    CGSize textSize = CGSizeZero;
    if([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        //ios7
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = alignment;
        
        NSDictionary * attributes = @{NSFontAttributeName:font,
                                      NSParagraphStyleAttributeName:paragraphStyle};
        
        NSStringDrawingContext * content = [[NSStringDrawingContext alloc] init];
        content.minimumScaleFactor = 0.5;
        textSize = [str boundingRectWithSize:boundingSize
                                     options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:content].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"//方法弃用告警
        textSize = [str sizeWithFont:font constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    }
    return textSize;
}
@end
