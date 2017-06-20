//
//  ViewController.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/9.
//  Copyright © 2017年 David. All rights reserved.
//

#import "ViewController.h"
#import "DWMineViewController.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import "AppDelegate.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor redColor];
    [super viewDidLoad];
 
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text = @"viewController";
    [self.view addSubview:label];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [btn addTarget:self action:@selector(ffffff) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn setBackgroundColor:[UIColor blueColor]];
    
}

-(void)ffffff {
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [JHRotatoUtil forceOrientation: UIInterfaceOrientationLandscapeRight];

}

//iOS8旋转动作的具体执行
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator: coordinator];
    // 监察者将执行： 1.旋转前的动作  2.旋转后的动作（completion）
    [coordinator animateAlongsideTransition: ^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         if ([JHRotatoUtil isOrientationLandscape]) {
              [self p_prepareFullScreen];
         }
         else {
             [self p_prepareSmallScreen];
         }
     } completion: ^(id<UIViewControllerTransitionCoordinatorContext> context) {
     }];
    
}


#pragma mark - Private

// 切换成全屏的准备工作
- (void)p_prepareFullScreen {
  
}

// 切换成小屏的准备工作
- (void)p_prepareSmallScreen {
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if([JHRotatoUtil isOrientationLandscape]) {
        [JHRotatoUtil forceOrientation: UIInterfaceOrientationPortrait];
    }
    else {
        [JHRotatoUtil forceOrientation: UIInterfaceOrientationLandscapeRight];
    }
}


-(void)dealloc {
    NSLog(@"viewcontroller");

}
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    AppDelegate *app = MYAppDelegate;
//    app.allowRotation = YES;
//}
//
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    AppDelegate *app = MYAppDelegate;
//    app.allowRotation = NO;
//}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
//    TestViewController *vc = [[TestViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}


@end
