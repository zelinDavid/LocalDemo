//
//  DVSuperViewController.m
//  DVBands
//
//  Created by Devond on 15/11/12.
//  Copyright (c) 2015年 Devond. All rights reserved.
//

#import "DVSuperViewController.h"

@interface DVSuperViewController ()

@end

@implementation DVSuperViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenNavigationBarBottomLine:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
 
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"newBackImage"] style:UIBarButtonItemStylePlain target:self action:@selector(clickleftBtn)];
    [self navigationButton];
}

-(void) navigationButton
{
    UIImage *backImg = [UIImage imageNamed:@"newBackImage.png"];
    CGFloat width = backImg.size.width;
    CGFloat height = backImg.size.height;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 30, width, height);
    
    [button setImage:backImg forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc] initWithCustomView:button];

    
    //创建UIBarButtonSystemItemFixedSpace
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -15;
    //将两个BarButtonItem都返回给NavigationItem
    self.navigationItem.leftBarButtonItems = @[spaceItem,buttonLeft];
}

-(void)backToViewController {
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)clickleftBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


- (void)hiddenNavigationBarBottomLine:(BOOL)hidden{
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = hidden;
}



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate {
    return YES;
    
}


- (void)dealloc{
#ifdef DEBUG
//    NSString *str = NSStringFromClass(self.class);
//    NSLog(@"*****  [%@] dealloced  *****", str);
#endif
}



@end
