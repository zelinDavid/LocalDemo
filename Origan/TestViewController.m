//
//  TestViewController.m
//  Origan
//
//  Created by David on 17/6/19.
//  Copyright © 2017年 David. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text = @"TestViewController";
    [self.view addSubview:label];
    self.view.backgroundColor = [UIColor greenColor];
}


-(void)dealloc {
    NSLog(@"test");
}

@end
