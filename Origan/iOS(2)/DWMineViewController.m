//
//  DWMineViewController.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWMineViewController.h"
#import "DWHomeViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@implementation DWMineViewController
-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIView *tem = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    tem.backgroundColor = [UIColor greenColor ];
    [self.view addSubview:tem];

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text = @"DWMineViewController.h";
    [self.view addSubview:label];
}



//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    AppDelegate *ap = [UIApplication sharedApplication].delegate;
//    ap.allowRotation = YES;
//}
//
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    AppDelegate *ap = [UIApplication sharedApplication].delegate;
//    ap.allowRotation = NO;
//    
//}


-(BOOL)shouldAutorotate {
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    ViewController *vc = [[ViewController alloc]init];
    [self.navigationController pushViewController:vc  animated:YES];

    
}



@end
