//
//  SwitchView.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/21.
//  Copyright © 2017年 David. All rights reserved.
//

#import "SwitchView.h"
@interface SwitchView()
@property(nonatomic, strong) UIImageView *backView;
@property(nonatomic, strong) UIButton *controlBtn;

@end
@implementation SwitchView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _backView = [DVFactory  createImageWithFrame:frame image:@"电源（待关闭）"];
        _backView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackView)];
        [_backView addGestureRecognizer:tapGR];
        [self addSubview:_backView];
        
        UIButton *controlBtn = [DVFactory createBtnWithCenter:CGPointMake(UI_WIDTH*0.5, UI_HEIGHT*0.5) size:CGSizeMake(FitFloat(150), FitFloat(150)) imageNormalStr:nil imageHighLightStr:nil title:nil  font:0];
        [controlBtn addTarget:self action:@selector(clickControlBtn:) forControlEvents:UIControlEventTouchUpInside];
        [controlBtn addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
        [self addSubview:controlBtn];
        _controlBtn = controlBtn;
//        _controlBtn.backgroundColor = [UIColor greenColor];
        
    }
    return self;
}


-(void)clickBackView {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    }];
}

-(void)clickControlBtn:(UIButton *)controlBtn {
    controlBtn.selected = !controlBtn.selected;
   
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selected"]) {
        CATransition *transition = [CATransition animation];
            transition.repeatCount = 1;
            transition.type = kCATransitionFade;
            transition.duration = 0.2;
            transition.fillMode = kCAFillModeForwards;
            [_backView.layer addAnimation:transition forKey:nil];
        
            if (_controlBtn.selected) {
                _backView.image = [UIImage imageNamed:@"电源（待关闭）"];
        
            }else {
                _backView.image = [UIImage imageNamed:@"电源（已关闭）"];
            }
    }
}


-(void)sendPowerState:(BOOL)openBool {
    _controlBtn.selected = openBool;
}


@end
