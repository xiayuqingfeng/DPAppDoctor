//
//  NSString+DPExtension.h
//  DPAppDoctor
//
//  Created by yupeng xia on 2021/4/15.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import "DPHeaderObject.h"

@interface NSString (DPExtension)
///获取字符串中多个相同字符串的所有range
- (NSArray <NSValue *>*)dpRangeOfSubString:(NSString*)subStr;
@end
