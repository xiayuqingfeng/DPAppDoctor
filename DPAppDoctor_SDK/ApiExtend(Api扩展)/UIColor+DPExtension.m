//
//  UIColor+DPExtension.m
//  DPAppDoctor
//
//  Created by yupeng xia on 2021/4/19.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import "UIColor+DPExtension.h"

@implementation UIColor (DPExtension)
+ (UIColor *)dpColorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    
    // #RGB
    alpha = 1.0f;
    red = [UIColor colorComponentFrom:colorString start:0 length:2];
    green = [UIColor colorComponentFrom:colorString start:2 length:2];
    blue  = [UIColor colorComponentFrom:colorString start:4 length:2];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}

- (NSString *)dpHexStringFromColor {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}
@end
