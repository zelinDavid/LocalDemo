//
//  DVCustomBtn.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/21.
//  Copyright © 2017年 David. All rights reserved.
//

#import "DVCustomBtn.h"

@implementation DVCustomBtn


+(instancetype)initWithOrigan:(CGPoint)origan imageNor:(NSString *)imageNor imageSel:(NSString *)imageSel title:(NSString *)title {
    DVCustomBtn *btn = [[DVCustomBtn alloc]initWithFrame:CGRectMake(origan.x,origan.y, FitFloat(60), FitFloat(85))];
    
    UIButton *imageBtn = [DVFactory createBtnWithFrame:CGRectMake(0, 0, btn.width,  btn.width) imageNormalStr:imageNor imageHighLightStr:nil title:nil font:0];
    
    return btn;
}

@end
