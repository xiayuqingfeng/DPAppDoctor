//
//  DPLogView.h
//  DPLogView
//
//  Created by yupeng xia on 2021/4/13.
//  Copyright © 2021 yupeng xia. All rights reserved.
//

#import "DPAppDoctor.h"
#ifdef DPAppDoctorDebug

#import <UIKit/UIKit.h>
#import "DPAppDoctor.h"

@interface DPLogView : UIView
- (id)initWithBtnMinY:(CGFloat)aBtnMinY;
@end

#endif
