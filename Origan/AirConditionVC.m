//
//  AirConditionVC.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/21.
//  Copyright © 2017年 David. All rights reserved.
//

#import "AirConditionVC.h"
#import "AirPresentView.h"

@interface AirConditionVC ()
@property(nonatomic, strong) AirPresentView *presentView;


@end

@implementation AirConditionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

    
}

-(void)initUI {
    UIImageView *backImageView = [DVFactory createImageWithFrame:CGRectMake(0, 0, UI_WIDTH, IPHONE_HEIGHT) image:@"111"];
    [self.view addSubview:backImageView];
    
    UIButton *addBtn = [DVFactory createBtnWithCenter:CGPointMake(FitFloat(45), FitFloat(170)) size:CGSizeMake(FitFloat(50), FitFloat(50)) imageNormalStr:@"" imageHighLightStr:nil title:nil font:0];
    [addBtn addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    UIButton *decreaseBtn = [DVFactory createBtnWithCenter:addBtn.center size:addBtn.bounds.size imageNormalStr:@"" imageHighLightStr:nil title:nil font:0];
    [decreaseBtn addTarget:self action:@selector(clickDecreaseBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:decreaseBtn];
    
    [self.view addSubview:self.presentView];
    
    [self initFootControlBtns];

}

-(void)initFootControlBtns {
    
    CGFloat left = FitFloat(29);
    CGFloat width = FitFloat(49);
    CGFloat margin = (UI_WIDTH - left*2 - width*4) / 3.00;
    NSArray *imageNameNorArr = @[@"123---02",@"菜单02",@"信号源02"];
    NSArray *imageNamehighArr = @[@"123---01",@"菜单01",@"信号源01"];
    for (int i = 0; i <3; i ++) {
        UIButton *btn = [DVFactory createBtnWithFrame:CGRectMake(left + (margin+width)*i , FitFloat(490), FitFloat(55), FitFloat(55)) imageNormalStr:imageNameNorArr[i] imageHighLightStr:imageNamehighArr[i] title:nil font:0];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(clickFootControlBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}


-(void)clickFootControlBtn:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - 懒加载
-(AirPresentView *)presentView {
    if (_presentView == nil) {
        _presentView = [[AirPresentView alloc]initWithFrame:CGRectMake(0,0, FitFloat(180),FitFloat(180))];
        _presentView.center = CGPointMake(UI_WIDTH*0.5, FitFloat(180));
    }
    return _presentView;
}

@end
