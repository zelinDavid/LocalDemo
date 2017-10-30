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

@interface DWMineViewController ()<UIAlertViewDelegate>

@end
@implementation DWMineViewController {
    UIAlertController *alert;
    UIAlertView *alertView;
}
-(void)viewDidLoad {
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationWillEnterForegroundNotification object:nil]; //监听是否重新进入程序.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];

}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:@"ddd" message:@"dddd"
                                                  delegate:self cancelButtonTitle:@"dddd" otherButtonTitles:nil, nil];
    [myalert show];
    alertView = myalert;

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

-(void)applicationDidBecomeActive {
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)didEnterBackground {
//    [alert dismissViewControllerAnimated:YES completion:nil];
    [alertView dismissWithClickedButtonIndex:0 animated:0];
    
    
}


@end
