//
//  DPLeakedHeader.h
//  DPLeaksFinder
//
//  Created by 夏玉鹏 on 20/04/02.
//  Copyright © 2020 夏玉鹏. All rights reserved.
//

#import "DPAppDoctor.h"
#ifdef DPAppDoctorDebug

#import "NSObject+MemoryLeak.h"
#import "UIApplication+MemoryLeak.h"
#import "UINavigationController+MemoryLeak.h"
#import "UIPageViewController+MemoryLeak.h"
#import "UISplitViewController+MemoryLeak.h"
#import "UITabBarController+MemoryLeak.h"
#import "UITouch+MemoryLeak.h"
#import "UIView+MemoryLeak.h"
#import "UIViewController+MemoryLeak.h"

#endif
