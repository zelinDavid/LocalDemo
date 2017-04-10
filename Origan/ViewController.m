//
//  ViewController.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/9.
//  Copyright © 2017年 David. All rights reserved.
//

#import "ViewController.h"
#import "DVDirectionView.h"
#import "TVViewController.h"
#import "AirConditionVC.h"
#import "TVNumViewController.h"
#import "DVDeviceCollectionVC.h"

#import "TestView.h"


NSString  *const test = @"hhaha";

@interface ViewController ()<DVDirectionViewDelegate>

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestView *testView = [[TestView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:testView];
    
    
    

}



-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.08 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        TVViewController *vc = [[TVViewController alloc]init];
////        AirConditionVC *vc = [[AirConditionVC alloc]init];
//        TVNumViewController *vc = [[TVNumViewController alloc] init];
        
//        DVDeviceCollectionVC *vc = [[DVDeviceCollectionVC alloc]init];
//        [self presentViewController:vc animated:YES completion:nil];
        
    });
}






-(void)upBtnClicked {
    NSLog(@"up");
}

-(void)downBtnClicked {
    NSLog(@"down");

}







@end
