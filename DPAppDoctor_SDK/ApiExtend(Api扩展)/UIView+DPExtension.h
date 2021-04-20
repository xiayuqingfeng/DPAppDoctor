//
//  UIView+DPExtension.h
//  DPAppDoctor
//
//  Created by yupeng xia on 2021/3/16.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, DPBorderDirection) {//需要显示的边框方向
    DPBorderDirectionTop          = 1 << 0,
    DPBorderDirectionLeft         = 1 << 1,
    DPBorderDirectionBottom       = 1 << 2,
    DPBorderDirectionRight        = 1 << 3,
    DPBorderDirectionAllCorners   = ~0UL
};

@interface UIView (DPExtension)
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = x
 */
@property (nonatomic) CGFloat xDP;

/**
 * Shortcut for frame.origin.y.
 *
 * Sets frame.origin.x = y
 */
@property (nonatomic) CGFloat yDP;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = xMax - frame.size.width
 */
@property (nonatomic) CGFloat xMaxDP;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = yMax - frame.size.height
 */
@property (nonatomic) CGFloat yMaxDP;

/**
 * Shortcut for frame.size
 *
 * Sets frame.size = size
 */
@property (nonatomic) CGSize sizeDP;

/**
 * Shortcut for frame.origin
 *
 * Sets frame.origin = origin
 */
@property (nonatomic) CGPoint originDP;

/**
 * Shortcut for frame.origin.x
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat leftDP;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat topDP;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat rightDP;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottomDP;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat widthDP;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat heightDP;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerXDP;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerYDP;

///自定义圆角,边框; aRoundingCorners:枚举值,圆角位置; aRadius:圆角半径; aBorderCorners:枚举值,边框位置; aBorderWidth:边框宽度; aBorderColor:边框颜色;
- (void)setDPRoundingCorners:(UIRectCorner)aRoundingCorners radius:(CGFloat)aRadius borderCorners:(DPBorderDirection)aBorderCorners borderWidth:(CGFloat)aBorderWidth borderColor:(UIColor *)aBorderColor;
@end
