//
//  LeakedViewController.m
//  test
//
//  Created by 夏玉鹏 on 2020/04/02.
//  Copyright © 2018 yupeng xia. All rights reserved.
//

#import "LeakedViewController.h"

@interface LeakedViewController (){
    
}

@end

@implementation LeakedViewController
- (void)dealloc {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:aTimer forMode:NSRunLoopCommonModes];
}
- (void)timerEvent{
    self.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1];
}
- (IBAction)dismissBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
