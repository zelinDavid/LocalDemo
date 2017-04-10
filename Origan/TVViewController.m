//
//  TVViewController.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/20.
//  Copyright © 2017年 David. All rights reserved.
//

#import "TVViewController.h"
#import "DVCustomBtnView.h"
#import "DVDirectionView.h"
#import "SwitchView.h"

@interface TVViewController ()<DVDirectionViewDelegate>
@property(nonatomic, strong) DVCustomBtnView *leftCustomBtnView;
@property(nonatomic, strong) DVCustomBtnView *rightCustomBtnView;
@property(nonatomic, strong) DVDirectionView *directionView;
@property(nonatomic, strong) UIButton *silentBtn;
@property(nonatomic, strong) SwitchView *switchView;
@property(nonatomic, strong) UIView *shelterView;

@end

@implementation TVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    
}

-(void)initShelter {
  BOOL hasShowShelterBool = [[NSUserDefaults standardUserDefaults]boolForKey:@"TVSheleterKey"];
    if (!hasShowShelterBool) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"TVSheleterKey"];
        
        UIImageView *sheleterImageView = [DVFactory createImageWithFrame:CGRectMake(0, 0, UI_WIDTH, IPHONE_HEIGHT) image:@"引导页"];
        sheleterImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShelterPage:)];
        [sheleterImageView addGestureRecognizer:tapGR];
        [self.view addSubview:sheleterImageView];
    }
}

-(void)initUI {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    self.navigationItem.title = @"电视";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickrightBarBtn)];
    
    UIImageView *backImageView = [DVFactory createImageWithFrame:self.view.bounds image:@"control_back"];
    [self.view addSubview:backImageView];
    

    UIButton *silentBtn = [DVFactory createBtnWithCenter:CGPointMake(self.rightCustomBtnView.centerX -FitFloat(2), FitFloat(62)) size:CGSizeMake(FitFloat(60), FitFloat(60)) imageNormalStr:@"静音关01" imageHighLightStr:nil title:nil font:0];
    [silentBtn setImage:[UIImage imageNamed:@"静音开01"] forState:UIControlStateSelected];
    [silentBtn addTarget:self action:@selector(clickSilentBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:silentBtn];
    _silentBtn = silentBtn;
    
    [self.view addSubview:self.leftCustomBtnView];
    [self.view addSubview:self.directionView];
    [self.view addSubview:self.rightCustomBtnView];
    
    [self initFootControlBtns];
    [self.view addSubview:self.switchView];
    
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView)];
    swipeGR.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeGR];
    
}

-(void)initFootControlBtns {
    
    CGFloat left = FitFloat(19);
    CGFloat width = FitFloat(49);
    CGFloat margin = (UI_WIDTH - left*2 - width*4) / 3.00;
    NSArray *imageNameNorArr = @[@"123---02",@"菜单02",@"信号源02",@"返回02"];
    NSArray *imageNamehighArr = @[@"123---01",@"菜单01",@"信号源01",@"返回01"];
    for (int i = 0; i <4; i ++) {
        UIButton *btn = [DVFactory createBtnWithFrame:CGRectMake(left + (margin+width)*i , FitFloat(490), FitFloat(55), FitFloat(55)) imageNormalStr:imageNameNorArr[i] imageHighLightStr:imageNamehighArr[i] title:nil font:0];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(clickFootControlBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

#pragma mark - 点击事件
-(void)swipeView {
    [UIView animateWithDuration:0.2 animations:^{
        self.switchView.alpha = 1;

    }];
}


-(void)clickBackBtn{
    
}

-(void)clickrightBarBtn {
    
}

-(void)clickSilentBtn {
    _silentBtn.selected = !_silentBtn.selected;

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

-(void)tapShelterPage:(UITapGestureRecognizer *)tapGR {
    UIImageView *shelterImageView = (UIImageView *)tapGR.view;
    [shelterImageView removeFromSuperview];
    
}

#pragma mark - DirectionViewdelegate
-(void)upBtnClicked {
    
}

-(void)downBtnClicked {
    
}

-(void)leftBtnClicked {
    
}

-(void)rightBtnClicked {
    
}

-(void)okBtnClicked {
    
}


#pragma mark - 懒加载
-(DVCustomBtnView *)leftCustomBtnView {
    if (_leftCustomBtnView == nil) {
        _leftCustomBtnView = [DVCustomBtnView customInitWithTopImageNormal:[UIImage imageNamed:@"加02"] imageHighLight:[UIImage imageNamed:@"加01"] BottomImageNormal:[UIImage imageNamed:@"减02"] bottomImageHighLight:[UIImage imageNamed:@"减01"]];
        _leftCustomBtnView.center = CGPointMake(FitFloat(38), FitFloat(290));

        [_leftCustomBtnView topBtnClik:^{
            
        }];
        
        [_leftCustomBtnView bottomBtnClick:^{
            
        }];
    }
    return _leftCustomBtnView;
}

-(DVCustomBtnView *)rightCustomBtnView {
    if (_rightCustomBtnView == nil) {
        _rightCustomBtnView =  [DVCustomBtnView customInitWithTopImageNormal:[UIImage imageNamed:@"向上02"] imageHighLight:[UIImage imageNamed:@"向上01"] BottomImageNormal:[UIImage imageNamed:@"向下02"] bottomImageHighLight:[UIImage imageNamed:@"向下01"]];
        _rightCustomBtnView.center = CGPointMake(FitFloat(335), self.leftCustomBtnView.centerY);
        

        [_rightCustomBtnView topBtnClik:^{
            
        }];
        
        [_rightCustomBtnView bottomBtnClick:^{
            
        }];
    }
    return _rightCustomBtnView;
}

-(DVDirectionView *)directionView {
    if (_directionView == nil) {
        _directionView = [[DVDirectionView alloc]customInit];
        _directionView.center = CGPointMake(UI_WIDTH*0.5,self.leftCustomBtnView.centerY);
        _directionView.delegate = self;
    }
    return _directionView;
}

-(SwitchView *)switchView {
    if (_switchView == nil) {
        _switchView = [[SwitchView alloc]initWithFrame:self.view.frame];
        _switchView.alpha = 0;
        [_switchView sendPowerState:YES];
    }
    return _switchView;
}

-(UIView *)shelterView {
    if (_shelterView == nil) {
        _shelterView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        UIImageView *backImageView = [DVFactory createImageWithFrame:_shelterView.bounds image:@""];
        [_shelterView addSubview:backImageView];
        
        UILabel *titleLabel = [DVFactory createLabelWithCenter:CGPointMake(UI_CenterX, FitFloat(135)) size:CGSizeMake(FitFloat(150), FitFloat(45)) title:nil font:0 textAlign:NSTextAlignmentCenter];
        NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont systemFontOfSize:15.0],NSFontAttributeName,
                                       [UIColor redColor],NSForegroundColorAttributeName,
                                       nil];
        
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:@"往下拖动可以看到 \"关闭按钮\"" attributes:@{}];
        
        
        
        
    }
    return _shelterView;
}



@end
