//
//  DVEmailNotifyVC.m
//  Eye4
//
//  Created by David on 17/5/9.
//
//

#import "DVEmailNotifyVC.h"


@class EmailCell;
@interface EmailCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic, strong)  UILabel    *titleLabel;
@property(nonatomic, strong) UITextField *emailTextField;

@end

@implementation EmailCell

+(instancetype)customInitWithTableView:(UITableView *)tableView  reuseIdentifier:(NSString *)identifier{
    EmailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[EmailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [DVFactory createLabelWithFrame:CGRectMake(FitFloat(15), FitFloat(11), FitFloat(160), FitFloat(19)) title:nil font:17 textAlign:NSTextAlignmentLeft];
        _titleLabel.textColor = RGBFromHex(0x555555);
        
        _emailTextField = [DVFactory createTextFieldWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom +FitFloat(14), UI_WIDTH - _titleLabel.left, FitFloat(28)) text:nil textAlign:NSTextAlignmentLeft textColor:RGBFromHex(0x55bdf9) font:17];
        _emailTextField.placeholder = @"请输入邮箱地址...";
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTextField.delegate = self;
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_emailTextField];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
     return YES;
}


@end


@interface DVEmailNotifyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *infoArr;
@property(nonatomic, strong) UITableView *myTableView;
@property (nonatomic, assign)BOOL notifyIsOn;
@property(nonatomic, strong) UISwitch *mySwitch;
@property (nonatomic, assign)BOOL hasClickAddEmail;


@end

@implementation DVEmailNotifyVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear) name:UIKeyboardWillHideNotification object:nil];

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
  
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else  {
        if (_notifyIsOn) {
            return _infoArr.count + 2;
        }else {
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
        cell.textLabel.text = @"邮件通知 (剩余40条)....";
        
        return cell;
    }else {
        if (indexPath.row == _infoArr.count + 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"footCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"footCell"];
            }
            cell.backgroundColor = RGBFromHex(0xefeff4);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, FitFloat(75), 200, 40)];
            [btn setBackgroundColor:[UIColor yellowColor]];
            [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
            
             NSString *titleStr = @"NotifyTelTip";
            CGFloat width =  UI_WIDTH - FitFloat(14)*2;
            CGFloat height  =  [DVUtil textSizeCalculateFrom:titleStr InWidth:width FontSize:FitFont(16)].height;
 
            UILabel *label = [DVFactory createLabelWithFrame:CGRectMake(FitFloat(14), btn.bottom + FitFloat(38), UI_WIDTH - FitFloat(14)*2,height+FitFloat(10)) title:titleStr font:16 textAlign:NSTextAlignmentLeft];
            label.centerX = UI_CenterX;
            label.textColor = RGBFromHex(0x777676);
            label.text = titleStr;
            label.numberOfLines = 0;
            [cell addSubview:label];
            
            return cell;
          }else if (indexPath.row == _infoArr.count) {
            if (_hasClickAddEmail) {
                EmailCell *cell = [EmailCell customInitWithTableView:tableView  reuseIdentifier:@"AddEmailCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
                if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)])  {
                    [_myTableView setLayoutMargins:UIEdgeInsetsZero];
                }
    
                cell.titleLabel.text = [NSString stringWithFormat:@"通知%ld",indexPath.row+1];
                return  cell;
            }else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddTableViewCell"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddTableViewCell"];
                }
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
                if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)])  {
                    [_myTableView setLayoutMargins:UIEdgeInsetsZero];
                }
                cell.textLabel.font = FitFont(17);
                cell.textLabel.textColor = RGBFromHex(0x2c85f3);
                cell.textLabel.text = @"添加邮箱";
                return cell;
             }
         }else {
             EmailCell *cell = [EmailCell customInitWithTableView:tableView reuseIdentifier:@"EmailCell"];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
             if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)])  {
                 [_myTableView setLayoutMargins:UIEdgeInsetsZero];
             }
             
             NSDictionary *infoDict = _infoArr[indexPath.row];
             cell.titleLabel.text = infoDict[@"title"];
             cell.emailTextField.text = infoDict[@"subTitle"];
             return  cell;
         }
    }

}


-(void)clickBtn {
    
}

-(void)switchState {
    if (_mySwitch.isOn) {
        _notifyIsOn = YES;
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0 ; i < _infoArr.count+2;  i ++) {
            [arr addObject:[NSIndexPath indexPathForRow:i  inSection:1]];
        }
        [_myTableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationTop];
        
    }else  {
        _notifyIsOn = NO;
        
        NSMutableArray *arr = [NSMutableArray array];
         for (NSInteger i = 0 ; i < _infoArr.count+2;  i ++) {
            [arr addObject:[NSIndexPath indexPathForRow:i  inSection:1]];
        }
        [_myTableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationTop];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return FitFloat(45);
    }else {
        if (indexPath.row == _infoArr.count && _hasClickAddEmail == NO) {
            return FitFloat(45);
        }else if(indexPath.row == _infoArr.count + 1) {
            return FitFloat(200);
        }else {
            return FitFloat(72);
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
     return 0.01;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FitFloat(10);
}


#pragma mark - delegaete
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == _infoArr.count && _hasClickAddEmail == NO) {
        _hasClickAddEmail = YES;
        [_myTableView reloadData];
    }
}


#pragma mark - 键盘
- (void) keyboardWasShown:(NSNotification *) notif
{
    //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    
    for (NSInteger i = 0 ; i < _infoArr.count + 1; i ++) {
        if (i == _infoArr.count  && _hasClickAddEmail == NO) {
            continue;
        }
        EmailCell *cell = [_myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
        if (cell.emailTextField.isFirstResponder) {
            
            CGFloat headViewHeight = [self tableView:_myTableView heightForHeaderInSection:0];
            CGFloat rowHeight = FitFloat(72);
            CGFloat y = headViewHeight*2 + rowHeight*(1+1+i) - (UI_HEIGHT - height - FitFloat(20)) ; // y > 0 键盘有可能挡住cell.
            if (_myTableView.contentOffset.y- (UI_HEIGHT - height - FitFloat(20)) < 0 && y > 0 ) {
                [_myTableView setContentOffset:CGPointMake(0, y) animated:YES];
             }
            break;
        }
    }
}

-(void)keyboardWillDisappear {
    if (_myTableView.contentOffset.y > _myTableView.contentSize.height - UI_HEIGHT) {
        [_myTableView setContentOffset:CGPointMake(0, _myTableView.contentSize.height - UI_HEIGHT) animated:YES];
    }
}

-(void)initInfoArr {
    
    NSArray *emailArr = @[@"232425234",@"2324444344",@"2324444344",@"2324444344"];
    
    _infoArr = [NSMutableArray array];
    for (NSInteger i = 0; i < emailArr.count; i ++) {
        NSString *email = emailArr[i];
         NSDictionary *dict = @{
                               @"title" : [NSString stringWithFormat:@"通知%ld",i+1],
                               @"subTitle" : email
                               };
        [_infoArr addObject:dict];
    }


}


@end

