//
//  LoadingView.m
//  Origan
//
//  Created by David on 17/10/30.
//  Copyright © 2017年 David. All rights reserved.
//

#import "LoadingView.h"
#define Width self.bounds.size.width
#define Height self.bounds.size.height
#define LineWidth 2
#define Radius Width/2.0 - LineWidth
#define DefaultColor     RGBFromHex(0xe5e6e6)
#define LoadedColor     RGBFromHex(0x18baf2)


@interface LoadingView()<CAAnimationDelegate>
@property(nonatomic, strong) UIBezierPath *path;
@property(nonatomic, strong) CAShapeLayer *shapLayer;


@end

@implementation LoadingView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _path = [[UIBezierPath alloc]init];
        
        CAShapeLayer *loadingLayer = [CAShapeLayer layer];
        loadingLayer.frame = CGRectMake(0, 0, Width, Height);
        loadingLayer.strokeColor = LoadedColor.CGColor;
        loadingLayer.lineWidth = LineWidth;
        loadingLayer.fillColor = [UIColor whiteColor].CGColor;
        _shapLayer = loadingLayer;
 
        [self.layer addSublayer:loadingLayer];
    }
    return self;
}

-(void)updateLoadingViewWithProgroess:(CGFloat)progress {
    [_path removeAllPoints];
    [UIView animateWithDuration:0.2 animations:^{
        [_path addArcWithCenter:CGPointMake(Width/2.0, Height/2.0) radius:Radius startAngle:- M_PI_4 endAngle:M_PI*2*progress- M_PI_4  clockwise:YES];
        _shapLayer.path  = _path.CGPath;
    }];
 }


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, DefaultColor.CGColor);
    CGContextSetLineWidth(context, LineWidth);
    CGContextAddArc(context, Width/2.0, Width/2.0, Radius, 0, M_PI *2, YES);
    CGContextStrokePath(context);
    
    
}

@end
