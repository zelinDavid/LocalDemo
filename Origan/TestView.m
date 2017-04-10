//
//  TestView.m
//  Origan
//
//  Created by LiJiaHuan on 17/4/5.
//  Copyright © 2017年 David. All rights reserved.
//

#import "TestView.h"

@implementation TestView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /**
     *  Quartz2D 渐变
     Quartz提供了两个不透明数据odgago创建渐变: CGShadingRef 和 CGGradientRef
     可以使用任何一种来创建轴向(axial)或径向(radial)渐变.一个渐变是从一个颜色到另一个颜色的填充
     一个轴向渐变(也成为线性渐变)
     */
    
    CGContextBeginPath(context);
    
    CGContextSetLineWidth(context, 1.0);//线宽
    
    
      CGFloat lengths[] = {4,2};//先画4个点，后画2个点 {0,0}就是实线啦。
    
    CGContextSetLineDash(context, 0, lengths, 2);////注意2(count)的值等于lengths数组的长度
    
    CGContextMoveToPoint(context, 10,100);
    
    CGContextAddLineToPoint(context, 20,200);
    
    CGContextStrokePath(context);
    
    CGContextClip(context);

    
     [self myGradientWithstartPoint:CGPointMake(0, 0) endPoint:CGPointMake(UI_WIDTH, 0) context:context];
    
    
    
    //  gradientColor(context, self.bounds);
//    myPaintRadialShading(context, self.bounds);

}

#pragma mark ----- CGGradientCreateWithColorComponents 创建渐变图层

- (void)myGradientWithstartPoint:(CGPoint )startPoint endPoint:(CGPoint )endPoint context:(CGContextRef)context
{
    
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = startPoint.x;
    myStartPoint.y = startPoint.y;
    myEndPoint.x = endPoint.x;
    myEndPoint.y = endPoint.y;
    
    CGGradientRef myGradient;
    CGColorSpaceRef mycolorSpace;
    size_t num_locations = 4;
    CGFloat locations[4] = {0.0, 0.33, 0.89, 1.0}; // 设置4个点
    CGFloat components[16] = {0.1, 1.0, 0.2, 1.0, // RGB alpha
        1.0, 0.1, 0.1, 1.0,
        0.1, 0.1, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0
        
    };
    mycolorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    /**
     *  CGGradient
     *
     *  @param mycolorSpace  设置颜色空间 色调
     *  @param components    设置关键点颜色的数组
     *  @param locations     设置关键点的位置和个数
     *  @param num_locations 设置点的个数
     *
     *  @return CGGradient
     */
    myGradient = CGGradientCreateWithColorComponents(mycolorSpace, components, locations, num_locations);
    
    
    //    CGContextDrawRadialGradient(context, myGradient, myStartPoint, 300, myEndPoint, 300, kCGGradientDrawsBeforeStartLocation);
    
    CGContextDrawLinearGradient(context, myGradient, myStartPoint, myEndPoint, kCGGradientDrawsBeforeStartLocation);
    
    // 释放颜色空间对象
    CGColorSpaceRelease(mycolorSpace);
    
    
}


//- (void) drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context{
//    
//    //put this blok into the canDraw method cause problem
//    CGRect pointsRect = CGPathGetBoundingBox(self.path);
//    CGRect mapRectCG = [self rectForMapRect:mapRect];
//    if (!CGRectIntersectsRect(pointsRect, mapRectCG))return;
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    UIColor* pcolor,*ccolor;
//    for (int i=0;i< polyline.pointCount;i++){
//        CGPoint point = [self pointForMapPoint:polyline.points[i]];
//        CGMutablePathRef path = CGPathCreateMutable();
//        
//        if(hues[i]==0.){
//            //虚线
//            if(i==0){
//                CGPathMoveToPoint(path, nil, point.x, point.y);
//            }else{
//                //颜色
//                CGContextSetRGBStrokeColor(context, 153.0 / 255.0, 153.0 / 255.0, 153.0 / 255.0, 1.0);
//                //线宽
//                CGFloat lineWidth = CGContextConvertSizeToUserSpace(context, (CGSize){self.lineWidth,self.lineWidth}).width;
//                CGContextSetLineWidth(context, lineWidth);
//                
//                CGFloat lengths[] = {lineWidth*2,lineWidth*2};//设置虚线
//                CGContextSetLineDash(context, lineWidth, lengths, 2);//设置虚线
//                
//                CGPoint prevPoint = [self pointForMapPoint:polyline.points[i-1]];
//                CGPathMoveToPoint(path, nil, prevPoint.x, prevPoint.y);
//                CGPathAddLineToPoint(path, nil, point.x, point.y);
//                CGContextAddPath(context, path);
//                CGContextStrokePath(context);
//            }
//        }else{
//            //跑步渐变
//            ccolor = [UIColor colorWithHue:hues[i] saturation:1.0f brightness:1.0f alpha:1.0f];
//            if (i==0){
//                CGPathMoveToPoint(path, nil, point.x, point.y);
//            } else {
//                CGPoint prevPoint = [self pointForMapPoint:polyline.points[i-1]];
//                CGPathMoveToPoint(path, nil, prevPoint.x, prevPoint.y);
//                CGPathAddLineToPoint(path, nil, point.x, point.y);
//                
//                CGFloat pc_r,pc_g,pc_b,pc_a,
//                cc_r,cc_g,cc_b,cc_a;
//                
//                [pcolor getRed:&pc_r green:&pc_g blue:&pc_b alpha:&pc_a];
//                [ccolor getRed:&cc_r green:&cc_g blue:&cc_b alpha:&cc_a];
//                
//                CGFloat gradientColors[8] = {pc_r,pc_g,pc_b,pc_a,
//                    cc_r,cc_g,cc_b,cc_a};
//                
//                CGFloat gradientLocation[2] = {0,1};
//                CGContextSaveGState(context);
//                CGFloat lineWidth = CGContextConvertSizeToUserSpace(context, (CGSize){self.lineWidth,self.lineWidth}).width;
//                CGPathRef pathToFill = CGPathCreateCopyByStrokingPath(path, NULL, lineWidth, self.lineCap, self.lineJoin, self.miterLimit);
//                CGContextAddPath(context, pathToFill);
//                CGContextClip(context);
//                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//                CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradientColors, gradientLocation, 2);
//                CGColorSpaceRelease(colorSpace);
//                CGPoint gradientStart = prevPoint;
//                CGPoint gradientEnd = point;
//                CGContextDrawLinearGradient(context, gradient, gradientStart, gradientEnd, kCGGradientDrawsAfterEndLocation);
//                CGGradientRelease(gradient);
//                CGContextRestoreGState(context);
//                pcolor = [UIColor colorWithCGColor:ccolor.CGColor];
//            }
//        }
//    }
//}


@end
