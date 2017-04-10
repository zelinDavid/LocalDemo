//
//  AirPresentView.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/21.
//  Copyright © 2017年 David. All rights reserved.
//

#import "AirPresentView.h"
@interface AirPresentView ()
@property(nonatomic, strong) UILabel *temperaLabe;
@property(nonatomic, strong) UILabel *modelLabel;
@property(nonatomic, strong) UILabel *saofengLabel;

@end

@implementation AirPresentView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = FitFloat(frame.size.width*0.5);
        self.layer.borderColor = ColorFromRGB(26, 63, 85, 1).CGColor;
        self.layer.borderWidth = FitFloat(1.5);
        self.layer.masksToBounds = YES;
        
        _temperaLabe = [DVFactory createLabelWithCenter:CGPointMake(frame.size.width*0.5, FitFloat(61)) size:CGSizeMake(FitFloat(140),FitFloat(60) ) title:nil font:FitFloat(42) textAlign:NSTextAlignmentCenter];
        [self addSubview:_temperaLabe];
        
        _modelLabel = [DVFactory createLabelWithCenter:CGPointMake(frame.size.width*0.5, FitFloat(110)) size:CGSizeMake(_temperaLabe.width, FitFloat(25)) title:nil font:15 textAlign:NSTextAlignmentCenter];
        [self addSubview:_modelLabel];
        
        _saofengLabel = [DVFactory createLabelWithCenter:CGPointMake(frame.size.width*0.5, FitFloat(130)) size:_modelLabel.bounds.size title:nil font:11 textAlign:NSTextAlignmentCenter];
        [self addSubview:_saofengLabel];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 42, 230, 101, 1);//改变画笔颜色
    CGContextMoveToPoint(context, self.width*0.5, self.height*0.5);//开始坐标p1
    
    int tempareture = [_temperaLabe.text intValue];
    CGContextAddArc(context, FitFloat(1.5), self.height*0.5, FitFloat(1.5), 0, M_PI *(tempareture - 10.00)/(30-10) , NO);
    CGContextStrokePath(context);//绘画路径
    
}

-(void)changeTempareture:(int) tempareture{
    _temperaLabe.text = [NSString stringWithFormat:@"%d",tempareture];
    [self setNeedsDisplay];
}

-(void)changeModel:(NSString *)modelStr {
    _modelLabel.text = modelStr;
}

-(void)setwhetherSaoFeng:(BOOL)saoFengBool {
        _saofengLabel.hidden = saoFengBool;
}
@end
