//
//  APICommon.m
//  P2PCamera
//
//  Created by Tsang on 12-12-11.
//
//

#import "APICommon.h"
//#import "libH264Dec.h"
//#import "CustomAVRecorder.h"
@implementation APICommon

//从返回数据中提取所需字段方法
+ (NSString *)stringAnalysisWithFormatStr:(NSString *)FormatStr AndRetString:(NSString *)retString {
    NSRange range = [retString rangeOfString:FormatStr];
    unsigned long location = range.location + range.length;
    NSUInteger len = 0;
    while (location < retString.length) {
        NSString *subStr = [retString substringWithRange:NSMakeRange(location, 1)];
        if ([subStr isEqualToString:@";"]) {
            break;
        } else {
            len ++;
            location ++;
        }
    }
    if (len != 0) {
        NSString *result = [retString substringWithRange:NSMakeRange(range.location + range.length, len)];
        
        NSMutableString *mutKeyStr = [NSMutableString stringWithString:result];
        NSString *str3 = [mutKeyStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        return str3;
        
    }
    return nil;
}


+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    NSData *dataImg = UIImageJPEGRepresentation(newImage, 1);
    UIImage *imgOK = [UIImage imageWithData:dataImg];
    
    // Return the new image.
    return imgOK;
}

+ (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

+ (UIImage*) GetImageByNameFromImage: (NSString*)did filename:(NSString*)filename
{
    if (did == nil || filename == nil) {
        return nil;
    }
     
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    
    NSString *strPath = [documentsDirectory stringByAppendingPathComponent:did];
    strPath = [strPath stringByAppendingPathComponent:filename];
    //NSLog(@"strPath: %@", strPath);
    
    UIImage *image = [UIImage imageWithContentsOfFile:strPath];
    
    return [self imageWithImage:image scaledToSize:CGSizeMake(75, 75)];
    
}

+ (UIImage*) GetPictureByNameFromImage: (NSString*)did filename:(NSString*)filename
{
    if (did == nil || filename == nil) {
        return nil;
    }
    
    //参数NSDocumentDirectory要获取那种路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    
    NSString *strPath = [documentsDirectory stringByAppendingPathComponent:did];
    strPath = [strPath stringByAppendingPathComponent:filename];
    //NSLog(@"strPath: %@", strPath);
    
    return [UIImage imageWithContentsOfFile:strPath];
    
}




#define RGB565_MASK_RED        0xF800
#define RGB565_MASK_GREEN                         0x07E0
#define RGB565_MASK_BLUE                         0x001F

void rgb565_2_rgb24(unsigned char *rgb24, unsigned short rgb565)
{
    //extract RGB
    rgb24[0] = (rgb565 & RGB565_MASK_RED) >> 11;
    rgb24[1] = (rgb565 & RGB565_MASK_GREEN) >> 5;
    rgb24[2] = (rgb565 & RGB565_MASK_BLUE);
    
    //plify the image
    rgb24[0] <<= 3;
    rgb24[1] <<= 2;
    rgb24[2] <<= 3;
}

void RGB565toRGB888(unsigned char *rgb565, unsigned char* rgb888, int width, int height)
{
    int i;
    int j;
    for (i = 0; i < height; i++) {
        unsigned char *pSrc = rgb565 + (width * 2) * i;
        unsigned char *pDes = rgb888 + (width * 3) * i;
        for (j = 0; j < width ; j++) {
            rgb565_2_rgb24(pDes + j * 3, *((unsigned short*)(pSrc + j * 2)));
        }
    }
    
}

+ (UIImage*) RGB888toImage: (Byte*)rgb888 width:(int)width height:(int)height
{
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    
    CFDataRef dataRef = CFDataCreate(kCFAllocatorDefault, rgb888, width*height*3);
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(dataRef);
    //CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, rgb888, width*height*3, NULL);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef cgImage = CGImageCreate(width,
                                       height,
                                       8,
                                       24,
                                       width*3,
                                       colorSpace,
                                       bitmapInfo,
                                       provider,
                                       NULL,
                                       NO,
                                       kCGRenderingIntentDefault);
    CGColorSpaceRelease(colorSpace);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    //UIImage *image = [[[UIImage alloc] initWithCGImage:cgImage] autorelease];
    
    CGImageRelease(cgImage);
    CGDataProviderRelease(provider);

    //NSLog(@"width: %f, height: %f", image.size.width, image.size.height);
    return image;
}



  + (NSArray *)stringJsonToArray:(NSString *)retString {
    NSString *json = retString;
    if (json.length <= 0) {
        return nil;
    }
    NSString *jsonStr = [[json stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""];
    if (jsonStr.length <= 0) {
        return nil;
    }
    NSArray *jsonArray = [jsonStr componentsSeparatedByString:@"},{"];
    NSMutableArray *jsonMul = [NSMutableArray array];
    for (int i = 0; i < [jsonArray count]; i ++) {
        NSString *subStr = [[jsonArray[i] stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
        NSArray *subArray = [subStr componentsSeparatedByString:@","];
        NSString *cmd = [[subArray[0] componentsSeparatedByString:@":"][1] stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *mac = [cmd substringWithRange:NSMakeRange(0, cmd.length - 4)];
        NSString *version = [cmd substringWithRange:NSMakeRange(cmd.length - 4, 4)];
        NSString *name = @"";
        if ([subArray count] >= 2) {
            name = [subArray[1] componentsSeparatedByString:@":"][1];
        }
        if (mac && version && name)
        {
            [jsonMul addObject:@{@"mac":mac,@"version":version,@"name":name}];
        }
    }
    return jsonMul;
}

                          
@end
