//
//  ViewController.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/9.
//  Copyright © 2017年 David. All rights reserved.
//

#import "ViewController.h"
#import "LoadingView.h"

@interface ViewController ()
@property (nonatomic, assign)BOOL back;
@property(nonatomic, strong) UIButton *btn;
 
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoadingView *view = [[LoadingView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    [self.view addSubview:view];
    
   __block  CGFloat test = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        test= test+ 0.05;
        [view updateLoadingViewWithProgroess:test];
    }];
    
    
 
    
}




@end
