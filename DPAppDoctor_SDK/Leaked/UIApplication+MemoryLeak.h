//
//  UIApplication+MemoryLeak.h
//  MLeaksFinder
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLeaksFinder.h"

#if _INTERNAL_MLF_ENABLED

@interface UIApplication (MemoryLeak)

@end

#endif
