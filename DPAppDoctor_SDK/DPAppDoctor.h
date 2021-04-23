//
//  DPHeaderObject.h
//  DPAppDoctor
//
//  Created by yupeng xia on 2021/4/20.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#ifndef DPAppDoctor_h
#define DPAppDoctor_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define DPAppDoctorDebug 1
#endif

#ifdef DPAppDoctorDebug

#import "DPNormal.h"
#import "DPExtension.h"
#import "DPAppDoctorManager.h"

#endif

#endif /* DPAppDoctor_h */
