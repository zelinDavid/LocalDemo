//
//  DVDeviceListModel.m
//  Eye4
//
//  Created by LiJiaHuan on 17/4/5.
//
//

#import "DVDeviceListModel.h"

@implementation DVDeviceListModel

+(instancetype)initWithDict:(NSDictionary *)dict {
    DVDeviceListModel *model = [[DVDeviceListModel alloc]init ];
    model.imageurl = dict[@"imageurl"];
    model.wifi_type = dict[@"wifi_type"];
    model.dev_num = dict[@"dev_num"];
    model.dev_type = dict[@"dev_type"];
    
    
    return model;
}

@end
