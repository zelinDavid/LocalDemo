//
//  DVCustomBtnView.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/21.
//  Copyright © 2017年 David. All rights reserved.
//

#import "DVCustomBtnView.h"
@interface DVCustomBtnView ()
@property(nonatomic, copy) ClickBlock  topBlock;
@property(nonatomic, copy) ClickBlock  bottomBlock;


@end

@implementation DVCustomBtnView

+(instancetype)customInitWithTopImageNormal:(UIImage *)topImage imageHighLight:(UIImage *)topImageHight BottomImageNormal:(UIImage *)bottomImage bottomImageHighLight:(UIImage *)bottomImagehighLight{
    DVCustomBtnView *customView = [[DVCustomBtnView alloc]initWithFrame:CGRectMake(0, 0, FitFloat(50), FitFloat(225))];
    
    UIButton *topBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, customView.width, customView.height*0.5 -FitFloat(2))];
    [topBtn setImage:topImage forState:UIControlStateNormal];
    [topBtn setImage:topImageHight forState:UIControlStateHighlighted];
    [topBtn addTarget:customView action:@selector(clickTopBtn) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:topBtn];
    customView.topBtn = topBtn;
    
    UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBtn.frame)+FitFloat(4), customView.width, topBtn.height-FitFloat(2))];
    [bottomBtn setImage:bottomImage forState:UIControlStateNormal];
    [bottomBtn setImage:bottomImagehighLight forState:UIControlStateHighlighted];
    [bottomBtn addTarget:customView action:@selector(clickBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:bottomBtn];
    customView.topBtn = bottomBtn;
    
    return customView;
}

-(void)clickTopBtn {
    if (_topBlock != nil) {
        _topBlock();
    }
}

-(void)clickBottomBtn {
    if (_bottomBlock != nil) {
        _bottomBlock();
    }

}


-(void)topBtnClik:(ClickBlock)clickBlock {
    _topBlock = clickBlock;
}

-(void)bottomBtnClick:(ClickBlock)clickBlock {
   _bottomBlock = clickBlock;
}



@end
