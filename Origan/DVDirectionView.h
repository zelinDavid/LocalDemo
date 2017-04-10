//
//  DVDirectionView.h
//  Origan
//
//  Created by LiJiaHuan on 17/3/20.
//  Copyright © 2017年 David. All rights reserved.
//

#import "OBShapedButton.h"

@protocol DVDirectionViewDelegate <NSObject>
@optional
-(void)upBtnClicked;
-(void)downBtnClicked;
-(void)leftBtnClicked;
-(void)rightBtnClicked;
-(void)okBtnClicked;

@end

@interface DVDirectionView : OBShapedButton
@property (nonatomic,weak) id<DVDirectionViewDelegate> delegate;

-(instancetype)customInit;

@end
