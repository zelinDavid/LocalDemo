//
//  DVFactory.h
//  Origan
//
//  Created by LiJiaHuan on 17/3/21.
//  Copyright © 2017年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVFactory : NSObject

#pragma mark - button
+(UIButton *)createBtnWithFrame:(CGRect)rect imageNormalStr:(NSString *)imageNorStr imageHighLightStr:(NSString *)imageHighLightStr title:(NSString *)title font:(CGFloat)fontSize;

+(UIButton *)createBtnWithCenter:(CGPoint)center size:(CGSize)size imageNormalStr:(NSString *)imageNorStr imageHighLightStr:(NSString *)imageHighLightStr title:(NSString *)title font:(CGFloat)fontSize ;

#pragma mark - imageView
+(UIImageView *)createImageWithFrame:(CGRect)frame image:(NSString *)image ;
+(UIImageView *)createImageWithCenter:(CGPoint)center size:(CGSize)size image:(NSString *)image ;

#pragma mark - label
+(UILabel *)createLabelWithFrame:(CGRect)frame  title:(NSString *)title font:(CGFloat)fontSize textAlign:(NSTextAlignment)textAlign ;
+(UILabel *)createLabelWithCenter:(CGPoint)center size:(CGSize)size  title:(NSString *)title font:(CGFloat)fontSize textAlign:(NSTextAlignment)textAlign ;

#pragma mark - view
+(UIView *)createViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color ;

+(UIView *)createViewWithCenter:(CGPoint)center size:(CGSize)size backgroundColor:(UIColor *)color ;

#pragma mark - textField 
+(UITextField *)createTextFieldWithFrame:(CGRect)frame text:(NSString *)text  textAlign:(NSTextAlignment)align textColor:(UIColor *)color font:(CGFloat)font ;


@end
