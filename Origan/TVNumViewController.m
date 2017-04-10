//
//  TVNumView.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/22.
//  Copyright © 2017年 David. All rights reserved.
//

#import "TVNumViewController.h"
@interface  DVNumBtn :UIButton

@end

@implementation DVNumBtn


+(instancetype)customInitWithOrigan:(CGPoint)origan title:(NSString *)title width:(CGFloat)width {
    UIButton *btn =[DVFactory createBtnWithFrame:CGRectMake(origan.x, origan.y, width,width) imageNormalStr:nil imageHighLightStr:nil title:title font:24];
    btn.layer.cornerRadius = FitFloat(31);
    btn.layer.borderColor = RGBFromHex(0x91adaf).CGColor;
    btn.layer.borderWidth = FitFloat(1.5);
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = FitFont(24);

    [btn setTitleColor:RGBFromHex(0x91adaf) forState:UIControlStateNormal];
    [btn setBackgroundImage:[self createImageWithColor:RGBAFromHex(0x91adaf, 1)] forState:UIControlStateHighlighted];
    [btn setTitleColor:RGBFromHex(0x333333) forState:UIControlStateHighlighted];
    
    return (DVNumBtn *)btn;
    
}

+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

@implementation TVNumViewController


-(void)viewDidLoad {
    [super viewDidLoad];

    NSArray *infoArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"-/--",@"0",@"OK"];
    
    CGFloat width = FitFloat(65);
    CGFloat margin = (UI_WIDTH - 3 * width)/4.00;
    CGFloat top = FitFloat(185);
    [infoArr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        int numX = idx % 3;
        int numY = (int)idx / 3;
        
        DVNumBtn *numBtn = [DVNumBtn customInitWithOrigan:CGPointMake(margin*(numX+1)+width*numX, top + (margin+width)*numY) title:title width:width];
        [numBtn addTarget:self action:@selector(clickNumBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:numBtn];
    }];
    
    
    UIButton *cancelBtn = [DVFactory createBtnWithCenter:CGPointMake(0, FitFloat(630)) size:CGSizeMake(FitFloat(60), FitFloat(60)) imageNormalStr:@"菜单02" imageHighLightStr:nil title:nil font:0];
    cancelBtn.centerX = UI_CenterX;
    [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
        
}


-(void)clickNumBtn:(UIButton *)btn {
    
    
}


-(void)clickCancelBtn {
    
    
}

@end
