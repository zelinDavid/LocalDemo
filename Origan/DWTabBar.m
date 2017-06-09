//
//  DWTabBar.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWTabBar.h"


#define ButtonNumber 3


@interface DWTabBar ()


@end

@implementation DWTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        DWPublishButton *button = [DWPublishButton publishButton];
        [self addSubview:button];
        self.publishButton = button;
    
    }
    
    return self;
}



-(void)layoutSubviews{
    
    
    NSLog(@"%s",__func__);
    
    [super layoutSubviews];
    
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    
    CGFloat buttonW = barWidth / ButtonNumber;
    CGFloat buttonH = barHeight - 2;
    CGFloat buttonY = 1;
    
    NSInteger buttonIndex = 0;
    
    self.publishButton.center = CGPointMake(barWidth * 0.5, barHeight * 0.3);
    
//    for (UIView *view in self.subviews) {
//        
//        NSString *viewClass = NSStringFromClass([view class]);
//        if (![viewClass isEqualToString:@"UITabBarButton"]) continue;
//
//        CGFloat buttonX = buttonIndex * buttonW;
//        if (buttonIndex >= 1) {  
//            buttonX += buttonW;
//        }
//        
//        view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        
//        
//        buttonIndex ++;
//        
//    }
 
}





@end
