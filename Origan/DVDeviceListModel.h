//
//  DVDeviceListModel.h
//  Eye4
//
//  Created by LiJiaHuan on 17/4/5.
//
//

#import <Foundation/Foundation.h>

@interface DVDeviceListModel : NSObject
@property(nonatomic, copy) NSString *imageurl;
@property(nonatomic, copy) NSString *wifi_type;
@property(nonatomic, copy) NSString *dev_num;
@property(nonatomic, copy) NSString *dev_type;



+(instancetype)initWithDict:(NSDictionary *)dict;

@end
