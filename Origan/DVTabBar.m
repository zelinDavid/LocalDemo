 

#import "DVTabBar.h"




@interface DVTabBar ()


@end

@implementation DVTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        DVPublishButton *button = [DVPublishButton publishButton];
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
    
    CGFloat buttonW = barWidth / 3;
    CGFloat buttonH = barHeight - 2;
    CGFloat buttonY = 1;
    
    NSInteger buttonIndex = 0;
    
    self.publishButton.center = CGPointMake(barWidth * 0.5, barHeight * 0.3);
    
 
 
}





@end
