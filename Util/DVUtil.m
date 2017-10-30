//
//  DVUtil.m
//  DVBands
//
//  Created by Devond on 15/11/14.
//  Copyright © 2015年 Devond. All rights reserved.
//

#import "DVUtil.h"


@implementation DVUtil

inline CGFloat FitFloat(CGFloat f){
    if (IPHONE5) {
        f = f /375 * 320;
    }
    if (iPhone6Plus) {
        f = f /375 * 414;
    }///
    return f;
}

inline CGFloat FitArray(NSArray *plist)
{
    CGFloat f = 0.0f;
    
    if (plist.count) {
        switch (plist.count) {
            case 1:
            {
                f = [[plist firstObject] floatValue];
            }
                break;
            case 2:
            {
                f = [[plist firstObject] floatValue];
                f = iPhone6Plus? [plist[1] floatValue]:f;
            }
                break;
            case 3:
            {
                f = iPhone6 ? [plist[1] floatValue]:[plist[0] floatValue];
                f = iPhone6Plus? [plist[2] floatValue]:f;
            }
                break;
            default:
                break;
        }
    }
    
    return f;
}

inline UIFont *FitFont(CGFloat font)
{
    CGFloat f = font - 1;
    
    if (iPhone6) {
        f = font;
    }
    
    if (iPhone6Plus) {
        f = font + 1;
    }
    
    return [UIFont systemFontOfSize:f];
}

 
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}


+(UIViewController *)getTopViewController{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}


+(void)showAlertController:(UIAlertController *)alertController{
    [[self getTopViewController] presentViewController:alertController animated:NO completion:nil];
}


+(UIAlertController *)showAlertWithTitle:(NSString *)title{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:sureAction];
    [self showAlertController:alertController];
    return alertController;
}

+(void)showAlertWithTitle:(NSString *)title cancel:(void(^)())cancel ok:(void(^)())ok{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    
//    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:DVLocalizedString(@"Yes") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        if (ok) {
//            ok();
//        }
//    }];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:DVLocalizedString(@"CancelKey") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        if (cancel) {
//            cancel();
//        }
//    }];
    
//
//    [alertController addAction:sureAction];
//    [alertController addAction:cancelAction];
//    
//    [self showAlertController:alertController];
}


-(UIAlertController *)showAlertControllerTextFieldWith:(NSString *)title message:(NSString *)message placeHolder:(NSString *)placeHolder clickOkActionBlock:(void(^)(NSString *))actionBlock {
    
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alerController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeHolder;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];

    }];
    
     [alerController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
     UIAlertAction *  okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *categoryField = alerController.textFields.firstObject;
         
         actionBlock(categoryField.text);
    }];
    self.okAction = okAction;
    self.okAction.enabled = NO;
    [alerController addAction: okAction];
    
    return alerController;
}

- (void)textFieldDidChange:(NSNotification *)notify {
    UITextField *textField = notify.object;
    if (textField.text) {
        self.okAction.enabled = YES;
    }else {
        self.okAction.enabled = NO;
    }
}

+(void)clearH5WebCache{
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                               NSUserDomainMask, YES)[0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                            objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString
                                      stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
}



+(UIImage *)imageResizeFromImage:(UIImage *)image
                          toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+(UIImage *)imageScaleFromImage:(UIImage *)image
                        toScale:(CGFloat)scale
{
    CGSize NewSize = CGSizeMake(image.size.width *scale, image.size.height *scale);
    UIGraphicsBeginImageContextWithOptions(NewSize, NO, 2.0f);
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+(UIImage *)imageComposeWithInnerImage:(UIImage *)innerImage andOuterImage:(UIImage *)outerImage{
    UIGraphicsBeginImageContextWithOptions(outerImage.size, NO, 2.0f);
    [outerImage drawInRect:CGRectMake(0, 0, outerImage.size.width, outerImage.size.height)];
    [innerImage drawInRect:CGRectMake(FitArray(@[@11,@11]), FitArray(@[@11,@11]), innerImage.size.width, innerImage.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+(UIImage*)imageWithColor:(UIColor *)color AndSize:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage *)imageWithText:(NSString *)text
{
    NSDictionary* attrs =@{NSForegroundColorAttributeName:[UIColor redColor],
                           NSFontAttributeName:[UIFont systemFontOfSize:11],
                           };
    CGSize size  = [text sizeWithAttributes:attrs];
    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0f);
    [text drawAtPoint:CGPointMake(0, 0) withAttributes:attrs];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



+(UIImage *)imageStretchwithImage:(UIImage *)image topGap:(CGFloat)topGap leftGap:(CGFloat)leftGap
{
    int top = image.size.height *topGap; // 顶端盖高度
    int bottom = top -1 ; // 底端盖高度
    int left = image.size.width*leftGap; // 左端盖宽度
    int right = image.size.width*leftGap-1; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *resultImage = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return resultImage;
}

#pragma mark - 邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - Date

+ (NSString *)commonStrFromhTimeInterval:(long)timeInterval{
    NSString *timeStr;
    long now = [[NSDate date] timeIntervalSince1970];
    long difference = now - timeInterval;
    if (difference < 10) {
        timeStr = NSLocalizedString(@"Now", nil);
    }else if (difference < 60 && difference> 10) {
        timeStr = [NSString stringWithFormat:NSLocalizedString(@"Date_Second", nil),difference];
    }else if (difference < 3600 && difference >=60){
        NSInteger min = (NSInteger) difference / 60;
        timeStr = [NSString stringWithFormat:NSLocalizedString(@"Date_Minutes", nil),(min+1)];
    }else if (difference < 24 * 3600 && difference >= 3600){
        NSInteger hour  = (NSInteger) difference / 3600;
        timeStr = [NSString stringWithFormat:NSLocalizedString(@"Date_Hours", nil),(hour+1)];
    }else{
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        timeStr = [self stringFromDate:date];
    }
    return timeStr;
}


+(NSString *)dailyStrFromDate:(NSDate *)date{
    NSString *timeStr;
    long difference = -[date timeIntervalSinceNow];
    if (difference < 60) {
        timeStr = [NSString stringWithFormat:NSLocalizedString(@"Date_Second", nil),difference];
    }else if (difference < 3600 && difference >=60){
        NSInteger min = (NSInteger) difference / 60;
        timeStr = [NSString stringWithFormat:NSLocalizedString(@"Date_Minutes", nil),(min+1)];
    }else if (difference < 24 * 3600 && difference >= 3600){
        NSInteger hour  = (NSInteger) difference / 3600;
        timeStr = [NSString stringWithFormat:NSLocalizedString(@"Date_Hours", nil),(hour+1)];
    }else{
        timeStr = [self stringFromDate:date];
    }
    return timeStr;
}


+(NSString *)getTimeStringWithTime:(NSInteger)timeInterval{
    NSString *timeStr;
    long difference = timeInterval;
    if (difference < 60) {
        timeStr = [NSString stringWithFormat:@"%ldSec",difference];
    }else if (difference < 3600 && difference >=60){
        CGFloat min =  difference / 60.0;
        timeStr = [NSString stringWithFormat:@"%.1fMin",(min)];
    }else if (difference < 24 * 3600 && difference >= 3600){
        CGFloat hour  =  difference / 3600.0;
        timeStr = [NSString stringWithFormat:@"%.1fH",(hour)];
    }else if (difference >= 24 * 3600){
        CGFloat hour  =  difference / 3600/24.0;
        timeStr = [NSString stringWithFormat:@"%.1fday",(hour)];
    }

    return timeStr;
}


+(NSDate *)realDateFromWorldDate:(NSDate *)worldDate
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:worldDate];
    NSDate *realDate = [worldDate  dateByAddingTimeInterval:interval];
    return realDate;
}

+(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *timeStr = [dateFormatter stringFromDate:date];
    return timeStr;
}
//#warning 不要更改 重要
+(NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format ? format :@"MM/dd HH:mm:ss"];
    NSDate *time = [dateFormatter dateFromString:string];
    return time;
}

+(NSString *)stringFromTimeIntervalSince1970:(NSTimeInterval)secs
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:secs];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *timeStr = [dateFormatter stringFromDate:date];
    return timeStr;
}

+(NSString *)stringFromTimeIntervalSince1970:(NSTimeInterval)secs withFormat:(NSString *)format
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:secs];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format ? format :@"MM/dd HH:mm:ss"];
    NSString *timeStr = [dateFormatter stringFromDate:date];
    return timeStr;
}
+(NSString *)stringFromTimeIntervalSince1970Format:(NSTimeInterval)secs
{
    /*
     - 微博时间字符串处理
     - 业务需求逻辑
     - 如果是今年
     - 如果是今天
     - 如果 < 60 s  显示格式: 刚刚
     - 如果 >=60 && < 60 * 60  显示格式: xx分钟前
     - 其他 显示格式: xx小时前
     - 如果是昨天
     -例如 2016-04-22 19:19:19  显示格式: 昨天 19:19
     - 其他
     -例如 2016-04-04 20:20:20  显示格式: 04月04日 20:20
     - 如果不是今年
     -例如: 2015-01-01 18:18:18 显示格式: 2015年01月01日 18:18
     */
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    if ([self timeIsThisYear:date]) {
        if ([self timeIsThisDay:date]) {
            if (secs <= 60) {
                return @"刚刚";
            }else if (secs > 60 && secs < 60*60){
                formatter.dateFormat = @"mm";
                return [NSString stringWithFormat:@"%@分钟前",[formatter stringFromDate:date]];
            }else{
                formatter.dateFormat = @"HH";
                return [NSString stringWithFormat:@"%@小时前",[formatter stringFromDate:date]];
            }
        }else{
            
        }
        return nil;
    }else{
        formatter.dateFormat =  @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:date];
    }
    
}
+ (BOOL)timeIsThisYear:(NSDate *)secs{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    formatter.dateFormat =  @"yyyy";
    
    NSString *year = [formatter stringFromDate:secs];
    NSString *thisYear = [formatter stringFromDate:[NSDate date]];
    
    if ([year isEqualToString:thisYear]) {
        return YES;
    }else{
        return NO;
    }
    
}
+ (BOOL)timeIsThisDay:(NSDate *)secs{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    formatter.dateFormat =  @"dd";
    
    NSString *day = [formatter stringFromDate:secs];
    NSString *thisDay = [formatter stringFromDate:[NSDate date]];
    
    if ([day isEqualToString:thisDay]) {
        return YES;
    }else{
        return NO;
    }
    
}


+(void)hiddenAnimationWithView:(UIView *)view isHidden:(BOOL)hidden WithDuration:(CGFloat)duration{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = duration;
    [view.layer addAnimation:animation forKey:nil];
    view.hidden = hidden;
}

+(CGSize)textSizeCalculateFrom:(NSString *)text InWidth:(CGFloat)width FontSize:(UIFont *)fontSize
{
    NSDictionary *attrs = @{NSFontAttributeName :fontSize};
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return textSize;
}

+(CGFloat)convertToAngleFromDegree:(CGFloat)degree{
    CGFloat temp = M_PI/180;
    return degree * temp;
}




+ (float) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}



+ (NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAppVersionWithAppBuild  {
    NSString *app_build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *appversion =  [NSString stringWithFormat:@"V%@(%@)",version,app_build];
    return appversion;
}
+ (void)asyncGetRadiusImage:(UIImage *)image radius:(CGFloat)radius result:(void (^)(UIImage *))result{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{ 
    
        //2、开启和图片大小的上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
        
        //3、获取当前上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        //4、绘制裁剪路径
        //圆心
        CGPoint center = CGPointMake(image.size.width/2, image.size.height/2);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius ? radius : MIN(image.size.width, image.size.height)/2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        CGContextAddPath(ctx, path.CGPath);
        
        //5、裁剪上下文
        CGContextClip(ctx);
        
        //6、绘制图片
        [image drawAtPoint:CGPointZero];
        
        //7、获取当前上下文中的图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//        dispatch_async(dispatch_get_main_queue(), ^{
            if (result != nil) {
                result(newImage);
            }
//        });
//    });
     UIGraphicsEndImageContext();

}

+(CGRect)textSizeWithText:(NSString *)text withFont:(CGFloat)font maxSize:(CGSize)maxSize{
    CGRect textRect = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: FitFont(font) } context:nil];
    return textRect;
}

+(UILabel *)returnTableViewFootViewLabelWithTitle:(NSString *)title superTableView:(UITableView *)tableView{
    UILabel *footViewL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, FitFloat(30))];
    footViewL.text = title;
    footViewL.textAlignment = NSTextAlignmentCenter;
    footViewL.textColor = RGBFromHex(0x666666);
    footViewL.font = FitFont(12);
    tableView.tableFooterView = footViewL;
//    tableView.tableFooterView.hidden = YES;    
    return footViewL;
}


#pragma mark - 分割线
+ (UIView *)returnLineViewForSuperView:(UIView *)superView{
    UIView *line = [[UIView alloc]init];
    [superView addSubview:line];
    line.backgroundColor = RGBFromHex(0xd8d8d8);
    return line;
}

+ (NSString *)distanceCurrentLocationlng:(NSInteger)currentLng CurrentLat:(NSInteger)currentLat BeforeLng:(NSInteger)beforeLng   BeforeLat:(NSInteger)beforeLat{
    //第一个坐标
    CLLocation *current=[[CLLocation alloc] initWithLatitude:currentLat longitude:currentLng];
    //第二个坐标
    CLLocation *before=[[CLLocation alloc] initWithLatitude:beforeLat longitude:beforeLng];
    // 计算距离
    CLLocationDistance meters=[current distanceFromLocation:before];
    NSString *distanceStr;
    if (meters <1000) {
        distanceStr = [NSString stringWithFormat:@"%ldm",(long)meters];
    }else if(meters > 1000){
        distanceStr = [NSString stringWithFormat:@"%.1fkm",meters/1000.0];
    }
    
    return distanceStr;
}

+ (NSString *)getReverseGeocodeLocationWithLng:(double)currentLng CurrentLat:(double)currentLat{
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    CLLocation *location=[[CLLocation alloc]initWithLatitude:currentLat longitude:currentLng];

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *firstPlacemark=[placemarks firstObject];
        NSLog(@"---- %@",firstPlacemark.name);
        
        NSLog(@"%@",error);
  
    }];
    return nil;
}





+ (NSArray *)removeDuplicateWithSequenceArray:(NSArray <NSString *>*)array ascending:(BOOL)ascending{
    NSSet *set = [NSSet setWithArray:array];
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:ascending]];
    NSArray *resultsArray = [set sortedArrayUsingDescriptors:sortDesc];
    return resultsArray;
}




+(void)showAlertWithSave:(void(^)())save cancel:(void(^)())cancel{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"Edit_alart_title", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Save", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        save();
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"CancelKey", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        cancel();
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self showAlertController:alertController];
}

@end
