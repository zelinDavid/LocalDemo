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
#import "ShelterView.h"

#import "AppDelegate.h"
@interface DWHomeViewController()
@property(nonatomic, strong) UIViewController *currentVC;
@property(nonatomic, strong) UIViewController *first;
@property(nonatomic, strong) UIViewController *second;
@property(nonatomic, strong) ShelterView *shelterView;

@end

@implementation DWHomeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
}

-(void)viewDidAppear:(BOOL)animated{
    [self initNV];
    
}


-(void)initNV
{
    NSInteger cameraNum = 3;
    NSInteger singleNum = 1;
    NSLog(@"cameraNum:%ld %ld",(long)cameraNum,(long)singleNum);
    
    UIButton *rightSet = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSet setFrame:CGRectMake(0, 0, 26, 26)];
    [rightSet setImage:[UIImage imageNamed:@"homePageAdd.png"] forState:UIControlStateNormal];
    [rightSet addTarget:self action:@selector(rightButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonRight = [[UIBarButtonItem alloc] initWithCustomView:rightSet];
    
    if (cameraNum > 1) {
        UIButton *rightSet2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightSet2 setFrame:CGRectMake(0, 0, 20, 20)];
        [rightSet2 setImage:[UIImage imageNamed:@"muscreen.png"] forState:UIControlStateNormal];
        [rightSet2 addTarget:self action:@selector(pushtoplayVC) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:rightSet2];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = 15;
        
        self.navigationItem.rightBarButtonItems = @[buttonRight,space,rightButtonItem2];
    } else {
        self.navigationItem.rightBarButtonItems = @[buttonRight];
    }
    
    
    CGRect frame = [rightSet.superview convertRect:rightSet.frame toView:self.navigationController.view];
    NSLog(@"%@",NSStringFromCGRect(frame));
    
    UIButton *shelterBtn = [[UIButton alloc]initWithFrame:frame];
    [shelterBtn setImage:[UIImage imageNamed:@"homePageAdd"] forState:UIControlStateNormal];
    [shelterBtn setBackgroundColor:[UIColor redColor]];
    
    [self.shelterView addSubview:shelterBtn];
    
    UIImageView *hand = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"手-"]];
    hand.right  = shelterBtn.centerX;
    hand.top = shelterBtn.bottom + FitFloat(20);
    [self.shelterView addSubview:hand];
    
    [self.navigationController.view addSubview:self.shelterView];
   
    NSString *yellowStr = @"添加设备";
    NSString *hereStr = @"点击这里哦";
    NSString *finalStr = [NSString stringWithFormat:@"\"%@\" %@",yellowStr,hereStr];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:finalStr attributes:@{NSFontAttributeName:FitFont(17),NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [attributeStr setAttributes:@{NSForegroundColorAttributeName:RGBFromHex(0xfffc08),NSFontAttributeName:FitFont(17)} range:NSMakeRange([finalStr rangeOfString:yellowStr].location-1, yellowStr.length +2)];
    
    CGRect bounds =  [attributeStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:bounds];
    tipLabel.top = hand.bottom + 20;
    tipLabel.right = hand.right;
    tipLabel.attributedText = attributeStr;
    [self.shelterView addSubview:tipLabel];
    
    UILabel *knowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, FitFloat(370), 200, 25)];
    knowLabel.centerX = UI_CenterX;
    knowLabel.textColor = [UIColor whiteColor];
    knowLabel.textAlignment = NSTextAlignmentCenter;
    knowLabel.font = FitFont(17);
    knowLabel.text = @"wozhid";
    [self.shelterView addSubview:knowLabel];
    
    
}

 
#pragma mark -懒加载
-(ShelterView *)shelterView {
    if (_shelterView == nil) {
        _shelterView = [[ShelterView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
    }
    return _shelterView;
}

@end
