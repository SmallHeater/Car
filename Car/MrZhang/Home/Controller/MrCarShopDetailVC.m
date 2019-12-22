//
//  MrCarShopDetailVC.m
//  Car
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MrCarShopDetailVC.h"
#import "CarShopListCell.h"
#import "UserInforController.h"
#import "ShopDetailTopCell.h"
#import "ShopBtomCell.h"
@interface MrCarShopDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * baseTable;
@property (nonatomic,strong) NSMutableDictionary * datas;
@end

@implementation MrCarShopDetailVC

-(NSMutableDictionary *)datas{
    if (!_datas) {
        _datas=[NSMutableDictionary new];
    }
    return _datas;
}
-(void)topView{
    UIView* _topView=[UIView new];
    _topView.frame=CGRectMake(0, [SHUIScreenControl navigationBarHeight], Screen_Width, 65);
    _topView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_topView];
    
    UIImageView* _headIV=[UIImageView new];
    _headIV.frame=CGRectMake(15, 9, 47, 47);
   // [_headIV sd_setImageWithURL:[NSURL URLWithString:_passModel.logo] placeholderImage:nil];
    [_topView addSubview:_headIV];
    
    UILabel* _nameLab=[UILabel new];
    _nameLab.frame=CGRectMake(75, 0, 200, 65);
    _nameLab.font=[UIFont systemFontOfSize:15];
    _nameLab.textAlignment=NSTextAlignmentLeft;
    _nameLab.textColor=[UIColor grayColor];
   // _nameLab.text=[NSString stringWithFormat:@"%@",_passModel.name];
    [_topView addSubview:_nameLab];
    
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(Screen_Width- 85, 17.5, 70, 30);
    [btn setTitle:@"一键询价" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    btn.backgroundColor=RGB(23, 124, 239);
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=5;
    [_topView addSubview:btn];
    
    
    
}
-(void)leftBarButtonItemTap{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.extendedLayoutIncludesOpaqueBars = NO;
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[self WFUICreateImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *titleDict = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationController.navigationBar.titleTextAttributes = titleDict;//标题字体
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];//左右按钮颜色
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil] forState:UIControlStateNormal];
}
-(UIImage *)WFUICreateImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商家详情";
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    [self.view addSubview:self.baseTable];
   // self.navigationController.navigationBar.barTintColor = RGBA(23, 124, 239, 1);
    [self.navigationController.navigationBar setBackgroundImage:[self WFUICreateImageWithColor:RGBA(23, 124, 239, 1)] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleLightContent;
    
    NSDictionary *titleDict = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = titleDict;//标题字体
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//左右按钮颜色
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
    
    
    [self requestData];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemTap)];
    // Do any additional setup after loading the view.
}
- (void)requestData{
    
    __weak typeof(self) weakSelf = self;
    [FTIndicator showProgressWithMessage:@""];
    NSDictionary * bodyParameters = @{@"phone":_passID};
    [[CarChatFuntion shareInterface] requetPostInterface:CategoryShopDetail withParameter:bodyParameters.mutableCopy handler:^(NSDictionary * _Nonnull info, InterfaceStatusModel * _Nonnull infoModel) {
        NSLog(@"-----%@",info);
        if ([[info objectForKey:@"code"] integerValue]==1) {
            [FTIndicator dismissProgress];
            NSDictionary* dataDic=[info objectForKey:@"data"];
            NSDictionary* ooDic=[dataDic objectForKey:@"shopPart"];
            self.datas=[[NSMutableDictionary alloc] initWithDictionary:ooDic];
            [self.baseTable reloadData];
            
            
        }else{
            [FTIndicator showErrorWithMessage:[info objectForKey:@"msg"]];
        }
    }];
    
    
}
#pragma mark delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        NSString *cellIdentifier = @"ShopDetailTopCell";
        ShopDetailTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.datas.count!=0) {
            NSString* imageStr=[self.datas objectForKey:@"images"];
            NSArray* arr=[imageStr componentsSeparatedByString:@","];
            if (arr.count==1) {
                [cell.markLeftIV sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:nil];
                [cell.markRightIV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
            }
            if (arr.count==2) {
                [cell.markLeftIV sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:nil];
                [cell.markRightIV sd_setImageWithURL:[NSURL URLWithString:arr[1]] placeholderImage:nil];
            }
            cell.shopNameLab.text=[NSString stringWithFormat:@"%@",[self.datas objectForKey:@"name"]];
            cell.addressLab.text=[NSString stringWithFormat:@"%@",[self.datas objectForKey:@"address"]];
            [cell.avatarIV sd_setImageWithURL:[NSURL URLWithString:[self.datas objectForKey:@"avatar"]]];
            
            cell.nameLab.text=[NSString stringWithFormat:@"%@",[self.datas objectForKey:@"contact"]];
            cell.phoneLab.text=[NSString stringWithFormat:@"%@",[self.datas objectForKey:@"phone"]];
            cell.moneyLab.text=[NSString stringWithFormat:@"%@元",[self.datas objectForKey:@"deposit"]];
            cell.orderLab.text=[NSString stringWithFormat:@"%@单",[self.datas objectForKey:@"salesnum"]];
        }
        return cell;
    }
    NSString *cellIdentifier = @"ShopBtomCell";
    ShopBtomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.equalIV.backgroundColor=[CarChatFuntion GradualChangeColor:@[RGB(150, 251, 114),RGB(222, 255, 0),RGB(245, 97, 57)] ViewSize:cell.equalIV.frame.size gradientType:GradientTypeLeftToRight];
    
    cell.serviceIV.backgroundColor=[CarChatFuntion GradualChangeColor:@[RGB(150, 251, 114),RGB(222, 255, 0),RGB(245, 97, 57)] ViewSize:cell.equalIV.frame.size gradientType:GradientTypeLeftToRight];
    
    cell.sendIV.backgroundColor=[CarChatFuntion GradualChangeColor:@[RGB(150, 251, 114),RGB(222, 255, 0),RGB(245, 97, 57)] ViewSize:cell.equalIV.frame.size gradientType:GradientTypeLeftToRight];
    

//    rgba(150, 251, 114, 1)RGBA
//    rgba(222, 255, 0, 1)RGBA
//    rgba(245, 97, 57, 1)
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 488;
    }
    return 170;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view=[UIView new];
    view.backgroundColor=RGB(245, 245, 245);
    
    //
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* view=[UIView new];
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .001f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
//-------------------------------------------------------------------------------------------------------
#pragma mark getter and setter
-(UITableView *)baseTable
{
    if (!_baseTable) {
        
        _baseTable = [[UITableView alloc]initWithFrame:CGRectMake(0, [SHUIScreenControl navigationBarHeight], Screen_Width, self.view.frame.size.height-[SHUIScreenControl navigationBarHeight]) style:UITableViewStyleGrouped];
        _baseTable.delegate = self;
        _baseTable.dataSource = self;
        _baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_baseTable registerNib:[UINib nibWithNibName:@"ShopDetailTopCell" bundle:nil] forCellReuseIdentifier:@"ShopDetailTopCell"];
        
        [_baseTable registerNib:[UINib nibWithNibName:@"ShopBtomCell" bundle:nil] forCellReuseIdentifier:@"ShopBtomCell"];
        
    }
    return _baseTable;
}

@end
