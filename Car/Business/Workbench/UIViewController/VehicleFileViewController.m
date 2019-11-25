//
//  VehicleFileViewController.m
//  Car
//
//  Created by mac on 2019/8/25.
//  Copyright © 2019 SmallHeat. All rights reserved.
//

#import "VehicleFileViewController.h"
#import "SearchBarTwoCell.h"
#import "VehicleFileCell.h"
#import "FastPickUpViewController.h"
#import "VehicleFileDetailViewController.h"
#import "UserInforController.h"
#import "VehicleFileModel.h"

@interface VehicleFileViewController ()

//添加按钮
@property (nonatomic,strong) UIButton * addBtn;
@property (nonatomic,assign) NSUInteger page;
@property (nonatomic,strong) NSString * content;

@end

@implementation VehicleFileViewController

#pragma mark  ----  懒加载

-(UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            FastPickUpViewController * vc = [[FastPickUpViewController alloc] initWithTitle:@"快速接车" andIsShowBackBtn:YES];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _addBtn;
}

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    
    //继承SHBaseTableViewController使用时，要将本方法提前，保证先添加tableView,再添加导航
    [self refreshViewType:BTVCType_AddTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 0;
    [self drawUI];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestListDataWithContent:@""];
}

#pragma mark  ----  代理

#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellHeight = 0;
    if (indexPath.row == 0) {
        
        cellHeight = 82;
    }
    else{
        
        cellHeight = 104;
    }
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != 0) {
        
        VehicleFileModel * model = self.dataArray[indexPath.row - 1];
        VehicleFileDetailViewController * vc = [[VehicleFileDetailViewController alloc] initWithTitle:@"车辆档案" andShowNavgationBar:YES andIsShowBackBtn:YES andTableViewStyle:UITableViewStylePlain andIsShowHead:NO andIsShowFoot:NO];
        vc.vehicleFileModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString * firstCellId = @"SearchBarTwoCell";
        SearchBarTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
        if (!cell) {
            
            __weak typeof(self) weakSelf = self;
            cell = [[SearchBarTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellId];
            [[cell rac_valuesForKeyPath:@"searchBar.text" observer:self] subscribeNext:^(id  _Nullable x) {
               
                if (![NSString strIsEmpty:x]) {
                    
                    [weakSelf requestListDataWithContent:x];
                }
            }];
        }
        
        return cell;
    }
    else{
        
        static NSString * secondCellId = @"VehicleFileCell";
        VehicleFileCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            
            cell = [[VehicleFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellId];
        }
        
        VehicleFileModel * model = self.dataArray[indexPath.row - 1];
        [cell showDataWithDic:@{@"numberPlate":model.license_number,@"name":model.contacts,@"carModel":[NSString repleaseNilOrNull:model.type],@"phoneNumber":model.phone}];
        return cell;
    }
    
    return nil;
}

#pragma mark  ----  自定义函数

-(void)drawUI{
    
    [self.navigationbar addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-12);
        make.bottom.offset(-12);
        make.width.height.offset(22);
    }];
}


-(void)requestListDataWithContent:(NSString *)content{
    
    NSDictionary * bodyParameters;
    if ([NSString strIsEmpty:content]) {
        
        bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID};
    }
    else{
        
        bodyParameters = @{@"user_id":[UserInforController sharedManager].userInforModel.userID,@"content":content};
    }
    
    self.content = content;
    
    NSDictionary * configurationDic = @{@"requestUrlStr":Carlist,@"bodyParameters":bodyParameters};
    __weak VehicleFileViewController * weakSelf = self;
    [SHRoutingComponent openURL:REQUESTDATA withParameter:configurationDic callBack:^(NSDictionary *resultDic) {
        
        if (![resultDic.allKeys containsObject:@"error"]) {
            
            //成功的
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)resultDic[@"response"];
            if (response && [response isKindOfClass:[NSHTTPURLResponse class]] && response.statusCode == 200) {
                
                id dataId = resultDic[@"dataId"];
                NSDictionary * dic = (NSDictionary *)dataId;
                NSDictionary * dataDic = dic[@"data"];
               
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]] && [dataDic.allKeys containsObject:@"list"]) {
                    
                    if (self.page == 0) {
                        
                        [weakSelf.dataArray removeAllObjects];
                    }
                    
                    NSArray * list = dataDic[@"list"];
                    
                    if (list.count == MAXCOUNT) {
                        
                        weakSelf.page++;
                    }
                    else{
                        
                        weakSelf.tableView.mj_footer = nil;
                    }
                    
                    for (NSDictionary * dic in list) {
                        
                        VehicleFileModel * model = [VehicleFileModel mj_objectWithKeyValues:dic];
                        [weakSelf.dataArray addObject:model];
                    }
                }
                
                [weakSelf refreshViewType:BTVCType_RefreshTableView];
            }
            else{
            }
        }
        else{
            
            //失败的
        }
    }];
}
    
//下拉刷新(回调函数)
-(void)loadNewData{
    
    self.page = 0;
    [self requestListDataWithContent:self.content];
    [super loadNewData];
}
//上拉加载(回调函数)
-(void)loadMoreData{
    
    [self requestListDataWithContent:self.content];
    [super loadMoreData];
}
@end
