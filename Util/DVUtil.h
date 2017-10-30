//
//  DVUtil.h
//  DVBands
//
//  Created by Devond on 15/11/14.
//  Copyright © 2015年 Devond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

FOUNDATION_EXTERN CGFloat FitFloat(CGFloat f);
FOUNDATION_EXTERN CGFloat FitArray(NSArray *plist);
FOUNDATION_EXTERN UIFont *FitFont(CGFloat font);

@interface DVUtil : NSObject



@property (nonatomic, strong) UIAlertAction *okAction;

+ (UIViewController *)getCurrentVC;

+ (UIViewController *)getTopViewController;


+(void)showAlertController:(UIAlertController *)alertController;

+(UIAlertController *)showAlertWithTitle:(NSString *)title;

+(void)showAlertWithTitle:(NSString *)title cancel:(void(^)())cancel ok:(void(^)())ok;

-(UIAlertController *)showAlertControllerTextFieldWith:(NSString *)title message:(NSString *)message placeHolder:(NSString *)placeHolder clickOkActionBlock:(void(^)(NSString *))actionBlock; //textField



+ (NSManagedObjectContext *)coreDataUnsaveContext;


+ (void)clearH5WebCache;

+ (BOOL) validateEmail:(NSString *)email;



#pragma mark - UIImage

/**
 *  图片合成
 *
 *  @param innerImage 里面的图片
 *  @param outerImage 外面的图片
 *
 *  @return 合成图片
 */
+(UIImage *)imageComposeWithInnerImage:(UIImage *)innerImage
                         andOuterImage:(UIImage *)outerImage;

/**
 *  颜色转图片
 */
+(UIImage*)imageWithColor:(UIColor *)color AndSize:(CGSize)size;

+(UIImage *)imageWithText:(NSString *)text;


+(UIImage *)imageStretchwithImage:(UIImage *)image topGap:(CGFloat)top leftGap:(CGFloat)leftGap;

/**
 *  由世界时转化成当前时区的准确时间
 */
+(NSDate *)realDateFromWorldDate:(NSDate *)worldDate;


+(NSString *)commonStrFromhTimeInterval:(long)timeInterval;

+(NSString *)dailyStrFromDate:(NSDate *)date;

+(NSString *)getTimeStringWithTime:(NSInteger)timeInterval;

+ (NSArray *)getTimeArrWithTime:(NSInteger)timeInterval;

/**
 *  时间转换字符
 */
+(NSString *)stringFromDate:(NSDate *)date;

+(NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

+(NSString *)stringFromTimeIntervalSince1970:(NSTimeInterval)secs;
+(NSString *)stringFromTimeIntervalSince1970:(NSTimeInterval)secs withFormat:(NSString *)format;
/// 将NSTimeInterval时间返回成精确的字符串
//+(NSString *)stringFromTimeIntervalSince1970Format:(NSTimeInterval)secs;
/**
 *  Uiview隐藏动画
 *
 *  @param view     传入View
 *  @param hidden   是否隐藏
 *  @param duration 动画时间
 */
+(void)hiddenAnimationWithView:(UIView *)view isHidden:(BOOL)hidden WithDuration:(CGFloat)duration;


+(CGSize)textSizeCalculateFrom:(NSString *)text InWidth:(CGFloat)width FontSize:(UIFont *)fontSize;


+(CGFloat)convertToAngleFromDegree:(CGFloat)degree;


/**
 *  计算缓存
 *
 *  @param folderPath 文件路径
 *
 *  @return 缓存大小
 */
+ (float) folderSizeAtPath:(NSString*) folderPath;



/**
 *  获取app版本信息
 *
 *  @return 版本信息
 */
+ (NSString *)getAppVersion;

/**
 *  异步换取圆角图片
 *
 *  @param image  原图
 *  @param radius 圆角大小 如果需要的是圆形头像 传0即可
 *  @param result 成功回调
 */

+ (void)asyncGetRadiusImage:(UIImage *)image radius:(CGFloat)radius result:(void(^)(UIImage *image))result;



+(CGRect)textSizeWithText:(NSString *)text withFont:(CGFloat)font maxSize:(CGSize)maxSize;
/**
 *  返回tableView 需要的底部提示语
 *
 *  @param title     提示内容
 *  @param tableView tableView
 *
 *  @return <#return value description#>
 */
+(UILabel *)returnTableViewFootViewLabelWithTitle:(NSString *)title superTableView:(UITableView *)tableView;
/**
 *  将网络数据返回的抽奖URL中参数替换返回
 *
 *  @param url       网络数据返回的URL
 *  @param parameter 对应参数表
 *
 */
+(NSString *)getLuckyDrawURLWithString:(NSString *)url parameter:(NSDictionary *)parameter;

/**
 *  获取指定时间所在年月周的起始和结束日期 (如果转换有误 数组 = nil)
 *
 *  @param date 指定时间
 *  @param type 获取类型(年月周) （周:以周日为第一天开始）
 *
 *  @return 元素1:起始时间(NSDate *) 元素2:结束时间(NSDate *) 元素3:开始到结束的间隔(NSInteger) 元素4:周几(NSInteger) “周日 - 周六 = 1 - 7”
 */

#pragma mark - 分割线
+ (UIView *)returnLineViewForSuperView:(UIView *)superView;
/**
 *  获取两个坐标点的距离
 *
 *  @param currentLng 第一个的经度
 *  @param currentLat 第一个的纬度
 *  @param beforeLng  第二个的经度
 *  @param beforeLat  第二个的纬度
 *
 *  @return 距离
 */
+ (NSString *)distanceCurrentLocationlng:(NSInteger)currentLng CurrentLat:(NSInteger)currentLat BeforeLng:(NSInteger)beforeLng   BeforeLat:(NSInteger)beforeLat;

/**
 *  反地理编码
 *
 *  @param currentLng
 *  @param currentLat
 *  @return
 */
+ (NSString *)getReverseGeocodeLocationWithLng:(double)currentLng CurrentLat:(double)currentLat;
/**
 *  元素为字符串的 数组排序去重
 *
 *  @param 是否升序
 *  @return
 */
+ (NSArray *)removeDuplicateWithSequenceArray:(NSArray <NSString *>*)array ascending:(BOOL)ascending;


+ (NSString *)getAppVersionWithAppBuild ;

+(NSURL *)coreDataUnsavedContextStorePath;

+(void)showAlertWithSave:(void(^)())save cancel:(void(^)())cancel;
@end
