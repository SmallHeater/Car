//
//  MrCarShopListVC.m
//  Car
//
//  Created by mac on 2019/12/17.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "MrCarShopListVC.h"
#import "SHTabView.h"
#import "CarTestCell.h"
#import "UserInforController.h"
@interface MrCarShopListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * baseTable;
@property (nonatomic,strong) NSMutableArray * datas;
@end

@implementation MrCarShopListVC
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas=[NSMutableArray new];
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
    [_headIV sd_setImageWithURL:[NSURL URLWithString:_passModel.logo] placeholderImage:nil];
    [_topView addSubview:_headIV];
    
    UILabel* _nameLab=[UILabel new];
    _nameLab.frame=CGRectMake(75, 0, 200, 65);
    _nameLab.font=[UIFont systemFontOfSize:15];
    _nameLab.textAlignment=NSTextAlignmentLeft;
    _nameLab.textColor=[UIColor grayColor];
    _nameLab.text=[NSString stringWithFormat:@"%@",_passModel.name];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商户列表";
    self.view.backgroundColor=[UIColor whiteColor];
    self.baseTable.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.baseTable];
    [self topView];
    [self requestData];
    self.extendedLayoutIncludesOpaqueBars = YES;

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemTap)];
    // Do any additional setup after loading the view.
}
- (void)requestData{
    
    __weak typeof(self) weakSelf = self;
    [FTIndicator showProgressWithMessage:@""];
    NSDictionary * bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"car_logo_id":_passModel.id};
    [[CarChatFuntion shareInterface] requetPostInterface:CategoryShopUrl withParameter:bodyParameters.mutableCopy handler:^(NSDictionary * _Nonnull info, InterfaceStatusModel * _Nonnull infoModel) {
        NSLog(@"-----%@",info);
        if ([[info objectForKey:@"code"] integerValue]==1) {
            [FTIndicator dismissProgress];
            NSDictionary* dataDic=[info objectForKey:@"data"];
            NSArray* arr=[dataDic objectForKey:@"shop"];
            self.datas=[[NSMutableArray alloc] initWithArray:arr];
            [self.baseTable reloadData];
            
            
        }else{
            [FTIndicator showErrorWithMessage:[info objectForKey:@"msg"]];
        }
    }];

    
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"CarTestCell";
    CarTestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary* dic=self.datas[indexPath.row];
    [cell.markIV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"avatar"]]];
    cell.titleLab.text=[dic objectForKey:@"name"];
    cell.detailLab.text=[dic objectForKey:@"notice"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary* dic=self.datas[indexPath.row];
    TUIConversationCellData *data = [[TUIConversationCellData alloc] init];
    data.convId =[dic objectForKey:@"phone"];
    data.convType = TIM_C2C;
    data.title = [dic objectForKey:@"name"];
    data.avatarUrl=[NSURL URLWithString:[dic objectForKey:@"avatar"]];
    
    
    CarChatVC *chat = [[CarChatVC alloc] init];
    chat.hidesBottomBarWhenPushed=YES;
    chat.conversationData = data;
    [self.navigationController pushViewController:chat animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view=[UIView new];
    view.backgroundColor=RGB(245, 245, 245);
    UILabel* _nameLab=[UILabel new];
    _nameLab.frame=CGRectMake(15, 0, 200, 35);
    _nameLab.font=[UIFont systemFontOfSize:12];
    _nameLab.textAlignment=NSTextAlignmentLeft;
    _nameLab.textColor=RGB(153, 153, 153);
    _nameLab.text=[NSString stringWithFormat:@"%@配件商列表",_passModel.name];
    [view addSubview:_nameLab];
    
    
    UILabel* rigthLab=[UILabel new];
    rigthLab.frame=CGRectMake(Screen_Width-80, 7.5, 65, 20);
    rigthLab.font=[UIFont systemFontOfSize:11];
    rigthLab.textAlignment=NSTextAlignmentRight;
    rigthLab.textColor=[UIColor grayColor];
    rigthLab.text=@"返现3%";
    [view addSubview:rigthLab];
    rigthLab.backgroundColor=RGB(229, 241, 255);
    rigthLab.layer.masksToBounds=YES;
    rigthLab.layer.cornerRadius=5;
    
    UIImageView* _headIV=[UIImageView new];
    _headIV.image=[UIImage imageNamed:@"shop_money"];
    _headIV.frame=CGRectMake(7, 3, 13, 14);
    [rigthLab addSubview:_headIV];
    
    //
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* view=[UIView new];
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .001f;
}
//-------------------------------------------------------------------------------------------------------
#pragma mark getter and setter
-(UITableView *)baseTable
{
    if (!_baseTable) {
        
        _baseTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 65+[SHUIScreenControl navigationBarHeight], Screen_Width, self.view.frame.size.height-65-[SHUIScreenControl navigationBarHeight]) style:UITableViewStyleGrouped];
        _baseTable.delegate = self;
        _baseTable.dataSource = self;
        _baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_baseTable registerNib:[UINib nibWithNibName:@"CarTestCell" bundle:nil] forCellReuseIdentifier:@"CarTestCell"];
        
    }
    return _baseTable;
}
@end
