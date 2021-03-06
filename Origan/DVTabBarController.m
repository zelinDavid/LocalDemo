 

#import "DVTabBarController.h"
#import "DVNavigationController.h"
#import "DWHomeViewController.h"
#import "DWMessageViewController.h"
#import "DWMineViewController.h"
#import "DWSameFityViewController.h"

#import "DVTabBar.h"

#define DVColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0] //<<< 用10进制表示颜色，例如（255,255,255）黑色
#define DVRandomColor DVColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface DVTabBarController()<UITabBarDelegate>


@end
@implementation DVTabBarController {
    UIButton *_midBtn;
}

#pragma mark -
#pragma mark - Life Cycle

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.delegate = self;

    // 设置 TabBarItemTestAttributes 的颜色。
    [self setUpTabBarItemTextAttributes];
    
    // 设置子控制器
    [self setUpChildViewController];
    
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:RGBAFromHex(0xf2f2f2, 0.97)]];
 
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
 

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectMideBtn) name:@"ssss" object:nil];
    
    self.selectedIndex = 1;
    _midBtn.selected = YES;
}


-(void)selectMideBtn {
    self.selectedIndex = 1;

}



- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSUInteger index = tabBarController.selectedIndex;
    if (index != 1) {
        _midBtn.selected = NO;
    }else {
        _midBtn.selected = YES;
    }
}

//-(BOOL)shouldAutorotate {
//    BOOL sss = [NSStringFromClass([self.presentedViewController class]) isEqualToString:@"DWMineViewController"];
//    if (sss) {
//        return YES;
//    }
//    return NO;
//}
//
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    NSString *tem = NSStringFromClass([self.presentedViewController class]);
//    BOOL sss = [tem isEqualToString:@"DWMineViewController"];
//    if (sss) {
//        return UIInterfaceOrientationMaskAll;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//    
//}

//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    if (_hhh) {
//        return UIInterfaceOrientationMaskAll;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//-(BOOL)shouldAutorotate {
//    if (_hhh) {
//        return YES;
//    }
//    return NO;
//}


#pragma mark -
#pragma mark - Private Methods

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar{
    DVTabBar *tabbar = [[DVTabBar alloc] init];
    _midBtn = tabbar.publishButton;
    [self setValue:tabbar forKey:@"tabBar"];

}



/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes{
    
  
 }







-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

-(BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];

    
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];

}

 
/**
 *  添加子控制器，我这里值添加了4个，没有占位自控制器
 */
- (void)setUpChildViewController{
    
    [self addOneChildViewController:[[DVNavigationController alloc]initWithRootViewController:[[DWHomeViewController alloc]init]]
                          WithTitle:@"消息"
                          imageName:@"消息中心01"
                  selectedImageName:@"消息中心03"];
    
    
    DVNavigationController *nav =    [[DVNavigationController alloc]initWithRootViewController:[[DWMessageViewController alloc]init]];
    [self addChildViewController:nav];
 
//    
//    
    [self addOneChildViewController:[[DVNavigationController alloc]initWithRootViewController:[[DWMineViewController alloc]init]]
                          WithTitle:@"我的"
                          imageName:@"我的01"
                  selectedImageName:@"我的02"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */

- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
     viewController.tabBarItem.title         = title;
    viewController.tabBarItem.image         = [UIImage imageNamed:imageName];
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image;
    [self addChildViewController:viewController];
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = ColorFromRGB(135, 135, 135, 1);
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = ColorFromRGB(45, 178, 240, 1);
    
    // 设置文字属性
      [viewController.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [viewController.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    
    
}


//这个方法可以抽取到 UIImage 的分类中
- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




@end
