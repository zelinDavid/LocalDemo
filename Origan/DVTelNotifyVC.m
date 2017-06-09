//
//  DVTelNotifyVC.m
//  Eye4
//
//  Created by David on 17/5/9.
//
//
@interface ContactCell : UITableViewCell
@property(nonatomic, strong)  UILabel    *titleLabel;
@property(nonatomic, strong) UITextField *phoneTextField;

@end

@implementation ContactCell

+(instancetype)customInitWithTableView:(UITableView *)tableView {
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    if (!cell) {
        cell = [[ContactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContactCell"];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [DVFactory createLabelWithFrame:CGRectMake(FitFloat(15), FitFloat(11), FitFloat(160), FitFloat(19)) title:nil font:17 textAlign:NSTextAlignmentLeft];
        _titleLabel.textColor = RGBFromHex(0x555555);
        
        _phoneTextField = [DVFactory createTextFieldWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom +FitFloat(14), FitFloat(200), FitFloat(28)) text:nil textAlign:NSTextAlignmentLeft textColor:RGBFromHex(0x55bdf9) font:17];
        _phoneTextField.placeholder = @"请输入电话";
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_phoneTextField];
    }
    return self;
}


@end


#import "DVTelNotifyVC.h"

@interface DVTelNotifyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *infoArr;
@property(nonatomic, strong) UITableView *myTableView;
@property (nonatomic, assign)BOOL notifyIsOn;
@property(nonatomic, strong) UISwitch *mySwitch;

@end

@implementation DVTelNotifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _notifyIsOn = YES;
    [self initInfoArr];
    _myTableView = [[UITableView alloc]initWithFrame:UI_WINDOW.bounds style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = RGBFromHex(0xefeff4);
    [self.view addSubview:_myTableView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     });
    
}


#pragma mark - dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        if (_notifyIsOn) {
            return 2;
        }
        return 1;
    
//    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else  {
        if (_notifyIsOn) {
            return 3;
        }else  {
            return 0;
        }
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"telNotifyCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"telNotifyCell"];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = FitFont(18);
        cell.detailTextLabel.font = FitFont(17);
        cell.textLabel.textColor = RGBFromHex(0x555555);
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)])  {
            [_myTableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
        if (_mySwitch == nil) {
            _mySwitch = [[UISwitch alloc]init];
            [_mySwitch addTarget:self action:@selector(switchState) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.accessoryView = _mySwitch;
        _mySwitch.on  = _notifyIsOn;
        cell.textLabel.text = @"电话通知 (剩余40条)";
        
        return cell;
    }else {
        if (indexPath.row == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"footCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"footCell"];
            }
            cell.backgroundColor = RGBFromHex(0xefeff4);
            
            NSString *titleStr = @"NotifyTelTip";
            CGFloat width = UI_WIDTH - FitFloat(14)*2;
            CGFloat height  =  [DVUtil textSizeCalculateFrom:titleStr InWidth:width FontSize:FitFont(16)].height;
            
            UILabel *label = [DVFactory createLabelWithFrame:CGRectMake(FitFloat(14), FitFloat(20), width, height) title:titleStr font:16 textAlign:NSTextAlignmentLeft];
            label.textColor = RGBFromHex(0x908f8f);
            label.text = titleStr;
            label.numberOfLines = 0;
            [cell addSubview:label];
            
            return cell;
        }else {
            ContactCell *cell = [ContactCell customInitWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)])  {
                [_myTableView setLayoutMargins:UIEdgeInsetsZero];
            }
            
            NSDictionary *infoDict = _infoArr[indexPath.row];
            cell.titleLabel.text = infoDict[@"title"];
            cell.phoneTextField.text = infoDict[@"subTitle"];
            return  cell;
        }
    }
}


-(void)switchState {
    if (_mySwitch.isOn) {
        _notifyIsOn = YES;
//          [_myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1],[NSIndexPath indexPathForRow:1 inSection:1],[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationTop];
    
        [_myTableView insertSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];

      }else  {
         _notifyIsOn = NO;
//         [_myTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1],[NSIndexPath indexPathForRow:1 inSection:1],[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationTop];
          
          [_myTableView deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return FitFloat(45);
    }else {
        if (indexPath.row == 2) {
            NSString *titleStr =  @"NotifyTelTip";
            CGFloat width = UI_WIDTH - FitFloat(14)*2;
            CGFloat height  =  [DVUtil textSizeCalculateFrom:titleStr InWidth:width FontSize:FitFont(16)].height;
            return height;
        }
        
        return FitFloat(72);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //    if (section != 1 || _notifyIsOn == NO) {
    //        return 0.01;
    //    }
    //
    //     NSString *titleStr =  DVLocalized(@"NotifyTelTip");
    //    CGFloat width = UI_WIDTH - FitFloat(14)*2;
    //    CGFloat height  =  [DVUtil textSizeCalculateFrom:titleStr InWidth:width FontSize:FitFont(16)].height;
    //
    //
    //    return height + FitFloat(20)*2.5;
    
    return 0.01;
}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if (section != 1 || _notifyIsOn == NO) {
//        return nil;
//    }
//    NSString *titleStr =  DVLocalized(@"NotifyTelTip");
//    CGFloat width = UI_WIDTH - FitFloat(14)*2;
//    CGFloat height  =  [DVUtil textSizeCalculateFrom:titleStr InWidth:width FontSize:FitFont(16)].height;
//
//    UIView *backView = [DVFactory createViewWithFrame:CGRectMake(0, 0, UI_WIDTH,height+ FitFloat(20)*2.5) backgroundColor:RGBFromHex(0xefeff4)];
//
//    UILabel *label = [DVFactory createLabelWithFrame:CGRectMake(FitFloat(14), FitFloat(20), width, height) title:titleStr font:16 textAlign:NSTextAlignmentLeft];
//    label.textColor = RGBFromHex(0x908f8f);
//    label.text = titleStr;
//    label.numberOfLines = 0;
//    [backView addSubview:label];
//
//    return backView;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FitFloat(10);
}


#pragma mark - delegaete
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        ContactCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.phoneTextField becomeFirstResponder];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}



-(void)initInfoArr {
    
    _infoArr =@[
                @{
                    @"title" : @"第一联系人:",
                    @"subTitle" : @"..........",
                    },
                @{
                    @"title" : @"第二联系人:",
                    @"subTitle" : @"....3.....",
                    }
                ].mutableCopy;
    
}

@end

