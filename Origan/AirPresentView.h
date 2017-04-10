//
//  AirPresentView.h
//  Origan
//
//  Created by LiJiaHuan on 17/3/21.
//  Copyright © 2017年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirPresentView : UIView

-(void)changeTempareture:(int) tempareture;
-(void)changeModel:(NSString *)modelStr;
-(void)setwhetherSaoFeng:(BOOL)saoFengBool;


@end
