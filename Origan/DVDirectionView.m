//
//  DVDirectionView.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/20.
//  Copyright © 2017年 David. All rights reserved.
//

#import "DVDirectionView.h"
#import "OBShapedButton.h"
@interface DVDirectionView ()
@property(nonatomic, strong) OBShapedButton *upBtn;
@property(nonatomic, strong) OBShapedButton *downBtn;
@property(nonatomic, strong) OBShapedButton *leftBtn;
@property(nonatomic, strong) OBShapedButton *rightBtn;
@property(nonatomic, strong) OBShapedButton *okBtn;

@end

@implementation DVDirectionView

-(instancetype)customInit {
    DVDirectionView *directionView = [super initWithFrame:CGRectMake(0, 0, FitFloat(234), FitFloat(234))];
    if (directionView == nil) {
        return directionView;
    }

    UIImage *upImage = [UIImage imageNamed:@"上02"];
        _upBtn = [[OBShapedButton alloc]initWithFrame:CGRectMake(0, 0, upImage.width, upImage.height)];
        _upBtn.center = CGPointMake(directionView.width*0.5, upImage.height*0.5);

    [_upBtn setImage:upImage forState:UIControlStateNormal];
    [_upBtn setImage:[UIImage imageNamed:@"上01"] forState:UIControlStateHighlighted];
    [_upBtn addTarget:self action:@selector(clickUpBtn) forControlEvents:UIControlEventTouchUpInside];
    [directionView addSubview:_upBtn];
    
    
    UIImage *downImage = [UIImage imageNamed:@"下02"];
    _downBtn = [[OBShapedButton alloc]initWithFrame:CGRectMake(0, 0, downImage.width, downImage.height)];
    _downBtn.center = CGPointMake(directionView.width*0.5,directionView.height - downImage.height*0.5);
    [_downBtn setImage:downImage forState:UIControlStateNormal];
    [_downBtn setImage:[UIImage imageNamed:@"下01"] forState:UIControlStateHighlighted];
    [_downBtn addTarget:self action:@selector(clickDownBtn) forControlEvents:UIControlEventTouchUpInside];
    [directionView addSubview:_downBtn];
    
    
    UIImage *leftImage = [UIImage imageNamed:@"左02"];
    _leftBtn = [[OBShapedButton alloc]initWithFrame:CGRectMake(0, 0, leftImage.width, leftImage.height)];
    _leftBtn.center = CGPointMake(leftImage.width*0.5, directionView.height*0.5);
    [_leftBtn setImage:leftImage forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage imageNamed:@"左01"] forState:UIControlStateHighlighted];
    [_leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [directionView addSubview:_leftBtn];
    
    UIImage *rightImage = [UIImage imageNamed:@"右02"];
    _rightBtn = [[OBShapedButton alloc]initWithFrame:CGRectMake(0, 0, rightImage.width, rightImage.height)];
    _rightBtn.center = CGPointMake(directionView.width - rightImage.width*0.5, directionView.height*0.5);
    [_rightBtn setImage:rightImage forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"右01"] forState:UIControlStateHighlighted];
    [_rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    [directionView addSubview:_rightBtn];
    
    
    UIImage *okImage = [UIImage imageNamed:@"OK02"];
    _okBtn = [[OBShapedButton alloc]initWithFrame:CGRectMake(0, 0, okImage.width, okImage.height)];
    _okBtn.center = CGPointMake(directionView.width*0.5, directionView.height*0.5);
    [_okBtn setImage:okImage forState:UIControlStateNormal];
    [_okBtn setImage:[UIImage imageNamed:@"OK01"] forState:UIControlStateHighlighted];
    [_okBtn addTarget:self action:@selector(clickOkBtn) forControlEvents:UIControlEventTouchUpInside];
    [directionView addSubview:_okBtn];
    
    return directionView;
}


-(void)clickUpBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(upBtnClicked)]) {
        [self.delegate upBtnClicked];
    }
}

-(void)clickDownBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(downBtnClicked)]) {
        [self.delegate downBtnClicked];
    }
}

-(void)clickLeftBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftBtnClicked)]) {
        [self.delegate leftBtnClicked];
    }
}

-(void)clickRightBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightBtnClicked)]) {
        [self.delegate rightBtnClicked];
    }
}

-(void)clickOkBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(okBtnClicked)]) {
        [self.delegate okBtnClicked];
    }
}

@end
