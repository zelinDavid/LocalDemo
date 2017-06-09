

#import "DVPublishButton.h"

@interface DVPublishButton ()<UIActionSheetDelegate>

@end

@implementation DVPublishButton


#pragma mark -
#pragma mark - Private Methods

//上下结构的 button
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 控件大小,间距大小
    CGFloat const imageViewEdge   = self.bounds.size.width * 0.6;
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdge;
    CGFloat const verticalMargin  = verticalMarginT / 2;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdge * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdge  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    //imageView position 位置
    
//    self.imageView.bounds = CGRectMake(0, 0, imageViewEdge, imageViewEdge);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel+2);
    
}

#pragma mark -
#pragma mark - Life Cycle

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}

#pragma mark -
#pragma mark - Public Methods

+(instancetype)publishButton{
    
    DVPublishButton *button = [[DVPublishButton alloc]init];
    

    [button setTitle:@"首页" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"首页"] forState:UIControlStateNormal];
     [button setTitleColor:ColorFromRGB(135, 135, 135, 1) forState:UIControlStateNormal];
    [button setTitleColor:ColorFromRGB(45, 178, 240, 1) forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit];
 
    [button addTarget:button action:@selector(clickPublish:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish:(UIButton *)btn {
    btn.selected = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ssss" object:nil];
}



@end
