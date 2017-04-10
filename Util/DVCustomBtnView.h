//
//  DVCustomBtnView.h
//  Origan
//
//  Created by LiJiaHuan on 17/3/21.
//  Copyright © 2017年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock) ();

@interface DVCustomBtnView : UIView
@property(nonatomic, strong) UIButton *topBtn;
@property(nonatomic, strong) UIButton *bottomBtn;

+(instancetype)customInitWithTopImageNormal:(UIImage *)topImage imageHighLight:(UIImage *)topImageHight BottomImageNormal:(UIImage *)bottomImage bottomImageHighLight:(UIImage *)bottomImagehighLight;
-(void)topBtnClik:(ClickBlock) clickBlock;
-(void)bottomBtnClick:(ClickBlock) clickBlock;

@end
