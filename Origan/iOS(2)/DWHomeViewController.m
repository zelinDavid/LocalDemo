//
//  DWHomeViewController.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWHomeViewController.h"
#import "ViewController.h"
#import "TestViewController.h"

#import "AppDelegate.h"
@interface DWHomeViewController()
@property(nonatomic, strong) UIViewController *currentVC;
@property(nonatomic, strong) UIViewController *first;
@property(nonatomic, strong) UIViewController *second;

@end

@implementation DWHomeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text = @"DWHomeViewController.h";
    [self.view addSubview:label];
    
    
//    ViewController *vvv =[[ViewController alloc]init];
//    [self addChildViewController:vvv];
//    [vvv didMoveToParentViewController:self];
//    vvv.view.frame = CGRectMake(0, 0, 100, 200);
//    vvv.view.backgroundColor =  [UIColor blackColor];
//    [self.view addSubview:vvv.view];
//    _first = vvv;
//    _currentVC = _first;
//    vvv.view.hidden = NO;
//    
//    TestViewController *test =[[TestViewController alloc]init];
//    [self addChildViewController:test];
//    [test didMoveToParentViewController:self];
//    test.view.frame = CGRectMake(200, 200, 100, 200);
//    test.view.backgroundColor =  [UIColor orangeColor];
//    [self.view addSubview:test.view];
//    _second = test;
//    vvv.view.hidden = YES;
}


// 切换各个不同的控制器视图
- (void)switchController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
//    [self addChildViewController:newController];
    
    [self transitionFromViewController:oldController toViewController:newController duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
//            [newController didMoveToParentViewController:self];
//            [oldController willMoveToParentViewController:nil];
//            [oldController removeFromParentViewController];
            self.currentVC = newController;
            newController.view.hidden = NO;
            oldController.view.hidden = YES;
        }else{
            self.currentVC = oldController;
        }
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ViewController *vvv =[[ViewController alloc]init];
    [self addChildViewController:vvv];
    [vvv didMoveToParentViewController:self];
    vvv.view.frame =  self.view.bounds;
    vvv.view.backgroundColor =  [UIColor blackColor];
    vvv.view.alpha = 0;
    [self.view addSubview:vvv.view];
    _first = vvv;
    _currentVC = _first;
    vvv.view.hidden = NO;
    DVNavigationController *nav = self.navigationController;
    nav.orietation = 1;
    [self.tabBarController.tabBar setHidden:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        vvv.view.alpha = 1;
    }];
    
}

 


@end
