//
//  CheckNetWorkBytes.h
//  DPAppDoctor
//
//  Created by xiayupeng on 2020/4/4.
//  Copyright © 2020 yupeng xia. All rights reserved.
//

#import "DPAppDoctor.h"
#ifdef DPAppDoctorDebug

@interface CheckNetWorkBytes : NSObject
///获取当前网络流量 kb
+ (NSString *)getNetWorkBytesPerSecond;
@end

#endif
