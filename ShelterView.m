//
//  ShelterView.m
//  Eye4
//
//  Created by David on 17/7/20.
//
//

#import "ShelterView.h"

@implementation ShelterView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.5;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeSelf )];
        [blackView addGestureRecognizer:tapGR];
        [self addSubview:blackView];
        
        
        
    }
    return self;
}

-(void)removeSelf {
    if (self.superview) {
        [self removeFromSuperview];
    }
}


@end
