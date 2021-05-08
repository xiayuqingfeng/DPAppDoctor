//
//  UIView+DPExtension.m
//  DPAppDoctor
//
//  Created by yupeng xia on 2021/3/16.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import "UIView+DPExtension.h"
#ifdef DPAppDoctorDebug
#import <objc/runtime.h>

@implementation UIView (DPExtension)
+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(didAddSubview:);
        SEL swizzledSelector = @selector(CFdidAddSubview:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
- (void)CFdidAddSubview:(UIView *)view{
    [[NSNotificationCenter defaultCenter] addObserver:view selector:@selector(dpUpdateViewBackgroundColor) name:@"dpChangeViewColor" object:nil];
    
    [view dpUpdateViewBackgroundColor];
}

- (void)dpUpdateViewBackgroundColor {
    NSDictionary *colorDic = [[DPAppDoctorManager shareInstance] valueForKey:@"colorSetDic"];
    if (colorDic != nil) {
        if (self.idInfo == nil && self.layer.borderWidth > 0 && self.layer.borderWidth != 5) {

            self.idInfo = @{
                @"borderWidth" : [NSString stringWithFormat:@"%f",self.layer.borderWidth],
                @"borderColor" : [[UIColor colorWithCGColor:self.layer.borderColor] dpHexStringFromColor]
            };
        }
        if (self.idInfo != nil) {
            NSDictionary *aDic = self.idInfo;
            self.layer.borderWidth = [NSString stringWithFormat:@"%@",aDic[@"borderWidth"]].floatValue;
            self.layer.borderColor = [UIColor dpColorWithHexString:[NSString stringWithFormat:@"%@",aDic[@"borderColor"]]].CGColor;
        }

        NSString *viewType = [colorDic objectForKey:@"UIView"];
        if (viewType.length && viewType.integerValue == 1) {
            self.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
            self.layer.borderWidth = 5;
        }else if (self.idInfo == nil) {
            self.layer.borderWidth = 0;
        }

        NSString *className = NSStringFromClass([self class]);
        if ([className containsString:@"Label"]) {
            NSString *aType = [colorDic objectForKey:@"UILabel"];
            if (aType.length && aType.integerValue == 1) {
                self.layer.borderColor = DPRgba(290, 87, 47, 1).CGColor;
                self.layer.borderWidth = 5;
            }else if (self.idInfo == nil) {
                self.layer.borderWidth = 0;
            }
            return;
        }

        if ([className containsString:@"Button"]) {
            NSString *aType = [colorDic objectForKey:@"UIButton"];
            if (aType.length && aType.integerValue == 1) {
                self.layer.borderColor = DPRgba(248, 231, 28, 1).CGColor;
                self.layer.borderWidth = 5;
            }else if (self.idInfo == nil) {
                self.layer.borderWidth = 0;
            }
            return;
        }

        if ([className containsString:@"TextView"]) {
            NSString *aType = [colorDic objectForKey:@"UITextView"];
            if (aType.length && aType.integerValue == 1) {
                self.layer.borderColor = DPRgba(0, 255, 0, 1).CGColor;
                self.layer.borderWidth = 5;
            }else if (self.idInfo == nil) {
                self.layer.borderWidth = 0;
            }
            return;
        }

        if ([className containsString:@"TextField"]) {
            NSString *aType = [colorDic objectForKey:@"UITextField"];
            if (aType.length && aType.integerValue == 1) {
                self.layer.borderColor = DPRgba(0, 0, 255, 1).CGColor;
                self.layer.borderWidth = 5;
            }else if (self.idInfo == nil) {
                self.layer.borderWidth = 0;
            }
            return;
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xDP {
    return self.frame.origin.x;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setXDP:(CGFloat)x {
    CGRect rect=CGRectMake(x, self.yDP, self.widthDP, self.heightDP);
    [self setFrame:rect];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)yDP {
    return self.frame.origin.y;
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setYDP:(CGFloat)y {
    CGRect rect=CGRectMake(self.xDP, y, self.widthDP, self.heightDP);
    [self setFrame:rect];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xMaxDP {
    return CGRectGetMaxX(self.frame);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setXMaxDP:(CGFloat)xMax {
    CGRect frame = self.frame;
    frame.origin.x = xMax - frame.size.width;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)yMaxDP {
    return CGRectGetMaxY(self.frame);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setYMaxDP:(CGFloat)yMax {
    CGRect frame = self.frame;
    frame.origin.y = yMax - frame.size.height;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)sizeDP {
    return self.frame.size;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSizeDP:(CGSize)size {
    CGRect rect=CGRectMake(self.xDP, self.yDP, size.width, size.height);
    [self setFrame:rect];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)originDP {
    return self.frame.origin;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOriginDP:(CGPoint)origin {
    CGRect rect=CGRectMake(origin.x, origin.y, self.widthDP, self.heightDP);
    [self setFrame:rect];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)leftDP {
    return self.frame.origin.x;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeftDP:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)topDP {
    return self.frame.origin.y;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTopDP:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)rightDP {
    return self.frame.origin.x + self.widthDP;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRightDP:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottomDP {
    return self.frame.origin.y + self.frame.size.height;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottomDP:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerXDP {
    return self.center.x;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterXDP:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerYDP {
    return self.center.y;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterYDP:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)widthDP {
    return self.frame.size.width;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidthDP:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)heightDP {
    return self.frame.size.height;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeightDP:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

///自定义圆角,边框; aRoundingCorners:枚举值,圆角位置; aRadius:圆角半径; aBorderCorners:枚举值,边框位置; aBorderWidth:边框宽度; aBorderColor:边框颜色;
- (void)setDPRoundingCorners:(UIRectCorner)aRoundingCorners radius:(CGFloat)aRadius borderCorners:(DPBorderDirection)aBorderCorners borderWidth:(CGFloat)aBorderWidth borderColor:(UIColor *)aBorderColor{
    
    if (aRadius > 0 && aRoundingCorners != 0) {
        //有圆角
        CGRect roundFrame = self.bounds;
        UIBezierPath* roundPath = [UIBezierPath bezierPathWithRoundedRect:roundFrame byRoundingCorners:aRoundingCorners cornerRadii:CGSizeMake(aRadius, aRadius)];
        CAShapeLayer* roundMask = [[CAShapeLayer alloc] init];
        roundMask.path = roundPath.CGPath;
        self.layer.mask = roundMask;
    }else{
        //没有圆角
        aRoundingCorners = 0;
        aRadius = 0;
        
        if (self.layer.mask) {
            self.layer.mask = nil;
        }
    }
    
    if (aBorderWidth > 0 && aBorderCorners != 0) {
        //绘制边框线
        CGRect borderFrame = self.bounds;
        borderFrame.origin.x = aBorderWidth/2;
        borderFrame.origin.y = aBorderWidth/2;
        borderFrame.size.width = borderFrame.size.width-aBorderWidth;
        borderFrame.size.height = borderFrame.size.height-aBorderWidth;
        
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:borderFrame byRoundingCorners:aRoundingCorners cornerRadii:CGSizeMake(aRadius-aBorderWidth/2, aRadius-aBorderWidth/2)];
        CAShapeLayer *borderMask  = [[CAShapeLayer alloc] init];
        borderMask.lineWidth = aBorderWidth;
        borderMask.lineCap = kCALineCapSquare;
        borderMask.strokeColor = aBorderColor.CGColor;
        borderMask.fillColor = [UIColor clearColor].CGColor;
        borderMask.path = borderPath.CGPath;
        [self.layer addSublayer:borderMask];
        
        if (aBorderCorners != DPBorderDirectionAllCorners) {
            //指定位置边框,重绘边框线与背景颜色相同,覆盖不需要的边框线
            CGFloat deleteBorderWidth = 0;
            if (aRadius > 0) {
                deleteBorderWidth = aRadius;
            }else{
                deleteBorderWidth = aBorderWidth;
            }
            CGRect deleteBorderFrame = self.bounds;
            deleteBorderFrame.origin.x = deleteBorderWidth/2;
            deleteBorderFrame.origin.y = deleteBorderWidth/2;
            deleteBorderFrame.size.width = deleteBorderFrame.size.width-deleteBorderWidth;
            deleteBorderFrame.size.height = deleteBorderFrame.size.height-deleteBorderWidth;
            
            UIBezierPath *deleteBorderPath = [UIBezierPath bezierPath];
            //top
            if (!(aBorderCorners & DPBorderDirectionTop)) {
                if (aBorderCorners & DPBorderDirectionLeft) {
                    [deleteBorderPath moveToPoint:CGPointMake(deleteBorderFrame.origin.x+aBorderWidth, deleteBorderFrame.origin.y)];
                }else{
                    [deleteBorderPath moveToPoint:CGPointMake(deleteBorderFrame.origin.x, deleteBorderFrame.origin.y)];
                }
                if (aBorderCorners & DPBorderDirectionRight) {
                    [deleteBorderPath addLineToPoint:CGPointMake(CGRectGetMaxX(deleteBorderFrame)-aBorderWidth, deleteBorderFrame.origin.y)];
                }else{
                    [deleteBorderPath addLineToPoint:CGPointMake(CGRectGetMaxX(deleteBorderFrame), deleteBorderFrame.origin.y)];
                }
            }
            //left
            if (!(aBorderCorners & DPBorderDirectionLeft)) {
                if (aBorderCorners & DPBorderDirectionTop) {
                    [deleteBorderPath moveToPoint:CGPointMake(deleteBorderFrame.origin.x, deleteBorderFrame.origin.y+aBorderWidth)];
                }else{
                    [deleteBorderPath moveToPoint:CGPointMake(deleteBorderFrame.origin.x, deleteBorderFrame.origin.y)];
                }
                if (aBorderCorners & DPBorderDirectionBottom) {
                    [deleteBorderPath addLineToPoint:CGPointMake(deleteBorderFrame.origin.x, CGRectGetMaxY(deleteBorderFrame)-aBorderWidth)];
                }else{
                    [deleteBorderPath addLineToPoint:CGPointMake(deleteBorderFrame.origin.x, CGRectGetMaxY(deleteBorderFrame))];
                }
            }
            //bottom
            if (!(aBorderCorners & DPBorderDirectionBottom)) {
                if (aBorderCorners & DPBorderDirectionLeft) {
                    [deleteBorderPath moveToPoint:CGPointMake(deleteBorderFrame.origin.x+aBorderWidth, CGRectGetMaxY(deleteBorderFrame))];
                }else{
                    [deleteBorderPath moveToPoint:CGPointMake(deleteBorderFrame.origin.x, CGRectGetMaxY(deleteBorderFrame))];
                }
                if (aBorderCorners & DPBorderDirectionRight) {
                    [deleteBorderPath addLineToPoint:CGPointMake(CGRectGetMaxX(deleteBorderFrame)-aBorderWidth, CGRectGetMaxY(deleteBorderFrame))];
                }else{
                    [deleteBorderPath addLineToPoint:CGPointMake(CGRectGetMaxX(deleteBorderFrame), CGRectGetMaxY(deleteBorderFrame))];
                }
            }
            //right
            if (!(aBorderCorners & DPBorderDirectionRight)) {
                if (aBorderCorners & DPBorderDirectionTop) {
                    [deleteBorderPath moveToPoint:CGPointMake(CGRectGetMaxX(deleteBorderFrame), deleteBorderFrame.origin.y+aBorderWidth)];
                }else{
                    [deleteBorderPath moveToPoint:CGPointMake(CGRectGetMaxX(deleteBorderFrame), deleteBorderFrame.origin.y)];
                }
                if (aBorderCorners & DPBorderDirectionBottom) {
                    [deleteBorderPath addLineToPoint:CGPointMake(CGRectGetMaxX(deleteBorderFrame), CGRectGetMaxY(deleteBorderFrame)-aBorderWidth)];
                }else{
                    [deleteBorderPath addLineToPoint:CGPointMake(CGRectGetMaxX(deleteBorderFrame), CGRectGetMaxY(deleteBorderFrame))];
                }
            }
            
            CAShapeLayer * deleteBorderMask  = [[CAShapeLayer alloc] init];
            deleteBorderMask.lineWidth = deleteBorderWidth;
            deleteBorderMask.lineCap = kCALineCapSquare;
            deleteBorderMask.strokeColor = self.backgroundColor.CGColor;
            deleteBorderMask.fillColor = self.backgroundColor.CGColor;
            deleteBorderMask.path = deleteBorderPath.CGPath;
            [self.layer addSublayer:deleteBorderMask];
        }
    }else{
        for (CAShapeLayer *layer in self.layer.sublayers){
            if ([layer isKindOfClass:[CAShapeLayer class]]) {
                if (CGColorEqualToColor(layer.fillColor, aBorderColor.CGColor)) {
                    UIBezierPath *aPath = [UIBezierPath bezierPath];
                    layer.path = aPath.CGPath;
                }
            }
        }
    }
}
@end

#endif
