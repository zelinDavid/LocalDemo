//
//  DVBaseCollectionView.m
//  Origan
//
//  Created by LiJiaHuan on 17/3/30.
//  Copyright © 2017年 David. All rights reserved.
//

#import "DVDeviceCollectionVC.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "DVDeviceListModel.h"
#import <UIImageView+WebCache.h>
@interface DVDeviceCollectionVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *deviceCollectionView;
@property(nonatomic, strong) NSMutableArray *listArr;

@end

@implementation DVDeviceCollectionVC


-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.deviceCollectionView];
    
    [self getWiFiDeviceListResultBlockSuccess:nil Failure:nil];
    
    _listArr = @[].mutableCopy;
}

#pragma mark -datasource 
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    UIImageView * imageView =  [[UIImageView alloc]initWithFrame:cell.bounds];
    DVDeviceListModel *model = self.listArr[indexPath.row];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:nil];
    cell.backgroundView = imageView ;
    NSLog(@"indexPath__--%@",model.dev_num);
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor whiteColor];
    return headerView;
}


#pragma mark - delegate 
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
       NSLog(@"indexPath---%d",indexPath.row);
}


-(UICollectionView *)deviceCollectionView {
    if (_deviceCollectionView ==nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((UI_WIDTH - 4)/3.00 , FitFloat(125));
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        layout.headerReferenceSize = CGSizeMake(UI_WIDTH, FitFloat(20));
        _deviceCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEIGHT) collectionViewLayout:layout];
        _deviceCollectionView.delegate = self;
        _deviceCollectionView.dataSource = self;
        _deviceCollectionView.backgroundColor =  ColorFromRGB( 219, 224, 225, 1);
        
        [_deviceCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_deviceCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        
    }
    return _deviceCollectionView;
}

- (void)getWiFiDeviceListResultBlockSuccess:(void (^)(NSDictionary *result))success Failure:(void (^)(NSError* error ,NSInteger statusCode ,NSString *resultMessage))failure {
    
    NSString *path = @"http://192.168.253.129/add.HTML";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    __weak typeof (self) weakSelf = self;
    [manager GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        NSLog(@"获取WIFI配置列表请求成功=%@---",arr);
        NSLog(@"json解析失败：%@",err);
        [weakSelf.listArr removeAllObjects];
        for (NSDictionary *dict in arr) {
            DVDeviceListModel *model = [DVDeviceListModel initWithDict:dict];
            [weakSelf.listArr addObject:model];
        }
    
         [weakSelf.listArr sortUsingComparator:^NSComparisonResult(DVDeviceListModel *model1, DVDeviceListModel *model2) {
             if ([model1.dev_num intValue]> [model2.dev_num intValue]) {
                 return  NSOrderedDescending;
             }else  {
                 return NSOrderedAscending;
             }
         }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.deviceCollectionView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        NSInteger status = (long)urlResponse.statusCode;
        NSLog(@"获取WIFI配置列表请求失败返回状态吗 = %ld",(long)status);
        
        NSString  *result =[[ NSString alloc] initWithData:[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"获取WIFI配置列表服务端返回的失败信息=%@---%@",result,error.localizedDescription);
  
    }];
    
}



@end
