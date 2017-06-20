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
@property (nonatomic, assign)BOOL back;
@property(nonatomic, strong) UIButton *btn;

@end

@implementation ViewController


- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor redColor];
    [super viewDidLoad];
 
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text = @"viewController";
    [self.view addSubview:label];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 200)];
    [btn addTarget:self action:@selector(fffff) forControlEvents:UIControlEventTouchUpInside];
    _btn = btn;
    [self.view addSubview:btn];
    [btn setBackgroundColor:[UIColor blueColor]];
    
}

-(void)fffff {
//    [self.view removeFromSuperview];
//    [JHRotatoUtil forceOrientation: UIInterfaceOrientationPortrait];
//    _back = YES;
    _back = YES;
    DVNavigationController *nav  = self.navigationController;
    nav.orietation = 0;
[JHRotatoUtil forceOrientation: UIInterfaceOrientationPortrait];

}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [JHRotatoUtil forceOrientation: UIInterfaceOrientationLandscapeRight];

}

//iOS8旋转动作的具体执行
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator: coordinator];
    // 监察者将执行： 1.旋转前的动作  2.旋转后的动作（completion）
   BOOL tem =  [coordinator animateAlongsideTransition: ^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         if ([JHRotatoUtil isOrientationLandscape]) {
              [self p_prepareFullScreen];
         }
         else {
             [self p_prepareSmallScreen];
         }
     } completion: ^(id<UIViewControllerTransitionCoordinatorContext> context) {
         
        
     }];
    if (tem) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_back== NO) {
                return ;
            }
//            [self.view removeFromSuperview];
//            [self didMoveToParentViewController:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        });
    }
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id <UIContentContainer>)container {
//    if (_back) {
//        [UIView animateWithDuration:0.2 animations:^{
//            self.view.alpha = 0;
//        }completion:^(BOOL finished) {
//            [self.view removeFromSuperview];
//            [self didMoveToParentViewController:nil];
//        }];
//        
//    }
}



//-(BOOL)shouldAutorotate {
//    //    if ([NSStringFromClass([self.topViewController class]) isEqualToString:@"ViewController"]) {
//    //        return YES ;
//    //    }
//    //    return NO;
//    return YES;
//}
//
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAll;
//
//}


#pragma mark - Private

// 切换成全屏的准备工作
- (void)p_prepareFullScreen {
    _btn.width = 300;
    _btn.height = 400;
    
}

// 切换成小屏的准备工作
- (void)p_prepareSmallScreen {
    _btn.width = 100;
    _btn.height = 200;
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
