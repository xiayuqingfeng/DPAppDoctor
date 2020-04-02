//
//  ZhcwCollegeSDK.m
//  ZhcwCollegeSDK
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "DPAppDoctor.h"

static DPAppDoctor *_zhcwTool = nil;
@implementation DPAppDoctor
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_zhcwTool == nil) {
            _zhcwTool = [[self alloc]init];
        }
    });
    return _zhcwTool;
}
@end
