//
//  NSString+DPExtension.m
//  DPAppDoctor
//
//  Created by yupeng xia on 2021/4/15.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import "NSString+DPExtension.h"

@implementation NSString (DPExtension)
///获取字符串中多个相同字符串的所有range
- (NSArray <NSValue *>*)dpRangeOfSubString:(NSString*)subStr {
    NSMutableArray <NSValue *>*rangeArray = [NSMutableArray array];
    //当前字符串，尾部拼接查找字符串，防止遍历查找越界
    NSString *sumString = [self stringByAppendingString:subStr];
    for(int i = 0; i < self.length; i ++) {
        NSString *temp = [sumString substringWithRange:NSMakeRange(i, subStr.length)];
        if ([temp isEqualToString:subStr]) {
            NSRange range = {i,subStr.length};
            [rangeArray addObject:[NSValue valueWithRange:range]];
        }
    }
    return rangeArray;
}
@end
